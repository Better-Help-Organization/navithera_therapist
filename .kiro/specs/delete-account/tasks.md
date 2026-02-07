# Implementation Plan: Delete Account Feature

## Overview

This implementation plan breaks down the delete account feature into discrete coding tasks following the clean architecture pattern. Each task builds incrementally, starting with the data layer, moving through the domain layer, and finishing with the presentation layer. The implementation follows the existing patterns in the NaviCare therapist application.

## Tasks

- [x] 1. Set up domain layer interfaces
  - Create `lib/feature/profile/domain/repositories/profile_repository.dart` if it doesn't exist
  - Add abstract `deleteAccount()` method returning `Future<Either<Failure, void>>`
  - Ensure the interface follows the existing repository pattern in the codebase
  - _Requirements: 6.1, 6.4_

- [x] 2. Implement data layer
  - [x] 2.1 Add DELETE endpoint to ProfileRemoteDataSource
    - Add `@DELETE('/api/v1/account/therapist')` method to `profile_remote_data_source.dart`
    - Method signature: `Future<void> deleteAccount()`
    - Run code generation: `flutter pub run build_runner build --delete-conflicting-outputs`
    - _Requirements: 3.1, 3.2, 6.1, 6.2, 6.5_
  
  - [x] 2.2 Create ProfileRepositoryImpl
    - Create `lib/feature/profile/data/repositories/profile_repository_impl.dart` if it doesn't exist
    - Implement `deleteAccount()` method with error handling
    - Map DioException types to appropriate Failure types (NetworkFailure, ServerFailure)
    - Handle connection timeouts, receive timeouts, and connection errors as NetworkFailure
    - Handle HTTP 5xx errors as ServerFailure
    - Handle other errors with server-provided messages or default message
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5_
  
  - [ ]* 2.3 Write unit tests for repository error mapping
    - Test network error mapping (timeout, connection error)
    - Test server error mapping (5xx status codes)
    - Test client error mapping (4xx status codes)
    - Test success case returns Right(null)
    - _Requirements: 3.4, 3.5_

- [x] 3. Implement presentation layer state management
  - [x] 3.1 Create ProfileProvider with state management
    - Create `lib/feature/profile/presentation/providers/profile_provider.dart` if it doesn't exist
    - Define ProfileState using freezed: initial, loading, success, error
    - Implement ProfileNotifier with `deleteAccount()` method
    - Create profileRepositoryProvider
    - Create profileProvider StateNotifierProvider
    - _Requirements: 3.1, 3.3, 3.4, 3.5_
  
  - [ ]* 3.2 Write unit tests for ProfileNotifier
    - Test state transitions: initial → loading → success
    - Test state transitions: initial → loading → error
    - Test error message formatting for different Failure types
    - _Requirements: 3.3, 3.4, 3.5_
  
  - [ ]* 3.3 Write property test for error handling state preservation
    - **Property 1: Error handling preserves authentication state**
    - Generate random error types and verify authentication state remains unchanged
    - **Validates: Requirements 5.3**

- [ ] 4. Checkpoint - Ensure data and domain layers are working
  - Ensure all tests pass, ask the user if questions arise.

- [x] 5. Implement UI components
  - [x] 5.1 Add delete account list tile to ProfileScreen
    - Add delete account option in the "More" section after logout
    - Use `_buildListTile` with `Icons.delete_outline`
    - Set `isLogout: true` to use red/error color styling
    - Wire up to `_showDeleteAccountDialog` method
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5_
  
  - [x] 5.2 Implement delete account confirmation dialog
    - Create `_showDeleteAccountDialog` method in ProfileScreen
    - Use AlertDialog with white background
    - Add title using localization: `AppLocalizations.of(context)!.deleteAccount`
    - Add warning message using localization: `AppLocalizations.of(context)!.deleteAccountWarning`
    - Add Cancel button that closes dialog
    - Add Delete button with error color that calls `_handleDeleteAccount`
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 2.6_
  
  - [x] 5.3 Implement delete account handler
    - Create `_handleDeleteAccount` method in ProfileScreen
    - Show non-dismissible loading dialog with CircularProgressIndicator
    - Call `ref.read(profileProvider.notifier).deleteAccount()`
    - Handle success: dismiss loading, call logout, navigate to /login, disconnect socket
    - Handle error: dismiss loading, show error dialog with message, keep user logged in
    - Use existing authProvider, routerProvider, and socketServiceProvider
    - _Requirements: 3.3, 4.1, 4.2, 4.3, 4.4, 5.1, 5.2, 5.3, 5.5_
  
  - [ ]* 5.4 Write widget tests for ProfileScreen delete account UI
    - Test delete account option is visible in More section
    - Test delete account option appears after logout option
    - Test delete account option uses error color styling
    - Test tapping delete account shows confirmation dialog
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5_
  
  - [ ]* 5.5 Write widget tests for delete account dialog
    - Test dialog displays correct title and warning message
    - Test dialog has Cancel and Delete buttons
    - Test Cancel button closes dialog without action
    - Test Delete button initiates deletion process
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 2.6_

- [x] 6. Add localization strings
  - Add `deleteAccount` string to localization files (en, am, om, ti, so)
  - Add `deleteAccountWarning` string with permanent deletion warning
  - Add `error` string if not already present
  - Add `ok` string if not already present
  - Add `delete` string if not already present
  - Ensure strings are added to all supported languages
  - _Requirements: 1.1, 2.1, 2.2_

- [ ] 7. Integration testing
  - [ ]* 7.1 Write integration test for successful deletion flow
    - Test complete flow: tap → confirm → API call → logout → navigate to login
    - Mock ProfileRemoteDataSource, AuthProvider, Router, SocketService
    - Verify all steps execute in correct order
    - **Validates: Requirements 3.3, 4.1, 4.2**
  
  - [ ]* 7.2 Write integration test for error handling flows
    - Test network error flow: tap → confirm → network error → error dialog → remain logged in
    - Test server error flow: tap → confirm → server error → error dialog → remain logged in
    - Verify user remains authenticated after errors
    - **Validates: Requirements 3.4, 3.5, 5.1, 5.2, 5.3**
  
  - [ ]* 7.3 Write property test for API error mapping
    - **Property 3: API error mapping consistency**
    - Generate random DioException instances with different error types
    - Verify each maps to correct Failure type with user-friendly message
    - **Validates: Requirements 3.4, 3.5, 5.1, 5.2**

- [ ] 8. Final checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- The implementation follows the existing clean architecture pattern in the codebase
- Localization strings need to be added for all supported languages (en, am, om, ti, so)
- The delete account option uses the same styling as logout (red/error color) to indicate danger
- Error handling ensures users remain logged in if deletion fails
- Successful deletion triggers complete cleanup: logout, socket disconnect, navigation
