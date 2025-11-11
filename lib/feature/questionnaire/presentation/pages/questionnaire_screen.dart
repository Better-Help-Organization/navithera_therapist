import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/core/routes/app_router.dart';
import 'package:navicare/feature/questionnaire/presentation/widgets/progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
// ============ Providers ============

import 'package:http_parser/http_parser.dart';

// Add this near your other constants
const Map<String, String> expertiseOptions = {
  'Anxiety': 'Anxiety',
  'Depression': 'Depression',
  'StressManagement': 'Stress Management',
  'Trauma': 'Trauma',
  'GriefLoss': 'Grief / Loss',
  'RelationshipProblems': 'Relationship Problems',
  'SelfEsteem': 'Self Esteem',
  'AngerIssues': 'Anger Issues',
  'PeerPressure': 'Peer Pressure',
  'AcademicStress': 'Academic Stress',
  'FamilyIssues': 'Family Issues',
  'BehavioralChange': 'Behavioral Change',
  'Bullying': 'Bullying',
  'SocialIsolation': 'Social Isolation',
  'CommunicationProblems': 'Communication Problems',
  'TrustIssues': 'Trust Issues',
  'IntimacyConcerns': 'Intimacy Concerns',
  'ParentingChallenges': 'Parenting Challenges',
  'ConflictResolution': 'Conflict Resolution',
  'AnxietySupportGroup': 'Anxiety Support Group',
  'DepressionSupportGroup': 'Depression Support Group',
  'ParentingSupportGroup': 'Parenting Support Group',
};

class FileUploadService {
  static Future<String> uploadFile(File imageFile, String endpoint) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (accessToken == null) {
      throw Exception('No access token found. Please login again.');
    }

    final uri = Uri.parse('${base_url_dev}/therapist/me/upload/$endpoint');
    final request = http.MultipartRequest('POST', uri);

    // Add authorization header
    request.headers['Authorization'] = 'Bearer $accessToken';

    // Get the file extension to determine MIME type
    final extension = imageFile.path.split('.').last.toLowerCase();
    String mimeType;
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        mimeType = 'image/jpeg';
        break;
      case 'png':
        mimeType = 'image/png';
        break;
      case 'gif':
        mimeType = 'image/gif';
        break;
      case 'pdf':
        mimeType = 'application/pdf';
        break;
      case 'doc':
        mimeType = 'application/msword';
        break;
      case 'docx':
        mimeType =
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
        break;
      default:
        mimeType = 'application/octet-stream';
    }

    // Attach the file with proper MIME type
    request.files.add(
      await http.MultipartFile.fromPath(
        'file', // Changed from 'file' to 'image' to match your backend
        imageFile.path,
        contentType: MediaType.parse(mimeType),
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('File uploaded successfully to $endpoint');

        final response_2 = await http.patch(
          Uri.parse('$base_url_dev/therapist/me'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
          body: json.encode({'avatar': 7}),
        );
        if (response_2.statusCode == 200 || response_2.statusCode == 201) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Profile updated successfully!'),
          //     backgroundColor: Colors.green,
          //   ),
          // );
          print("success converting the avatar");
          return responseData['data']?['filename'] ?? 'uploaded_file';
        } else {
          throw Exception(
            'Failed to update profile: ${response_2.statusCode} - ${response_2.body}',
          );
        }
      } else {
        throw Exception(
          'Failed to upload file: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error uploading file: $e');
      throw Exception('Error uploading file: $e');
    }
  }

  static Future<String> uploadFileWithModal(
    File imageFile,
    String endpoint,
    String modalId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (accessToken == null) {
      throw Exception('No access token found. Please login again.');
    }

    // Construct URL with modalId query parameter
    final uri = Uri.parse(
      '${base_url_dev}/therapist/me/upload/$endpoint?modalId=$modalId',
    );
    final request = http.MultipartRequest('POST', uri);

    // Add authorization header
    request.headers['Authorization'] = 'Bearer $accessToken';

    // Get the file extension to determine MIME type
    final extension = imageFile.path.split('.').last.toLowerCase();
    String mimeType;
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        mimeType = 'image/jpeg';
        break;
      case 'png':
        mimeType = 'image/png';
        break;
      case 'gif':
        mimeType = 'image/gif';
        break;
      case 'pdf':
        mimeType = 'application/pdf';
        break;
      case 'doc':
        mimeType = 'application/msword';
        break;
      case 'docx':
        mimeType =
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
        break;
      default:
        mimeType = 'application/octet-stream';
    }

    // Attach the file with proper MIME type
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType: MediaType.parse(mimeType),
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('File uploaded successfully to $endpoint with modalId: $modalId');
        return responseData['data']?['filename'] ?? 'uploaded_file';
      } else {
        throw Exception(
          'Failed to upload file: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error uploading file: $e');
      throw Exception('Error uploading file: $e');
    }
  }
}

// Step control
final currentStepProvider = StateProvider<int>((ref) => 0);

// Languages - fetched from /language endpoint
final languagesAsyncProvider = FutureProvider<List<_Language>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  if (accessToken == null) throw Exception('No access token found');

  final response = await http.get(
    Uri.parse('$base_url_dev/language'),
    headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> data = responseData['data'];
    final items = data.map((lang) => _Language.fromJson(lang)).toList();
    // Filter out “other”
    return items.where((l) => l.code.toLowerCase() != 'other').toList();
  } else {
    throw Exception('Failed to load languages: ${response.statusCode}');
  }
});
final modalsAsyncProvider = FutureProvider<List<_Modal>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');

  if (accessToken == null) {
    throw Exception('No access token found');
  }

  final response = await http.get(
    Uri.parse('$base_url_dev/modal'),
    headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    },
  );

  print("response: ${response.body}");

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> data = responseData['data'];
    print("modal data: $data");

    // Convert to list of modals and sort by order
    final modals = data.map((modal) => _Modal.fromJson(modal)).toList();
    modals.sort((a, b) => a.order.compareTo(b.order));

    return modals;
  } else {
    throw Exception('Failed to load modals: ${response.statusCode}');
  }
});

// Add this provider near your other providers
final bioTextProvider = StateProvider<String>((ref) => '');
final selectedExpertiseProvider = StateProvider<List<String>>((ref) => []);
final selectedModalIdsProvider = StateProvider<List<String>>((ref) => []);
final showOtherModalInputProvider = StateProvider<bool>((ref) => false);
final otherModalTextProvider = StateProvider<String>((ref) => '');

final selectedLanguageIdsProvider = StateProvider<List<String>>((ref) => []);

// Profile image provider (NEW)
final profileImageProvider = StateProvider<File?>((ref) => null);
final showOtherLanguageInputProvider = StateProvider<bool>((ref) => false);
final otherLanguageTextProvider = StateProvider<String>((ref) => '');
final workTimeProvider = StateProvider<String>((ref) => '');
final licenceImageProvider = StateProvider<File?>((ref) => null);
final degreeImageProvider = StateProvider<File?>((ref) => null);
final selectedModalIdProvider = StateProvider<String?>((ref) => null);
final normalLicenceImageProvider = StateProvider<File?>((ref) => null);
// Add these providers near your other image providers
final workExperienceImageProvider = StateProvider<File?>((ref) => null);
final specialTrainingImageProvider = StateProvider<File?>((ref) => null);
final professionalLicenseImageProvider = StateProvider<File?>((ref) => null);
final uploadingProvider = StateProvider<bool>((ref) => false);
// Add providers for bank account details
final bankAccountNumbersProvider = StateProvider<Map<String, String>>(
  (ref) => {},
);
final bankBranchesProvider = StateProvider<Map<String, String>>((ref) => {});
// Levels - fetched from /level endpoint
final levelsAsyncProvider = FutureProvider<List<_Level>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');

  if (accessToken == null) {
    throw Exception('No access token found');
  }

  final response = await http.get(
    Uri.parse('$base_url_dev/level'),
    headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> data = responseData['data']; // Access the 'data' array
    print("language data: $data");
    return data.map((level) => _Level.fromJson(level)).toList();
  } else {
    throw Exception('Failed to load levels: ${response.statusCode}');
  }
});

final selectedLevelIdProvider = StateProvider<String?>((ref) => null);

// Availability
final selectedAvailabilityProvider = StateProvider<List<Map<String, String>>>(
  (ref) => [],
);

// Goals
final goalsTextProvider = StateProvider<String>((ref) => '');

// Add providers for banks
final banksAsyncProvider = FutureProvider<List<_Bank>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');

  if (accessToken == null) {
    throw Exception('No access token found');
  }

  final response = await http.get(
    Uri.parse('$base_url_dev/banks'),
    headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> data = responseData['data'];
    return data.map((bank) => _Bank.fromJson(bank)).toList();
  } else {
    throw Exception('Failed to load banks: ${response.statusCode}');
  }
});

final selectedBankIdsProvider = StateProvider<List<String>>((ref) => []);

