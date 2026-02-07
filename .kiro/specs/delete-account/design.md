# Design Document: Delete Account Feature

## Overview

This design document outlines the implementation of the delete account feature for therapists in the NaviCare application. The feature follows the existing clean architecture pattern with data/domain/presentation layers and integrates seamlessly with the current profile screen implementation.

The implementation will add a delete account option to the profile screen's "More" section, provide a confirmation dialog to prevent accidental deletion, call the backend DELETE endpoint, and handle post-deletion cleanup including logout and navigation.

## Architecture

The delete account feature follows the application's feature-based clean architecture:

```
lib/feature/profile/
├── data/
│   ├── data_sources/
│   │   └── profile_remote_data_source.dart (add deleteAccount method)
│   ├── models/
│   │   └── profile_models.dart (add DeleteAccountResponse if needed)
│   └── repositories/
│       └── profile_repository_impl.dart (add deleteAccount implementation)
├── domain/
│   ├── entities/
│   └── repositories/
│       └── profile_repository.dart (add deleteAccount interface)
└── presentation/
    ├── pages/
    │   └── profile_screen.dart (add UI and dialog)
    └── providers/
        └── profile_provider.dart (add delete account state management)
```

### Layer Responsibilities

**Data Layer:**
- `ProfileRemoteDataSource`: Add `deleteAccount()` method with @DELETE annotation targeting `/api/v1/account/therapist`
- `ProfileRepositoryImpl`: Implement the repository interface, handle API calls and error mapping

**Domain Layer:**
- `ProfileRepository`: Define the abstract `deleteAccount()` method returning `Future<Either<Failure, void>>`

**Presentation Layer:**
- `ProfileScreen`: Add delete account list tile and confirmation dialog
- State management: Use existing auth provider for logout, router for navigation

## Components and Interfaces

### 1. Data Source (ProfileRemoteDataSource)

Add the following method to `profile_remote_data_source.dart`:

```dart
@DELETE('/api/v1/account/therapist')
Future<void> deleteAccount();
```

This follows the existing Retrofit pattern used for other API calls in the data source.

### 2. Repository Interface (ProfileRepository)

Create or update `lib/feature/profile/domain/repositories/profile_repository.dart`:

```dart
abstract class ProfileRepository {
  Future<Either<Failure, void>> deleteAccount();
  // ... existing methods
}
```

### 3. Repository Implementation (ProfileRepositoryImpl)

Create or update `lib/feature/profile/data/repositories/profile_repository_impl.dart`:

```dart
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  
  ProfileRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }
  
  Failure _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      return const Failure.networkFailure('Network connection error');
    }
    
    final statusCode = error.response?.statusCode;
    if (statusCode != null && statusCode >= 500) {
      return const Failure.serverFailure('Server error occurred');
    }
    
    return Failure.serverFailure(
      error.response?.data['message'] ?? 'Failed to delete account'
    );
  }
}
```

### 4. Profile Provider (ProfileProvider)

Create or update `lib/feature/profile/presentation/providers/profile_provider.dart`:

```dart
@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.success() = _Success;
  const factory ProfileState.error(String message) = _Error;
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _profileRepository;
  
  ProfileNotifier(this._profileRepository) : super(const ProfileState.initial());
  
  Future<void> deleteAccount() async {
    state = const ProfileState.loading();
    
    final result = await _profileRepository.deleteAccount();
    
    result.fold(
      (failure) => state = ProfileState.error(_getErrorMessage(failure)),
      (_) => state = const ProfileState.success(),
    );
  }
  
  String _getErrorMessage(Failure failure) {
    return failure.when(
      serverFailure: (message) => message,
      networkFailure: (message) => 'Network error: $message',
      authFailure: (message) => message,
      unknownFailure: (message) => 'Unknown error: $message',
    );
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remoteDataSource = ref.read(profileRemoteDataSourceProvider);
  return ProfileRepositoryImpl(remoteDataSource: remoteDataSource);
});

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final repository = ref.read(profileRepositoryProvider);
  return ProfileNotifier(repository);
});
```

### 5. UI Components (ProfileScreen)

Add the following to `profile_screen.dart`:

**Delete Account List Tile:**
```dart
_buildListTile(
  icon: Icons.delete_outline,
  title: AppLocalizations.of(context)!.deleteAccount,
  onTap: () => _showDeleteAccountDialog(context),
  isLogout: true, // Use same red styling as logout
),
```