// Bank model
class _Bank {
  _Bank({required this.id, required this.name, required this.optional});

  final String id;
  final String name;
  final bool optional;

  factory _Bank.fromJson(Map<String, dynamic> json) {
    return _Bank(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      optional: json['optional'] ?? true,
    );
  }
}

class TherapistBank {
  final String bankId;
  final String accountNumber;

  TherapistBank({required this.bankId, required this.accountNumber});

  Map<String, dynamic> toJson() => {
    'bankId': bankId,
    'accountNumber': accountNumber,
  };
}

// ============ Models ============

class _Language {
  _Language({required this.id, required this.name, required this.code});

  final String id;
  final String name;
  final String code;

  factory _Language.fromJson(Map<String, dynamic> json) {
    return _Language(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
    );
  }
}

// Update the modal model
class _Modal {
  _Modal({
    required this.id,
    required this.name,
    required this.order,
    required this.description,
  });

  final String id;
  final String name;
  final int order;
  final String description;

  factory _Modal.fromJson(Map<String, dynamic> json) {
    return _Modal(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      order:
          json['order'] != null
              ? int.tryParse(json['order'].toString()) ?? 0
              : 0,
      description: json['description']?.toString() ?? '',
    );
  }
}

class _Level {
  _Level({
    required this.id,
    required this.type,
    required this.minXP,
    required this.maxXP,
    required this.price,
  });

  final String id;
  final String type;
  final int? minXP;
  final int? maxXP;
  final double? price;

  factory _Level.fromJson(Map<String, dynamic> json) {
    return _Level(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      minXP:
          json['minXP'] != null ? int.tryParse(json['minXP'].toString()) : null,
      maxXP:
          json['maxXP'] != null ? int.tryParse(json['maxXP'].toString()) : null,
      price:
          json['price'] != null
              ? double.tryParse(json['price'].toString())
              : null,
    );
  }
}

// ============ Screen ============

class PostSignupQuestionnaireScreen extends ConsumerStatefulWidget {
  const PostSignupQuestionnaireScreen({super.key});

  @override
  ConsumerState<PostSignupQuestionnaireScreen> createState() =>
      _PostSignupQuestionnaireScreenState();
}