**Delete Account Dialog:**
```dart
Future<void> _showDeleteAccountDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(AppLocalizations.of(context)!.deleteAccount),
      content: Text(
        AppLocalizations.of(context)!.deleteAccountWarning,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await _handleDeleteAccount();
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.error,
          ),
          child: Text(AppLocalizations.of(context)!.delete),
        ),
      ],
    ),
  );
}

Future<void> _handleDeleteAccount() async {
  // Show loading indicator
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  
  // Call delete account
  await ref.read(profileProvider.notifier).deleteAccount();
  
  // Check result
  final state = ref.read(profileProvider);
  
  if (mounted) {
    Navigator.pop(context); // Dismiss loading
    
    state.when(
      initial: () {},
      loading: () {},
      success: () async {
        // Logout and navigate
        await ref.read(authProvider.notifier).logout();
        ref.read(routerProvider).go('/login');
        final socketService = ref.read(socketServiceProvider);
        socketService.disconnect();
      },
      error: (message) {
        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text(AppLocalizations.of(context)!.error),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.ok),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

## Data Models

No new data models are required. The DELETE endpoint returns void/empty response on success. Error responses are handled through the existing `Failure` class in the core error handling system.

If the API returns a response body, we can add:

```dart
@freezed
class DeleteAccountResponse with _$DeleteAccountResponse {
  const factory DeleteAccountResponse({
    String? message,
    int? statusCode,
  }) = _DeleteAccountResponse;

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountResponseFromJson(json);
}
```

However, this is optional and only needed if the backend returns structured data.


## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

For this feature, most of the correctness validation will be done through example-based tests (unit tests and widget tests) rather than property-based tests, as the feature is primarily UI-focused with specific interaction flows. However, we can identify some key properties:

### Property 1: Error handling preserves authentication state

*For any* error that occurs during account deletion (network error, server error, timeout), the user's authentication state should remain unchanged and the user should remain logged in.

**Validates: Requirements 5.3**

### Property 2: Successful deletion triggers complete cleanup

*For any* successful account deletion response, the system should always execute the complete cleanup sequence: logout, socket disconnection, and navigation to login screen.

**Validates: Requirements 4.1, 4.2**

### Property 3: API error mapping consistency

*For any* DioException thrown by the delete account API call, the error should be mapped to an appropriate Failure type (NetworkFailure for connection issues, ServerFailure for server errors) with a user-friendly message.

**Validates: Requirements 3.4, 3.5, 5.1, 5.2**

## Error Handling

The delete account feature implements comprehensive error handling at multiple levels:

### Network Layer Errors

**Connection Errors:**
- Timeout errors (connection timeout, receive timeout)
- Connection errors (no internet, DNS failure)
- Mapped to `Failure.networkFailure` with message: "Network connection error"

**Server Errors:**
- HTTP 5xx status codes
- Mapped to `Failure.serverFailure` with message: "Server error occurred"

**Client Errors:**
- HTTP 4xx status codes
- Mapped to `Failure.serverFailure` with server-provided message or default: "Failed to delete account"

### UI Layer Error Handling

**Error Display:**
- Errors are displayed in an AlertDialog with white background
- Error message is shown in the dialog content
- User can dismiss the error with an "OK" button
- After dismissal, user remains on the profile screen

**Loading State:**
- Loading indicator (CircularProgressIndicator) shown during API call
- Loading dialog is non-dismissible (barrierDismissible: false)
- Loading dialog is automatically dismissed when result is received

**State Preservation:**
- On error, authentication state is preserved
- User remains logged in
- Profile screen remains accessible
- User can retry deletion if desired

### Repository Layer Error Handling

The repository implementation catches and handles:
1. `DioException` - HTTP and network errors from Retrofit
2. Generic exceptions - Unexpected errors mapped to `Failure.unknownFailure`

All errors are converted to `Either<Failure, void>` for functional error handling.

## Testing Strategy

The delete account feature will be tested using a combination of unit tests, widget tests, and integration tests. Property-based testing is not heavily applicable here due to the UI-focused nature of the feature, but we will use property tests for the error handling logic.

### Unit Tests

**Data Layer Tests:**
- Test `ProfileRemoteDataSource.deleteAccount()` calls correct endpoint
- Test repository error mapping for different DioException types
- Test repository success case returns Right(null)
- Test repository network error returns NetworkFailure
- Test repository server error returns ServerFailure

**Provider Tests:**
- Test ProfileNotifier state transitions (initial → loading → success)
- Test ProfileNotifier state transitions (initial → loading → error)
- Test error message formatting for different Failure types

### Widget Tests

**Profile Screen Tests:**
- Test delete account option is visible in More section
- Test delete account option appears after logout option
- Test delete account option uses error color styling
- Test tapping delete account shows confirmation dialog
- Test confirmation dialog has correct title and warning message
- Test confirmation dialog has Cancel and Delete buttons
- Test tapping Cancel closes dialog without action
- Test tapping Delete initiates deletion process

**Dialog Tests:**
- Test delete account dialog displays warning text
- Test dialog buttons are properly styled
- Test dialog can be dismissed with Cancel

### Integration Tests

**Complete Flow Tests:**
- Test successful deletion flow: tap → confirm → API call → logout → navigate
- Test cancellation flow: tap → cancel → dialog closes → no API call
- Test network error flow: tap → confirm → network error → error dialog → remain logged in
- Test server error flow: tap → confirm → server error → error dialog → remain logged in

### Property-Based Tests

**Property Test 1: Error handling preserves authentication state**
- Generate random error types (network, server, timeout)
- For each error, verify user remains authenticated after error handling
- Verify profile screen remains accessible
- **Feature: delete-account, Property 1: For any error that occurs during account deletion, the user's authentication state should remain unchanged**
- Run with minimum 100 iterations

**Property Test 2: API error mapping consistency**
- Generate random DioException instances with different error types
- For each exception, verify it maps to the correct Failure type
- Verify error messages are user-friendly (non-technical)
- **Feature: delete-account, Property 3: For any DioException thrown by the delete account API call, the error should be mapped to an appropriate Failure type**
- Run with minimum 100 iterations

### Test Configuration

- Use Flutter's built-in testing framework for unit and widget tests
- Use mockito or mocktail for mocking dependencies
- Use flutter_test for widget testing
- For property-based tests, consider using the `test` package with custom generators or a Dart property-based testing library
- Minimum 100 iterations for each property-based test
- Each property test must reference its design document property in a comment

### Mock Dependencies

Tests will mock:
- `ProfileRemoteDataSource` for repository tests
- `ProfileRepository` for provider tests
- `AuthProvider` for integration tests
- `GoRouter` for navigation tests
- `SocketService` for socket disconnection tests