class _PostSignupQuestionnaireScreenState
    extends ConsumerState<PostSignupQuestionnaireScreen> {
  late final PageController _pageController;
  bool _submitting = false;

  // UI constants aligned with your samples
  static const primary = Color(0xFF7EB09B);
  static const bg = Color(0xFFF7FAFC);
  static const textPrimary = Color(0xFF2D3748);
  static const textSecondary = Color(0xFF718096);
  static const borderNeutral = Color(0xFFCBD5E0);

  final List<String> genders = const ['Male', 'Female'];
  final List<String> workingDays = const [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  final List<Map<String, String>> periods = const [
    {'label': 'Morning', 'value': 'morning'},
    {'label': 'Afternoon', 'value': 'afternoon'},
    {'label': 'Evening', 'value': 'evening'},
  ];

  static const totalSteps = 12; // 0..4

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _isStepValid(int step) {
    switch (step) {
      case 0: // Modal selection step
        return ref.read(selectedModalIdProvider) != null;
      case 1: // Languages
        return ref.read(selectedLanguageIdsProvider).isNotEmpty;
      case 2: // Work time step
        final workTime = ref.read(workTimeProvider).trim();
        return workTime.isNotEmpty && int.tryParse(workTime) != 0;
      case 3: // Bio step
        final bio = ref.read(bioTextProvider).trim();
        return bio.isNotEmpty && bio.length >= 10;
      case 4: // Expertise step (NEW)
        return ref.read(selectedExpertiseProvider).isNotEmpty;
      case 5: // Bank step (moved from 4)
        final selectedBanks = ref.read(selectedBankIdsProvider);
        final accountNumbers = ref.read(bankAccountNumbersProvider);
        if (selectedBanks.isEmpty) return false;
        for (final bankId in selectedBanks) {
          final accountNumber = accountNumbers[bankId]?.trim() ?? '';
          if (accountNumber.isEmpty) {
            return false;
          }
        }
        return true;
      case 6: // Normal Licence step (moved from 5)
        return ref.read(normalLicenceImageProvider) != null;
      // ... rest of the cases (increment by 1)
      case 7: // Government ID step
        return ref.read(licenceImageProvider) != null;
      case 8: // Degree step
        return ref.read(degreeImageProvider) != null;
      case 9: // Professional License - optional
        return true;
      // case 10: // Work Experience - optional
      //   return true;
      case 10: // Special Training - optional
        return true;
      case 11: // Profile step
        return true;
      default:
        return false;
    }
  }

  Future<void> _prev() async {
    final current = ref.read(currentStepProvider);
    if (current > 0) {
      ref.read(currentStepProvider.notifier).state = current - 1;
      _pageController.animateToPage(
        current - 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).maybePop();
    }
  }

  Future<void> _nextOrSubmit() async {
    final current = ref.read(currentStepProvider);
    if (current < totalSteps - 1) {
      ref.read(currentStepProvider.notifier).state = current + 1;
      _pageController.animateToPage(
        current + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    } else {
      await _submit();
    }
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      // Collect data from all steps
      final workTime = ref.read(workTimeProvider);
      final selectedBanks = ref.read(selectedBankIdsProvider);
      final accountNumbers = ref.read(bankAccountNumbersProvider);
      final branches = ref.read(bankBranchesProvider);
      final bio = ref.read(bioTextProvider);

      final expertiseArray =
          ref.read(selectedExpertiseProvider).map((expertiseKey) {
            return {
              'expertise':
                  expertiseOptions[expertiseKey], // Use the enum key (e.g., "Depression")
              // 'amount': 150, // Fixed amount as specified
            };
          }).toList();

      // Prepare therapistBank array
      final therapistBanks =
          selectedBanks.map((bankId) {
            return {
              'bankId': bankId,
              'accountNumber': accountNumbers[bankId] ?? '',
              'branch': '',
            };
          }).toList();

      // Prepare the payload
      final payload = {
        'hoursDedicatedPerWeek': int.tryParse(workTime) ?? 0,
        'expertise': expertiseArray,
        'therapistBank': therapistBanks,
        'bio': bio.trim(),
      };

      print("expertise: ${payload}");
      // Submit to therapist/me endpoint
      final response = await http.patch(
        Uri.parse('$base_url_dev/therapist/me'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print('Submission successful: $responseData');

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        final router = ref.watch(routerProvider);
        router.go("/blocked-user");

        // Navigate to next screen or main app
        // Navigator.of(context).pushReplacementNamed('/main');
      } else {
        throw Exception(
          'Failed to update profile: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Submission failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  // ============ Step widgets ============
  Widget _expertiseStep(WidgetRef ref) {
    final selectedExpertise = ref.watch(selectedExpertiseProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   'Select your areas of expertise',
        //   style: TextStyle(
        //     fontSize: 22,
        //     fontWeight: FontWeight.w600,
        //     color: textPrimary,
        //     height: 1.3,
        //   ),
        // ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Select your areas of expertise',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                  height: 1.3,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Choose all areas you specialize in',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemCount: expertiseOptions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final expertiseKey = expertiseOptions.keys.elementAt(index);
              final expertiseDisplay = expertiseOptions[expertiseKey]!;
              final isSelected = selectedExpertise.contains(expertiseKey);

              return InkWell(
                onTap: () {
                  final upd = [...selectedExpertise];
                  if (isSelected) {
                    upd.remove(expertiseKey);
                  } else {
                    upd.add(expertiseKey);
                  }
                  ref.read(selectedExpertiseProvider.notifier).state = upd;
                },
                borderRadius: BorderRadius.circular(12),
                child: _selectTile(
                  title: expertiseDisplay,
                  subtitle: null,
                  selected: isSelected,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _bioStep(WidgetRef ref) {
    final bio = ref.watch(bioTextProvider);
    final theme = Theme.of(context);
    final textScale = MediaQuery.of(context).textScaleFactor;

    // Lower vertical spacing if text is scaled up
    final v16 = SizedBox(height: textScale > 1.2 ? 12 : 16);
    final v12 = SizedBox(height: textScale > 1.2 ? 8 : 12);

    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 0,
            maxHeight: constraints.maxHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Tell us about yourself',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                        height: 1.3,
                      ),
                    ),
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              const Text(
                'Write a brief bio that introduces you to potential clients. Share your experience, approach, and what makes you unique.',
                style: TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                  height: 1.4,
                ),
              ),

              SizedBox(height: 12),

              // Make remaining area scrollable
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Flexible multiline field without fixed height
                      IntrinsicHeight(
                        child: TextField(
                          onChanged:
                              (value) =>
                                  ref.read(bioTextProvider.notifier).state =
                                      value,
                          maxLines: null,
                          minLines:
                              5, // gives initial height but can grow with scroll
                          maxLength: 500,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText:
                                'Example: I am a licensed therapist with 5 years of experience specializing in cognitive behavioral therapy. I believe in creating a safe, non-judgmental space for clients to explore their thoughts and feelings...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFE2E8F0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: primary),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            // counter stays inside the field; this saves vertical space
                            counterText: '${bio.length}/500',
                          ),
                          textAlignVertical: TextAlignVertical.top,
                        ),
                      ),
                      v12,

                      // Optional helper below, compact
                      if (bio.isNotEmpty && bio.length < 10)
                        const Text(
                          'Minimum 10 characters',
                          style: TextStyle(fontSize: 13, color: Colors.orange),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  // Helper method for tips

  Widget _modalSelectionStep(WidgetRef ref) {
    final asyncModals = ref.watch(modalsAsyncProvider);
    final selectedModalId = ref.watch(selectedModalIdProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   'Select your primary therapy modality',
        //   style: TextStyle(
        //     fontSize: 22,
        //     fontWeight: FontWeight.w600,
        //     color: textPrimary,
        //     height: 1.3,
        //   ),
        // ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Select a type',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                  height: 1.3,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Choose the therapy type you specialize in',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: asyncModals.when(
            loading:
                () => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primary),
                  ),
                ),
            error:
                (e, _) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(height: 8),
                      Text('$e'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed:
                            () => ref.refresh(modalsAsyncProvider.future),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
            data: (modals) {
              // Sort modals by order
              final sortedModals = List<_Modal>.from(modals)
                ..sort((a, b) => a.order.compareTo(b.order));

              return ListView.separated(
                itemCount: sortedModals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final modal = sortedModals[index];
                  final isSelected = selectedModalId == modal.id;

                  return InkWell(
                    onTap: () {
                      ref.read(selectedModalIdProvider.notifier).state =
                          modal.id;
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? primary.withOpacity(0.1) : bg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? primary : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      isSelected ? primary : Colors.transparent,
                                  border: Border.all(
                                    color: isSelected ? primary : borderNeutral,
                                    width: 2,
                                  ),
                                ),
                                child:
                                    isSelected
                                        ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 14,
                                        )
                                        : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  modal.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? primary : textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (modal.description.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              modal.description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _workExperienceUploadStep(WidgetRef ref) {
    final workExperienceImage = ref.watch(workExperienceImageProvider);
    final isUploading = ref.watch(uploadingProvider);

    Future<void> pickAndUploadImage() async {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
          maxWidth: 1024,
        );

        if (pickedFile != null) {
          final File imageFile = File(pickedFile.path);
          ref.read(workExperienceImageProvider.notifier).state = imageFile;

          // Upload immediately after selection
          ref.read(uploadingProvider.notifier).state = true;
          try {
            await FileUploadService.uploadFile(imageFile, 'work_experience');
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Work experience document uploaded successfully!',
                ),
                backgroundColor: Colors.green,
              ),
            );
          } catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Upload failed: $e'),
                backgroundColor: Colors.red,
              ),
            );
          } finally {
            ref.read(uploadingProvider.notifier).state = false;
          }
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Your Work Experience Documents',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Please upload documents that verify your work experience in therapy',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 24),

        if (workExperienceImage != null) ...[
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderNeutral),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                workExperienceImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (isUploading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primary),
              ),
            )
          else
            ElevatedButton(
              onPressed: pickAndUploadImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Change Document'),
            ),
        ] else ...[
          InkWell(
            onTap: isUploading ? null : pickAndUploadImage,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderNeutral),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.work_outline,
                    color: isUploading ? textSecondary : primary,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isUploading
                        ? 'Uploading...'
                        : 'Tap to upload work experience',
                    style: TextStyle(
                      fontSize: 16,
                      color: isUploading ? textSecondary : textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'JPG, PNG, PDF formats',
                    style: TextStyle(fontSize: 12, color: textSecondary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  // Widget _normalLicenceUploadStep(WidgetRef ref) {
  //   final normalLicenceImage = ref.watch(normalLicenceImageProvider);
  //   final isUploading = ref.watch(uploadingProvider);
  //   final selectedModalId = ref.watch(selectedModalIdProvider);

  //   Future<void> pickAndUploadImage() async {
  //     try {
  //       // Check if modal is selected
  //       if (selectedModalId == null) {
  //         if (!mounted) return;
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('Please select a modality first'),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //         return;
  //       }

  //       final ImagePicker picker = ImagePicker();
  //       final XFile? pickedFile = await picker.pickImage(
  //         source: ImageSource.gallery,
  //         imageQuality: 85,
  //         maxWidth: 1024,
  //       );

  //       if (pickedFile != null) {
  //         final File imageFile = File(pickedFile.path);
  //         ref.read(normalLicenceImageProvider.notifier).state = imageFile;

  //         // Upload immediately after selection with modal ID
  //         ref.read(uploadingProvider.notifier).state = true;
  //         try {
  //           await FileUploadService.uploadFileWithModal(
  //             imageFile,
  //             'licence',
  //             selectedModalId!,
  //           );
  //           if (!mounted) return;
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //               content: Text(
  //                 'Work experience document uploaded successfully!',
  //               ),
  //               backgroundColor: Colors.green,
  //             ),
  //           );
  //         } catch (e) {
  //           if (!mounted) return;
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text('Upload failed'),
  //               backgroundColor: Colors.red,
  //             ),
  //           );
  //         } finally {
  //           ref.read(uploadingProvider.notifier).state = false;
  //         }
  //       }
  //     } catch (e) {
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to pick image'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       RichText(
  //         text: TextSpan(
  //           children: [
  //             TextSpan(
  //               text: 'Upload Your Work Experience Documents',
  //               style: TextStyle(
  //                 fontSize: 22,
  //                 fontWeight: FontWeight.w600,
  //                 color: textPrimary,
  //                 height: 1.3,
  //               ),
  //             ),
  //             TextSpan(
  //               text: ' *',
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 color: Colors.red,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //       Text(
  //         selectedModalId == null
  //             ? 'Please select a modality first'
  //             : 'Upload your documents for ${ref.watch(modalsAsyncProvider).when(data: (modals) => modals.firstWhere((m) => m.id == selectedModalId, orElse: () => _Modal(id: '', name: 'Selected', order: 0, description: '')).name, loading: () => 'selected modality', error: (_, __) => 'selected modality')}',
  //         style: TextStyle(
  //           fontSize: 14,
  //           color: selectedModalId == null ? Colors.red : textSecondary,
  //         ),
  //       ),
  //       const SizedBox(height: 24),

  //       if (selectedModalId == null) ...[
  //         Container(
  //           height: 150,
  //           width: double.infinity,
  //           padding: const EdgeInsets.all(16),
  //           decoration: BoxDecoration(
  //             color: bg,
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: Colors.red),
  //           ),
  //           child: const Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(Icons.warning, color: Colors.red, size: 48),
  //               SizedBox(height: 12),
  //               Text(
  //                 'Please go back and select a modality first',
  //                 style: TextStyle(fontSize: 16, color: Colors.red),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ] else if (normalLicenceImage != null) ...[
  //         Container(
  //           height: 200,
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: borderNeutral),
  //           ),
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(12),
  //             child: Image.file(
  //               normalLicenceImage,
  //               fit: BoxFit.cover,
  //               errorBuilder: (context, error, stackTrace) {
  //                 return const Center(
  //                   child: Icon(
  //                     Icons.error_outline,
  //                     color: Colors.red,
  //                     size: 48,
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         if (isUploading)
  //           const Center(
  //             child: CircularProgressIndicator(
  //               valueColor: AlwaysStoppedAnimation<Color>(primary),
  //             ),
  //           )
  //         else
  //           ElevatedButton(
  //             onPressed: pickAndUploadImage,
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: primary,
  //               foregroundColor: Colors.white,
  //               minimumSize: const Size(double.infinity, 50),
  //             ),
  //             child: const Text('Change Document'),
  //           ),
  //       ] else ...[
  //         InkWell(
  //           onTap: isUploading ? null : pickAndUploadImage,
  //           borderRadius: BorderRadius.circular(12),
  //           child: Container(
  //             height: 150,
  //             width: double.infinity,
  //             padding: const EdgeInsets.all(16),
  //             decoration: BoxDecoration(
  //               color: bg,
  //               borderRadius: BorderRadius.circular(12),
  //               border: Border.all(color: borderNeutral),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Icon(
  //                   Icons.assignment_outlined,
  //                   color: isUploading ? textSecondary : primary,
  //                   size: 48,
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Text(
  //                   isUploading
  //                       ? 'Uploading...'
  //                       : 'Tap to upload work experience',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: isUploading ? textSecondary : textPrimary,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 const Text(
  //                   'JPG, PNG formats',
  //                   style: TextStyle(fontSize: 12, color: textSecondary),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ],
  //   );
  // }

  Widget _normalLicenceUploadStep(WidgetRef ref) {
    final normalLicenceImage = ref.watch(normalLicenceImageProvider);
    final isUploading = ref.watch(uploadingProvider);
    final selectedModalId = ref.watch(selectedModalIdProvider);

    Future<void> pickAndUploadFile() async {
      try {
        // Check if modal is selected
        if (selectedModalId == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a modality first'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // Use FilePicker to allow multiple file types
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          withReadStream: false,
          allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
        );

        if (result == null || result.files.isEmpty) {
          // User canceled
          return;
        }

        final picked = result.files.first;

        // Optional: enforce size limit (e.g., 10MB)
        const maxBytes = 10 * 1024 * 1024;
        if (picked.size != null && picked.size > maxBytes) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File too large. Max 10MB.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final path = picked.path;
        if (path == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not read the selected file path.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final file = File(path);
        ref.read(normalLicenceImageProvider.notifier).state = file;

        // Upload immediately after selection with modal ID
        ref.read(uploadingProvider.notifier).state = true;
        try {
          await FileUploadService.uploadFileWithModal(
            file,
            'licence',
            selectedModalId!,
          );
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Document uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Upload failed: $e'),
              backgroundColor: Colors.red,
            ),
          );
        } finally {
          ref.read(uploadingProvider.notifier).state = false;
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    // Helper to get file extension for display
    String _getFileExtension(File file) {
      final path = file.path;
      final extension = path.split('.').last.toLowerCase();
      return extension.toUpperCase();
    }

    // Helper to get file name for display
    String _getFileName(File file) {
      final path = file.path;
      return path.split('/').last;
    }

    // Badge widget for file type
    Widget _fileTypeBadge(String extension) {
      Color bgColor;
      Color textColor;

      switch (extension.toLowerCase()) {
        case 'pdf':
          bgColor = const Color(0xFFFFEBEE);
          textColor = const Color(0xFFD32F2F);
          break;
        case 'jpg':
        case 'jpeg':
        case 'png':
          bgColor = const Color(0xFFE8F5E9);
          textColor = const Color(0xFF2E7D32);
          break;
        case 'doc':
        case 'docx':
          bgColor = const Color(0xFFE3F2FD);
          textColor = const Color(0xFF1565C0);
          break;
        default:
          bgColor = const Color(0xFFF5F5F5);
          textColor = const Color(0xFF424242);
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          extension,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Upload Your Work Experience Documents',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                  height: 1.3,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          selectedModalId == null
              ? 'Please select a modality first'
              : 'Upload your documents for ${ref.watch(modalsAsyncProvider).when(data: (modals) => modals.firstWhere((m) => m.id == selectedModalId, orElse: () => _Modal(id: '', name: 'Selected', order: 0, description: '')).name, loading: () => 'selected modality', error: (_, __) => 'selected modality')}',
          style: TextStyle(
            fontSize: 14,
            color: selectedModalId == null ? Colors.red : textSecondary,
          ),
        ),
        const SizedBox(height: 24),

        if (selectedModalId == null) ...[
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning, color: Colors.red, size: 48),
                SizedBox(height: 12),
                Text(
                  'Please go back and select a modality first',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ] else if (normalLicenceImage != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderNeutral),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _fileTypeBadge(_getFileExtension(normalLicenceImage!)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getFileName(normalLicenceImage!),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_getFileExtension(normalLicenceImage!)} • ${_formatFileSize(normalLicenceImage!.lengthSync())}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Show preview for images
                // if (_getFileExtension(normalLicenceImage!).toLowerCase()
                //     in ['jpg', 'jpeg', 'png']) ...[
                //   Container(
                //     height: 200,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: borderNeutral),
                //     ),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(8),
                //       child: Image.file(
                //         normalLicenceImage!,
                //         fit: BoxFit.cover,
                //         errorBuilder: (context, error, stackTrace) {
                //           return const Center(
                //             child: Icon(
                //               Icons.error_outline,
                //               color: Colors.red,
                //               size: 48,
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],

                // Show document icon for non-image files
                // if (_getFileExtension(normalLicenceImage!).toLowerCase()
                //     in ['pdf', 'doc', 'docx']) ...[
                //   Container(
                //     height: 120,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: bg,
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: borderNeutral),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           _getFileExtension(normalLicenceImage!).toLowerCase() == 'pdf'
                //               ? Icons.picture_as_pdf
                //               : Icons.description,
                //           color: primary,
                //           size: 48,
                //         ),
                //         const SizedBox(height: 8),
                //         Text(
                //           '${_getFileExtension(normalLicenceImage!)} Document',
                //           style: const TextStyle(
                //             fontSize: 16,
                //             color: textPrimary,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],
                if (isUploading)
                  const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(primary),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Uploading...',
                          style: TextStyle(color: textSecondary),
                        ),
                      ],
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: pickAndUploadFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 50),
                          ),
                          child: const Text('Change Document'),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ] else ...[
          InkWell(
            onTap: isUploading ? null : pickAndUploadFile,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderNeutral),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    color: isUploading ? textSecondary : primary,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isUploading ? 'Uploading...' : 'Tap to upload document',
                    style: TextStyle(
                      fontSize: 16,
                      color: isUploading ? textSecondary : textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'PDF, JPG, PNG, DOC, DOCX formats • Max 10MB',
                    style: TextStyle(fontSize: 12, color: textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  // Helper function to format file size
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / 1048576).toStringAsFixed(1)} MB';
  }

  Widget _specialTrainingUploadStep(WidgetRef ref) {
    final specialTrainingImage = ref.watch(specialTrainingImageProvider);
    final isUploading = ref.watch(uploadingProvider);

    Future<void> pickAndUploadFile() async {
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          withReadStream: false,
          allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
        );

        if (result == null || result.files.isEmpty) {
          return;
        }

        final picked = result.files.first;

        const maxBytes = 10 * 1024 * 1024;
        if (picked.size != null && picked.size > maxBytes) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File too large. Max 10MB.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final path = picked.path;
        if (path == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not read the selected file path.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final file = File(path);
        ref.read(specialTrainingImageProvider.notifier).state = file;

        ref.read(uploadingProvider.notifier).state = true;
        try {
          await FileUploadService.uploadFile(file, 'special_training');
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Special training certificate uploaded successfully!',
              ),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Upload failed: $e'),
              backgroundColor: Colors.red,
            ),
          );
        } finally {
          ref.read(uploadingProvider.notifier).state = false;
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    String _getFileExtension(File file) {
      final path = file.path;
      final extension = path.split('.').last.toLowerCase();
      return extension.toUpperCase();
    }

    String _getFileName(File file) {
      final path = file.path;
      return path.split('/').last;
    }

    String _formatFileSize(int bytes) {
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
      return '${(bytes / 1048576).toStringAsFixed(1)} MB';
    }

    Widget _fileTypeBadge(String extension) {
      Color bgColor;
      Color textColor;

      switch (extension.toLowerCase()) {
        case 'pdf':
          bgColor = const Color(0xFFFFEBEE);
          textColor = const Color(0xFFD32F2F);
          break;
        case 'jpg':
        case 'jpeg':
        case 'png':
          bgColor = const Color(0xFFE8F5E9);
          textColor = const Color(0xFF2E7D32);
          break;
        case 'doc':
        case 'docx':
          bgColor = const Color(0xFFE3F2FD);
          textColor = const Color(0xFF1565C0);
          break;
        default:
          bgColor = const Color(0xFFF5F5F5);
          textColor = const Color(0xFF424242);
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          extension,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Your Special Training Certificates',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Please upload certificates for any specialized training or certifications you have completed (Optional)',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 24),

        if (specialTrainingImage != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderNeutral),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _fileTypeBadge(_getFileExtension(specialTrainingImage!)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getFileName(specialTrainingImage!),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_getFileExtension(specialTrainingImage!)} • ${_formatFileSize(specialTrainingImage!.lengthSync())}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // if (_getFileExtension(specialTrainingImage!).toLowerCase() in ['jpg', 'jpeg', 'png']) ...[-`
                //   Container(
                //     height: 200,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: borderNeutral),
                //     ),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(8),
                //       child: Image.file(
                //         specialTrainingImage!,
                //         fit: BoxFit.cover,
                //         errorBuilder: (context, error, stackTrace) {
                //           return const Center(
                //             child: Icon(
                //               Icons.error_outline,
                //               color: Colors.red,
                //               size: 48,
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],

                // if (_getFileExtension(specialTrainingImage!).toLowerCase() in ['pdf', 'doc', 'docx']) ...[
                //   Container(
                //     height: 120,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: bg,
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: borderNeutral),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           _getFileExtension(specialTrainingImage!).toLowerCase() == 'pdf'
                //               ? Icons.picture_as_pdf
                //               : Icons.description,
                //           color: primary,
                //           size: 48,
                //         ),
                //         const SizedBox(height: 8),
                //         Text(
                //           '${_getFileExtension(specialTrainingImage!)} Document',
                //           style: const TextStyle(
                //             fontSize: 16,
                //             color: textPrimary,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],
                if (isUploading)
                  const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(primary),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Uploading...',
                          style: TextStyle(color: textSecondary),
                        ),
                      ],
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: pickAndUploadFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 50),
                          ),
                          child: const Text('Change Document'),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ] else ...[
          InkWell(
            onTap: isUploading ? null : pickAndUploadFile,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderNeutral),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school_outlined,
                    color: isUploading ? textSecondary : primary,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isUploading
                        ? 'Uploading...'
                        : 'Tap to upload special training',
                    style: TextStyle(
                      fontSize: 16,
                      color: isUploading ? textSecondary : textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'PDF, JPG, PNG, DOC, DOCX formats • Max 10MB (Optional)',
                    style: TextStyle(fontSize: 12, color: textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _modalsStep(WidgetRef ref) {
    final asyncModals = ref.watch(modalsAsyncProvider);
    final selected = ref.watch(selectedModalIdsProvider);
    final showOther = ref.watch(showOtherModalInputProvider);
    final otherText = ref.watch(otherModalTextProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select the therapy modalities you specialize in.',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Select all that apply',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: asyncModals.when(
            loading:
                () => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primary),
                  ),
                ),
            error:
                (e, _) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(height: 8),
                      Text('$e'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed:
                            () => ref.refresh(modalsAsyncProvider.future),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
            data: (modals) {
              return ListView.separated(
                itemCount: modals.length + (showOther ? 1 : 0),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  // "Other" text field row (if "Other" is selected)
                  if (showOther && index == modals.length) {
                    final invalid = otherText.trim().isEmpty;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        TextField(
                          onChanged:
                              (v) =>
                                  ref
                                      .read(otherModalTextProvider.notifier)
                                      .state = v,
                          decoration: InputDecoration(
                            hintText: 'Please specify other modality...',
                            hintStyle: const TextStyle(
                              color: Color(0xFFA0AEC0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color:
                                    invalid
                                        ? Colors.red
                                        : const Color(0xFFE2E8F0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: invalid ? Colors.red : primary,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  }

                  // Regular modal rows
                  final modal = modals[index];
                  final isSelected = selected.contains(modal.id);

                  return InkWell(
                    onTap: () {
                      final upd = [...selected];
                      if (isSelected) {
                        upd.remove(modal.id);
                      } else {
                        upd.add(modal.id);
                      }
                      ref.read(selectedModalIdsProvider.notifier).state = upd;
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: _selectTile(
                      title: modal.name,
                      subtitle: null, // No subtitle needed for modals
                      selected: isSelected,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget _licenceUploadStep(WidgetRef ref) {
  //   final licenceImage = ref.watch(licenceImageProvider);
  //   final isUploading = ref.watch(uploadingProvider);

  //   Future<void> pickAndUploadImage() async {
  //     try {
  //       final ImagePicker picker = ImagePicker();
  //       final XFile? pickedFile = await picker.pickImage(
  //         source: ImageSource.gallery,
  //         imageQuality: 85,
  //         maxWidth: 1024,
  //       );

  //       if (pickedFile != null) {
  //         final File imageFile = File(pickedFile.path);
  //         ref.read(licenceImageProvider.notifier).state = imageFile;

  //         // Upload immediately after selection
  //         ref.read(uploadingProvider.notifier).state = true;
  //         try {
  //           await FileUploadService.uploadFile(imageFile, 'gov_id');
  //           if (!mounted) return;
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //               content: Text('Licence uploaded successfully!'),
  //               backgroundColor: Colors.green,
  //             ),
  //           );
  //         } catch (e) {
  //           if (!mounted) return;
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text('Upload failed: $e'),
  //               backgroundColor: Colors.red,
  //             ),
  //           );
  //           // Keep the image selected so user can retry
  //         } finally {
  //           ref.read(uploadingProvider.notifier).state = false;
  //         }
  //       }
  //     } catch (e) {
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to pick image: $e'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       RichText(
  //         text: TextSpan(
  //           children: [
  //             TextSpan(
  //               text: 'Upload Your Government ID',
  //               style: TextStyle(
  //                 fontSize: 22,
  //                 fontWeight: FontWeight.w600,
  //                 color: textPrimary,
  //                 height: 1.3,
  //               ),
  //             ),
  //             TextSpan(
  //               text: ' *',
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 color: Colors.red,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //       const Text(
  //         'Please upload a clear image of your Government ID or National ID',
  //         style: TextStyle(fontSize: 14, color: textSecondary),
  //       ),
  //       const SizedBox(height: 24),

  //       if (licenceImage != null) ...[
  //         Container(
  //           height: 200,
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: borderNeutral),
  //           ),
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(12),
  //             child: Image.file(
  //               licenceImage,
  //               fit: BoxFit.cover,
  //               errorBuilder: (context, error, stackTrace) {
  //                 return const Center(
  //                   child: Icon(
  //                     Icons.error_outline,
  //                     color: Colors.red,
  //                     size: 48,
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         if (isUploading)
  //           const Center(
  //             child: CircularProgressIndicator(
  //               valueColor: AlwaysStoppedAnimation<Color>(primary),
  //             ),
  //           )
  //         else
  //           ElevatedButton(
  //             onPressed: pickAndUploadImage,
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: primary,
  //               foregroundColor: Colors.white,
  //               minimumSize: const Size(double.infinity, 50),
  //             ),
  //             child: const Text('Change Image'),
  //           ),
  //       ] else ...[
  //         InkWell(
  //           onTap: isUploading ? null : pickAndUploadImage,
  //           borderRadius: BorderRadius.circular(12),
  //           child: Container(
  //             height: 150,
  //             width: double.infinity,
  //             padding: const EdgeInsets.all(16),
  //             decoration: BoxDecoration(
  //               color: bg,
  //               borderRadius: BorderRadius.circular(12),
  //               border: Border.all(color: borderNeutral),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Icon(
  //                   Icons.badge,
  //                   color: isUploading ? textSecondary : primary,
  //                   size: 48,
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Text(
  //                   isUploading ? 'Uploading...' : 'Tap to upload ID',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: isUploading ? textSecondary : textPrimary,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 const Text(
  //                   'JPG, PNG formats',
  //                   style: TextStyle(fontSize: 12, color: textSecondary),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ],
  //   );
  // }

  Widget _licenceUploadStep(WidgetRef ref) {
    final licenceImage = ref.watch(licenceImageProvider);
    final isUploading = ref.watch(uploadingProvider);

    Future<void> pickAndUploadFile() async {
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          withReadStream: false,
          allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
        );

        if (result == null || result.files.isEmpty) {
          return;
        }

        final picked = result.files.first;

        const maxBytes = 10 * 1024 * 1024;
        if (picked.size != null && picked.size > maxBytes) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File too large. Max 10MB.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final path = picked.path;
        if (path == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not read the selected file path.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final file = File(path);
        ref.read(licenceImageProvider.notifier).state = file;

        ref.read(uploadingProvider.notifier).state = true;
        try {
          await FileUploadService.uploadFile(file, 'gov_id');
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Government ID uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Upload failed: $e'),
              backgroundColor: Colors.red,
            ),
          );
        } finally {
          ref.read(uploadingProvider.notifier).state = false;
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    String _getFileExtension(File file) {
      final path = file.path;
      final extension = path.split('.').last.toLowerCase();
      return extension.toUpperCase();
    }

    String _getFileName(File file) {
      final path = file.path;
      return path.split('/').last;
    }

    String _formatFileSize(int bytes) {
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
      return '${(bytes / 1048576).toStringAsFixed(1)} MB';
    }

    Widget _fileTypeBadge(String extension) {
      Color bgColor;
      Color textColor;

      switch (extension.toLowerCase()) {
        case 'pdf':
          bgColor = const Color(0xFFFFEBEE);
          textColor = const Color(0xFFD32F2F);
          break;
        case 'jpg':
        case 'jpeg':
        case 'png':
          bgColor = const Color(0xFFE8F5E9);
          textColor = const Color(0xFF2E7D32);
          break;
        case 'doc':
        case 'docx':
          bgColor = const Color(0xFFE3F2FD);
          textColor = const Color(0xFF1565C0);
          break;
        default:
          bgColor = const Color(0xFFF5F5F5);
          textColor = const Color(0xFF424242);
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          extension,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Upload Your Government ID',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                  height: 1.3,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Please upload a clear image or scan of your Government ID or National ID',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 24),

        if (licenceImage != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderNeutral),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _fileTypeBadge(_getFileExtension(licenceImage!)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getFileName(licenceImage!),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_getFileExtension(licenceImage!)} • ${_formatFileSize(licenceImage!.lengthSync())}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // if (_getFileExtension(licenceImage!).toLowerCase() in ['jpg', 'jpeg', 'png']) ...[
                //   Container(
                //     height: 200,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: borderNeutral),
                //     ),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(8),
                //       child: Image.file(
                //         licenceImage!,
                //         fit: BoxFit.cover,
                //         errorBuilder: (context, error, stackTrace) {
                //           return const Center(
                //             child: Icon(
                //               Icons.error_outline,
                //               color: Colors.red,
                //               size: 48,
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],

                // if (_getFileExtension(licenceImage!).toLowerCase() in ['pdf', 'doc', 'docx']) ...[
                //   Container(
                //     height: 120,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: bg,
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: borderNeutral),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           _getFileExtension(licenceImage!).toLowerCase() == 'pdf'
                //               ? Icons.picture_as_pdf
                //               : Icons.description,
                //           color: primary,
                //           size: 48,
                //         ),
                //         const SizedBox(height: 8),
                //         Text(
                //           '${_getFileExtension(licenceImage!)} Document',
                //           style: const TextStyle(
                //             fontSize: 16,
                //             color: textPrimary,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],
                if (isUploading)
                  const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(primary),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Uploading...',
                          style: TextStyle(color: textSecondary),
                        ),
                      ],
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: pickAndUploadFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 50),
                          ),
                          child: const Text('Change Document'),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ] else ...[
          InkWell(
            onTap: isUploading ? null : pickAndUploadFile,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderNeutral),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.badge,
                    color: isUploading ? textSecondary : primary,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isUploading
                        ? 'Uploading...'
                        : 'Tap to upload Government ID',
                    style: TextStyle(
                      fontSize: 16,
                      color: isUploading ? textSecondary : textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'PDF, JPG, PNG, DOC, DOCX formats • Max 10MB',
                    style: TextStyle(fontSize: 12, color: textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  // Widget _degreeUploadStep(WidgetRef ref) {
  //   final degreeImage = ref.watch(degreeImageProvider);
  //   final isUploading = ref.watch(uploadingProvider);

  //   Future<void> pickAndUploadImage() async {
  //     try {
  //       final ImagePicker picker = ImagePicker();
  //       final XFile? pickedFile = await picker.pickImage(
  //         source: ImageSource.gallery,
  //         imageQuality: 85,
  //         maxWidth: 1024,
  //       );

  //       if (pickedFile != null) {
  //         final File imageFile = File(pickedFile.path);
  //         ref.read(degreeImageProvider.notifier).state = imageFile;

  //         // Upload immediately after selection
  //         ref.read(uploadingProvider.notifier).state = true;
  //         try {
  //           await FileUploadService.uploadFile(imageFile, 'degree');
  //           if (!mounted) return;
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //               content: Text('Degree uploaded successfully!'),
  //               backgroundColor: Colors.green,
  //             ),
  //           );
  //         } catch (e) {
  //           if (!mounted) return;
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text('Upload failed: $e'),
  //               backgroundColor: Colors.red,
  //             ),
  //           );
  //         } finally {
  //           ref.read(uploadingProvider.notifier).state = false;
  //         }
  //       }
  //     } catch (e) {
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to pick image: $e'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       RichText(
  //         text: TextSpan(
  //           children: [
  //             TextSpan(
  //               text: 'Upload Your Degree',
  //               style: TextStyle(
  //                 fontSize: 22,
  //                 fontWeight: FontWeight.w600,
  //                 color: textPrimary,
  //                 height: 1.3,
  //               ),
  //             ),
  //             TextSpan(
  //               text: ' *',
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 color: Colors.red,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //       const Text(
  //         'Please upload a clear image of your academic degree',
  //         style: TextStyle(fontSize: 14, color: textSecondary),
  //       ),
  //       const SizedBox(height: 24),

  //       if (degreeImage != null) ...[
  //         Container(
  //           height: 200,
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: borderNeutral),
  //           ),
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(12),
  //             child: Image.file(
  //               degreeImage,
  //               fit: BoxFit.cover,
  //               errorBuilder: (context, error, stackTrace) {
  //                 return const Center(
  //                   child: Icon(
  //                     Icons.error_outline,
  //                     color: Colors.red,
  //                     size: 48,
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         if (isUploading)
  //           const Center(
  //             child: CircularProgressIndicator(
  //               valueColor: AlwaysStoppedAnimation<Color>(primary),
  //             ),
  //           )
  //         else
  //           ElevatedButton(
  //             onPressed: pickAndUploadImage,
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: primary,
  //               foregroundColor: Colors.white,
  //               minimumSize: const Size(double.infinity, 50),
  //             ),
  //             child: const Text('Change Image'),
  //           ),
  //       ] else ...[
  //         InkWell(
  //           onTap: isUploading ? null : pickAndUploadImage,
  //           borderRadius: BorderRadius.circular(12),
  //           child: Container(
  //             height: 150,
  //             width: double.infinity,
  //             padding: const EdgeInsets.all(16),
  //             decoration: BoxDecoration(
  //               color: bg,
  //               borderRadius: BorderRadius.circular(12),
  //               border: Border.all(color: borderNeutral),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Icon(
  //                   Icons.school_outlined,
  //                   color: isUploading ? textSecondary : primary,
  //                   size: 48,
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Text(
  //                   isUploading ? 'Uploading...' : 'Tap to upload degree',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: isUploading ? textSecondary : textPrimary,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 const Text(
  //                   'JPG, PNG formats',
  //                   style: TextStyle(fontSize: 12, color: textSecondary),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ],
  //   );
  // }

  Widget _degreeUploadStep(WidgetRef ref) {
    final degreeImage = ref.watch(degreeImageProvider);
    final isUploading = ref.watch(uploadingProvider);

    Future<void> pickAndUploadFile() async {
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          withReadStream: false,
          allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
        );

        if (result == null || result.files.isEmpty) {
          return;
        }

        final picked = result.files.first;

        const maxBytes = 10 * 1024 * 1024;
        if (picked.size != null && picked.size > maxBytes) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File too large. Max 10MB.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final path = picked.path;
        if (path == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not read the selected file path.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final file = File(path);
        ref.read(degreeImageProvider.notifier).state = file;

        ref.read(uploadingProvider.notifier).state = true;
        try {
          await FileUploadService.uploadFile(file, 'degree');
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Degree uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Upload failed: $e'),
              backgroundColor: Colors.red,
            ),
          );
        } finally {
          ref.read(uploadingProvider.notifier).state = false;
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    String _getFileExtension(File file) {
      final path = file.path;
      final extension = path.split('.').last.toLowerCase();
      return extension.toUpperCase();
    }

    String _getFileName(File file) {
      final path = file.path;
      return path.split('/').last;
    }

    String _formatFileSize(int bytes) {
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
      return '${(bytes / 1048576).toStringAsFixed(1)} MB';
    }

    Widget _fileTypeBadge(String extension) {
      Color bgColor;
      Color textColor;

      switch (extension.toLowerCase()) {
        case 'pdf':
          bgColor = const Color(0xFFFFEBEE);
          textColor = const Color(0xFFD32F2F);
          break;
        case 'jpg':
        case 'jpeg':
        case 'png':
          bgColor = const Color(0xFFE8F5E9);
          textColor = const Color(0xFF2E7D32);
          break;
        case 'doc':
        case 'docx':
          bgColor = const Color(0xFFE3F2FD);
          textColor = const Color(0xFF1565C0);
          break;
        default:
          bgColor = const Color(0xFFF5F5F5);
          textColor = const Color(0xFF424242);
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          extension,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Upload Your Degree',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                  height: 1.3,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Please upload a clear image or scan of your academic degree certificate',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 24),

        if (degreeImage != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderNeutral),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _fileTypeBadge(_getFileExtension(degreeImage!)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getFileName(degreeImage!),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_getFileExtension(degreeImage!)} • ${_formatFileSize(degreeImage!.lengthSync())}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // if (_getFileExtension(degreeImage!).toLowerCase() in ['jpg', 'jpeg', 'png']) ...[
                //   Container(
                //     height: 200,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: borderNeutral),
                //     ),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(8),
                //       child: Image.file(
                //         degreeImage!,
                //         fit: BoxFit.cover,
                //         errorBuilder: (context, error, stackTrace) {
                //           return const Center(
                //             child: Icon(
                //               Icons.error_outline,
                //               color: Colors.red,
                //               size: 48,
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],

                // if (_getFileExtension(degreeImage!).toLowerCase() in ['pdf', 'doc', 'docx']) ...[
                //   Container(
                //     height: 120,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: bg,
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: borderNeutral),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           _getFileExtension(degreeImage!).toLowerCase() == 'pdf'
                //               ? Icons.picture_as_pdf
                //               : Icons.description,
                //           color: primary,
                //           size: 48,
                //         ),
                //         const SizedBox(height: 8),
                //         Text(
                //           '${_getFileExtension(degreeImage!)} Document',
                //           style: const TextStyle(
                //             fontSize: 16,
                //             color: textPrimary,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],
                if (isUploading)
                  const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(primary),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Uploading...',
                          style: TextStyle(color: textSecondary),
                        ),
                      ],
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: pickAndUploadFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 50),
                          ),
                          child: const Text('Change Document'),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ] else ...[
          InkWell(
            onTap: isUploading ? null : pickAndUploadFile,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderNeutral),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school_outlined,
                    color: isUploading ? textSecondary : primary,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isUploading ? 'Uploading...' : 'Tap to upload degree',
                    style: TextStyle(
                      fontSize: 16,
                      color: isUploading ? textSecondary : textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'PDF, JPG, PNG, DOC, DOCX formats • Max 10MB',
                    style: TextStyle(fontSize: 12, color: textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  // Widget _professionalLicenseUploadStep(WidgetRef ref) {
  //   final professionalLicenseImage = ref.watch(
  //     professionalLicenseImageProvider,
  //   );
  //   final isUploading = ref.watch(uploadingProvider);

  //   Future<void> pickAndUploadImage() async {
  //     try {
  //       final ImagePicker picker = ImagePicker();
  //       final XFile? pickedFile = await picker.pickImage(
  //         source: ImageSource.gallery,
  //         imageQuality: 85,
  //         maxWidth: 1024,
  //       );

  //       if (pickedFile != null) {
  //         final File imageFile = File(pickedFile.path);
  //         ref.read(professionalLicenseImageProvider.notifier).state = imageFile;

  //         // Upload immediately after selection
  //         ref.read(uploadingProvider.notifier).state = true;
  //         try {
  //           await FileUploadService.uploadFile(
  //             imageFile,
  //             'professional_license',
  //           );
  //           if (!mounted) return;
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //               content: Text('Professional license uploaded successfully!'),
  //               backgroundColor: Colors.green,
  //             ),
  //           );
  //         } catch (e) {
  //           if (!mounted) return;
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text('Upload failed: $e'),
  //               backgroundColor: Colors.red,
  //             ),
  //           );
  //         } finally {
  //           ref.read(uploadingProvider.notifier).state = false;
  //         }
  //       }
  //     } catch (e) {
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to pick image: $e'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Upload Your Professional License',
  //         style: TextStyle(
  //           fontSize: 22,
  //           fontWeight: FontWeight.w600,
  //           color: textPrimary,
  //           height: 1.3,
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //       const Text(
  //         'Please upload a clear image of your professional license certificate',
  //         style: TextStyle(fontSize: 14, color: textSecondary),
  //       ),
  //       const SizedBox(height: 24),

  //       if (professionalLicenseImage != null) ...[
  //         Container(
  //           height: 200,
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: borderNeutral),
  //           ),
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(12),
  //             child: Image.file(
  //               professionalLicenseImage,
  //               fit: BoxFit.cover,
  //               errorBuilder: (context, error, stackTrace) {
  //                 return const Center(
  //                   child: Icon(
  //                     Icons.error_outline,
  //                     color: Colors.red,
  //                     size: 48,
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         if (isUploading)
  //           const Center(
  //             child: CircularProgressIndicator(
  //               valueColor: AlwaysStoppedAnimation<Color>(primary),
  //             ),
  //           )
  //         else
  //           ElevatedButton(
  //             onPressed: pickAndUploadImage,
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: primary,
  //               foregroundColor: Colors.white,
  //               minimumSize: const Size(double.infinity, 50),
  //             ),
  //             child: const Text('Change Image'),
  //           ),
  //       ] else ...[
  //         InkWell(
  //           onTap: isUploading ? null : pickAndUploadImage,
  //           borderRadius: BorderRadius.circular(12),
  //           child: Container(
  //             height: 150,
  //             width: double.infinity,
  //             padding: const EdgeInsets.all(16),
  //             decoration: BoxDecoration(
  //               color: bg,
  //               borderRadius: BorderRadius.circular(12),
  //               border: Border.all(color: borderNeutral),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Icon(
  //                   Icons.verified_user_outlined,
  //                   color: isUploading ? textSecondary : primary,
  //                   size: 48,
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Text(
  //                   isUploading
  //                       ? 'Uploading...'
  //                       : 'Tap to upload professional license',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: isUploading ? textSecondary : textPrimary,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 const Text(
  //                   'JPG, PNG formats',
  //                   style: TextStyle(fontSize: 12, color: textSecondary),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ],
  //   );
  // }
  Widget _professionalLicenseUploadStep(WidgetRef ref) {
    final professionalLicenseImage = ref.watch(
      professionalLicenseImageProvider,
    );
    final isUploading = ref.watch(uploadingProvider);

    Future<void> pickAndUploadFile() async {
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          withReadStream: false,
          allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
        );

        if (result == null || result.files.isEmpty) {
          return;
        }

        final picked = result.files.first;

        const maxBytes = 10 * 1024 * 1024;
        if (picked.size != null && picked.size > maxBytes) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File too large. Max 10MB.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final path = picked.path;
        if (path == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not read the selected file path.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final file = File(path);
        ref.read(professionalLicenseImageProvider.notifier).state = file;

        ref.read(uploadingProvider.notifier).state = true;
        try {
          await FileUploadService.uploadFile(file, 'professional_license');
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Professional license uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Upload failed: $e'),
              backgroundColor: Colors.red,
            ),
          );
        } finally {
          ref.read(uploadingProvider.notifier).state = false;
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    String _getFileExtension(File file) {
      final path = file.path;
      final extension = path.split('.').last.toLowerCase();
      return extension.toUpperCase();
    }

    String _getFileName(File file) {
      final path = file.path;
      return path.split('/').last;
    }

    String _formatFileSize(int bytes) {
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
      return '${(bytes / 1048576).toStringAsFixed(1)} MB';
    }

    Widget _fileTypeBadge(String extension) {
      Color bgColor;
      Color textColor;

      switch (extension.toLowerCase()) {
        case 'pdf':
          bgColor = const Color(0xFFFFEBEE);
          textColor = const Color(0xFFD32F2F);
          break;
        case 'jpg':
        case 'jpeg':
        case 'png':
          bgColor = const Color(0xFFE8F5E9);
          textColor = const Color(0xFF2E7D32);
          break;
        case 'doc':
        case 'docx':
          bgColor = const Color(0xFFE3F2FD);
          textColor = const Color(0xFF1565C0);
          break;
        default:
          bgColor = const Color(0xFFF5F5F5);
          textColor = const Color(0xFF424242);
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          extension,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Your Professional License',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Please upload a clear image or scan of your professional license certificate (Optional)',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 24),

        if (professionalLicenseImage != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderNeutral),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _fileTypeBadge(
                      _getFileExtension(professionalLicenseImage!),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getFileName(professionalLicenseImage!),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_getFileExtension(professionalLicenseImage!)} • ${_formatFileSize(professionalLicenseImage!.lengthSync())}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // if (_getFileExtension(professionalLicenseImage!).toLowerCase() in ['jpg', 'jpeg', 'png']) ...[
                //   Container(
                //     height: 200,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: borderNeutral),
                //     ),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(8),
                //       child: Image.file(
                //         professionalLicenseImage!,
                //         fit: BoxFit.cover,
                //         errorBuilder: (context, error, stackTrace) {
                //           return const Center(
                //             child: Icon(
                //               Icons.error_outline,
                //               color: Colors.red,
                //               size: 48,
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],

                // if (_getFileExtension(professionalLicenseImage!).toLowerCase() in ['pdf', 'doc', 'docx']) ...[
                //   Container(
                //     height: 120,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: bg,
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: borderNeutral),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           _getFileExtension(professionalLicenseImage!).toLowerCase() == 'pdf'
                //               ? Icons.picture_as_pdf
                //               : Icons.description,
                //           color: primary,
                //           size: 48,
                //         ),
                //         const SizedBox(height: 8),
                //         Text(
                //           '${_getFileExtension(professionalLicenseImage!)} Document',
                //           style: const TextStyle(
                //             fontSize: 16,
                //             color: textPrimary,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],
                if (isUploading)
                  const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(primary),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Uploading...',
                          style: TextStyle(color: textSecondary),
                        ),
                      ],
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: pickAndUploadFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 50),
                          ),
                          child: const Text('Change Document'),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ] else ...[
          InkWell(
            onTap: isUploading ? null : pickAndUploadFile,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderNeutral),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: isUploading ? textSecondary : primary,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isUploading
                        ? 'Uploading...'
                        : 'Tap to upload professional license',
                    style: TextStyle(
                      fontSize: 16,
                      color: isUploading ? textSecondary : textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'PDF, JPG, PNG, DOC, DOCX formats • Max 10MB (Optional)',
                    style: TextStyle(fontSize: 12, color: textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _banksStep(WidgetRef ref) {
    final asyncBanks = ref.watch(banksAsyncProvider);
    final selectedBanks = ref.watch(selectedBankIdsProvider);
    final accountNumbers = ref.watch(bankAccountNumbersProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select your preferred banks',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Select all banks you want to work with and provide account numbers',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: asyncBanks.when(
            loading:
                () => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primary),
                  ),
                ),
            error:
                (e, _) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(height: 8),
                      Text('$e'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => ref.refresh(banksAsyncProvider.future),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
            data: (banks) {
              // Auto-select the non-optional bank on first load
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final nonOptionalBank = banks.firstWhere(
                  (bank) => !bank.optional,
                  orElse: () => banks.first,
                );

                final currentSelected = ref.read(selectedBankIdsProvider);
                if (!currentSelected.contains(nonOptionalBank.id)) {
                  ref.read(selectedBankIdsProvider.notifier).state = [
                    nonOptionalBank.id,
                    ...currentSelected,
                  ];
                }
              });

              return ListView.separated(
                itemCount: banks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final bank = banks[index];
                  final isSelected = selectedBanks.contains(bank.id);
                  final isNonOptional = !bank.optional;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bank selection tile
                      InkWell(
                        onTap:
                            isNonOptional
                                ? null // Disable tapping for non-optional banks
                                : () {
                                  final upd = [...selectedBanks];
                                  if (isSelected) {
                                    upd.remove(bank.id);
                                  } else {
                                    upd.add(bank.id);
                                  }
                                  ref
                                      .read(selectedBankIdsProvider.notifier)
                                      .state = upd;
                                },
                        borderRadius: BorderRadius.circular(12),
                        child: Opacity(
                          opacity: isNonOptional ? 0.7 : 1.0,
                          child: _selectTile(
                            title: bank.name,
                            subtitle: isNonOptional ? 'Required' : null,
                            selected: isSelected,
                          ),
                        ),
                      ),

                      // Bank account details (shown only when bank is selected)
                      if (isSelected) ...[
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account Details for ${bank.name}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Account Number Input
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Account Number',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.all(12),
                                ),
                                onChanged: (value) {
                                  final currentAccounts = {...accountNumbers};
                                  currentAccounts[bank.id] = value;
                                  ref
                                      .read(bankAccountNumbersProvider.notifier)
                                      .state = currentAccounts;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter account number';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  );
                },
              );
            },
          ),
        ),
        if (selectedBanks.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'Selected banks: ${selectedBanks.length}',
              style: const TextStyle(
                fontSize: 14,
                color: textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _workTimeStep(WidgetRef ref) {
    final workTime = ref.watch(workTimeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'How much time can you work per week?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                  height: 1.3,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Enter the total hours you can commit to work each week (numbers only)',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 16),
        TextField(
          onChanged: (v) {
            // Remove any non-digit characters (commas, letters, etc.)
            final cleanedValue = v.replaceAll(RegExp(r'[^0-9]'), '');
            ref.read(workTimeProvider.notifier).state = cleanedValue;
          },
          decoration: InputDecoration(
            hintText: 'e.g., 20, 40, etc. (numbers only)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primary),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            // This prevents non-digit characters from being entered
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
        const SizedBox(height: 16),
        if (workTime == '0')
          const Text(
            'Please enter your available work time.',
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
        if (workTime.isNotEmpty && workTime != '0')
          Text(
            'You entered: $workTime hours per week',
            style: const TextStyle(
              fontSize: 16,
              color: primary,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Widget _wrapCard(Widget child) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 16),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _languagesStep(WidgetRef ref) {
    final asyncLangs = ref.watch(languagesAsyncProvider);
    final selected = ref.watch(selectedLanguageIdsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   'Select the languages you speak.',
        //   style: TextStyle(
        //     fontSize: 22,
        //     fontWeight: FontWeight.w600,
        //     color: textPrimary,
        //     height: 1.3,
        //   ),
        // ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Select the languages you speak.',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                  height: 1.3,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Select all that apply',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: asyncLangs.when(
            loading:
                () => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primary),
                  ),
                ),
            error:
                (e, _) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(height: 8),
                      Text('$e'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed:
                            () => ref.refresh(languagesAsyncProvider.future),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
            data: (langs) {
              return ListView.separated(
                itemCount: langs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final lang = langs[index];
                  final isSelected = selected.contains(lang.id);

                  return InkWell(
                    onTap: () {
                      final upd = [...selected];
                      if (isSelected) {
                        upd.remove(lang.id);
                      } else {
                        upd.add(lang.id);
                      }
                      ref.read(selectedLanguageIdsProvider.notifier).state =
                          upd;
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: _selectTile(
                      title: lang.name,
                      subtitle: lang.code.toUpperCase(),
                      selected: isSelected,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _profileUploadStep(WidgetRef ref) {
    final image = ref.watch(profileImageProvider);
    final isUploading = ref.watch(uploadingProvider);

    Future<void> pickAndUpload() async {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
          maxWidth: 1024,
        );

        if (pickedFile != null) {
          final File imageFile = File(pickedFile.path);
          ref.read(profileImageProvider.notifier).state = imageFile;

          ref.read(uploadingProvider.notifier).state = true;
          try {
            await FileUploadService.uploadFile(imageFile, 'profile');
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile photo uploaded successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Upload failed: $e'),
                backgroundColor: Colors.red,
              ),
            );
          } finally {
            ref.read(uploadingProvider.notifier).state = false;
          }
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Your Profile Photo',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'This photo will appear on your public profile.',
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
        const SizedBox(height: 24),

        if (image != null) ...[
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderNeutral),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (isUploading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primary),
              ),
            )
          else
            ElevatedButton(
              onPressed: pickAndUpload,
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Change Photo'),
            ),
        ] else ...[
          InkWell(
            onTap: isUploading ? null : pickAndUpload,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderNeutral),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    color: isUploading ? textSecondary : primary,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isUploading
                        ? 'Uploading...'
                        : 'Tap to upload profile photo',
                    style: TextStyle(
                      fontSize: 16,
                      color: isUploading ? textSecondary : textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'JPG, PNG formats',
                    style: TextStyle(fontSize: 12, color: textSecondary),
                  ),
                ],
              ),
            ),
          ),
        ],

        // Add the avatar guide image - takes remaining space
        const SizedBox(height: 24),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderNeutral),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Photo Guidelines:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/avatar_guide.jpg',
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectTile({
    required String title,
    String? subtitle,
    required bool selected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selected ? primary.withOpacity(0.1) : bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? primary : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? primary : Colors.transparent,
              border: Border.all(
                color: selected ? primary : borderNeutral,
                width: 2,
              ),
            ),
            child:
                selected
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: selected ? primary : textPrimary,
                  ),
                ),
                if (subtitle != null && subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: textSecondary),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final step = ref.watch(currentStepProvider);
    final isValid = _isStepValid(step);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'A few quick questions',
          style: TextStyle(color: textPrimary),
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: QuestionnaireProgressIndicator(
                currentIndex: step,
                totalQuestions: totalSteps,
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged:
                    (i) => ref.read(currentStepProvider.notifier).state = i,
                children: [
                  _wrapCard(_modalSelectionStep(ref)),
                  _wrapCard(_languagesStep(ref)),
                  _wrapCard(_workTimeStep(ref)),
                  _wrapCard(_bioStep(ref)),
                  _wrapCard(_expertiseStep(ref)), // NEW: Step 4 - Expertise
                  _wrapCard(_banksStep(ref)), // Moved from 4 to 5
                  _wrapCard(_normalLicenceUploadStep(ref)), // Moved from 5 to 6
                  _wrapCard(_licenceUploadStep(ref)), // Moved from 6 to 7
                  _wrapCard(_degreeUploadStep(ref)), // Moved from 7 to 8
                  _wrapCard(
                    _professionalLicenseUploadStep(ref),
                  ), // Moved from 8 to 9

                  _wrapCard(
                    _specialTrainingUploadStep(ref),
                  ), // Moved from 10 to 11
                  _wrapCard(_profileUploadStep(ref)), // Moved from 11 to 12
                ],
              ),
            ),
          ],
        ),
      ),
      // 'licence?modalId=e14ae655-98ec-4dcd-9db3-24e5d8f18908',
      bottomNavigationBar: Container(
        color: const Color(0xFFF8FAFC),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _submitting ? null : _prev,
                style: OutlinedButton.styleFrom(
                  foregroundColor: primary,
                  side: const BorderSide(color: primary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Previous',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: step == 0 ? 1 : 2,
              child: ElevatedButton(
                onPressed:
                    _submitting ? null : (isValid ? _nextOrSubmit : null),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isValid ? primary : const Color(0xFFE2E8F0),
                  foregroundColor:
                      isValid ? Colors.white : const Color(0xFFA0AEC0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: isValid ? 2 : 0,
                ),
                child:
                    _submitting
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                        : Text(
                          step == totalSteps - 1 ? 'Complete' : 'Next',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
