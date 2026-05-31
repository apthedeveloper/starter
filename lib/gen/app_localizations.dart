import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appNameSplash.
  ///
  /// In en, this message translates to:
  /// **'Starter'**
  String get appNameSplash;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Your journey starts here'**
  String get tagline;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpTitle;

  /// No description provided for @dontHaveAccountText.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t have any account'**
  String get dontHaveAccountText;

  /// No description provided for @haveAccountText.
  ///
  /// In en, this message translates to:
  /// **'If you have any account'**
  String get haveAccountText;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// No description provided for @completeProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get completeProfileTitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get fullNameRequired;

  /// No description provided for @bioLabel.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bioLabel;

  /// No description provided for @bioHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get bioHint;

  /// No description provided for @dobLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dobLabel;

  /// No description provided for @dobHint.
  ///
  /// In en, this message translates to:
  /// **'Select your date of birth'**
  String get dobHint;

  /// No description provided for @dobRequired.
  ///
  /// In en, this message translates to:
  /// **'Date of birth is required'**
  String get dobRequired;

  /// No description provided for @genderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderLabel;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get genderOther;

  /// No description provided for @genderUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get genderUnknown;

  /// No description provided for @emailAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Your email address'**
  String get emailAddressHint;

  /// No description provided for @fillRequiredFieldsError.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get fillRequiredFieldsError;

  /// No description provided for @selectGenderError.
  ///
  /// In en, this message translates to:
  /// **'Please select a gender'**
  String get selectGenderError;

  /// No description provided for @selectProfileImageError.
  ///
  /// In en, this message translates to:
  /// **'Please select a profile image'**
  String get selectProfileImageError;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check Your Email'**
  String get checkYourEmail;

  /// No description provided for @sentVerificationLink.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a verification link to'**
  String get sentVerificationLink;

  /// No description provided for @checkInboxInstructions.
  ///
  /// In en, this message translates to:
  /// **'Please check your inbox and tap the verification link to continue.'**
  String get checkInboxInstructions;

  /// No description provided for @resendEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get resendEmail;

  /// No description provided for @resendEmailWithSeconds.
  ///
  /// In en, this message translates to:
  /// **'Resend Email ({seconds}s)'**
  String resendEmailWithSeconds(int seconds);

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @wrongEmailText.
  ///
  /// In en, this message translates to:
  /// **'Wrong email? '**
  String get wrongEmailText;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @failedToLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Failed to load more'**
  String get failedToLoadMore;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get noDataFound;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} is required'**
  String fieldRequired(String fieldName);

  /// No description provided for @thisField.
  ///
  /// In en, this message translates to:
  /// **'This field'**
  String get thisField;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinLengthError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {minLength} characters'**
  String passwordMinLengthError(int minLength);

  /// No description provided for @strongPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Password must include upper, lower, number & special char'**
  String get strongPasswordError;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequired;

  /// No description provided for @enterValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter valid 10-digit phone number'**
  String get enterValidPhone;

  /// No description provided for @minLengthError.
  ///
  /// In en, this message translates to:
  /// **'Minimum {length} characters required'**
  String minLengthError(int length);

  /// No description provided for @maxLengthError.
  ///
  /// In en, this message translates to:
  /// **'Maximum {length} characters allowed'**
  String maxLengthError(int length);

  /// No description provided for @thisFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get thisFieldRequired;

  /// No description provided for @enterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get enterValidNumber;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm password'**
  String get pleaseConfirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exitApp;

  /// No description provided for @areYouSureYouWantToLeaveAnyUnsavedChangesWillBeLost.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to leave? Any unsaved changes will be lost.'**
  String get areYouSureYouWantToLeaveAnyUnsavedChangesWillBeLost;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @thisItem.
  ///
  /// In en, this message translates to:
  /// **'this item'**
  String get thisItem;

  /// No description provided for @thisActionCannotBeUndoneAreYouAbsolutelySure.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. Are you absolutely sure?'**
  String get thisActionCannotBeUndoneAreYouAbsolutelySure;

  /// No description provided for @keep.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get keep;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @great.
  ///
  /// In en, this message translates to:
  /// **'Great!'**
  String get great;

  /// No description provided for @proceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @youWillBeSignedOutOfYourAccount.
  ///
  /// In en, this message translates to:
  /// **'You will be signed out of your account.'**
  String get youWillBeSignedOutOfYourAccount;

  /// No description provided for @selectAVideo.
  ///
  /// In en, this message translates to:
  /// **'Select a video'**
  String get selectAVideo;

  /// No description provided for @selectAnImage.
  ///
  /// In en, this message translates to:
  /// **'Select an image'**
  String get selectAnImage;

  /// No description provided for @chooseFromYourVideoLibraryOrTakeAVideo.
  ///
  /// In en, this message translates to:
  /// **'Choose from your video library or take a video'**
  String get chooseFromYourVideoLibraryOrTakeAVideo;

  /// No description provided for @chooseFromYourGalleryOrTakeAPhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose from your gallery or take a photo'**
  String get chooseFromYourGalleryOrTakeAPhoto;

  /// No description provided for @searchItem.
  ///
  /// In en, this message translates to:
  /// **'Search item'**
  String get searchItem;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @selectFromYourVideoLibrary.
  ///
  /// In en, this message translates to:
  /// **'Select from your video library'**
  String get selectFromYourVideoLibrary;

  /// No description provided for @selectFromYourPhotoLibrary.
  ///
  /// In en, this message translates to:
  /// **'Select from your photo library'**
  String get selectFromYourPhotoLibrary;

  /// No description provided for @takeAPhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get takeAPhoto;

  /// No description provided for @useCameraToCaptureNewImage.
  ///
  /// In en, this message translates to:
  /// **'Use camera to capture new image'**
  String get useCameraToCaptureNewImage;

  /// No description provided for @invalidImageSourceConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Invalid image source configuration'**
  String get invalidImageSourceConfiguration;

  /// No description provided for @withoutContextMessages.
  ///
  /// In en, this message translates to:
  /// **'withoutContextMessages'**
  String get withoutContextMessages;

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout'**
  String get connectionTimeout;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @requestCancelled.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled'**
  String get requestCancelled;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get serverError;

  /// No description provided for @failedToParseResponse.
  ///
  /// In en, this message translates to:
  /// **'Failed to parse response'**
  String get failedToParseResponse;

  /// No description provided for @noFilesProvided.
  ///
  /// In en, this message translates to:
  /// **'No files provided'**
  String get noFilesProvided;

  /// No description provided for @requestFailed.
  ///
  /// In en, this message translates to:
  /// **'Request failed'**
  String get requestFailed;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error'**
  String get unexpectedError;

  /// No description provided for @invalidEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalidEmailOrPassword;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'Email already in use'**
  String get emailAlreadyInUse;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Weak password'**
  String get weakPassword;

  /// No description provided for @tooManyRequestsTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Try again later.'**
  String get tooManyRequestsTryAgainLater;

  /// No description provided for @userAccountDisabled.
  ///
  /// In en, this message translates to:
  /// **'User account disabled'**
  String get userAccountDisabled;

  /// No description provided for @documentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Document not found'**
  String get documentNotFound;

  /// No description provided for @authenticationFailed.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed'**
  String get authenticationFailed;

  /// No description provided for @serviceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Service unavailable'**
  String get serviceUnavailable;

  /// No description provided for @databaseError.
  ///
  /// In en, this message translates to:
  /// **'Database error'**
  String get databaseError;

  /// No description provided for @requestTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timeout'**
  String get requestTimeout;

  /// No description provided for @invalidDataFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid data format'**
  String get invalidDataFormat;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied'**
  String get permissionDenied;

  /// No description provided for @userIsNotLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'User is not logged in'**
  String get userIsNotLoggedIn;

  /// No description provided for @failedToUpdateProfilePleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile. Please try again later.'**
  String get failedToUpdateProfilePleaseTryAgainLater;

  /// No description provided for @failedToDeleteProfilePleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete profile. Please try again later.'**
  String get failedToDeleteProfilePleaseTryAgainLater;

  /// No description provided for @emailIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailIsRequired;

  /// No description provided for @failedToResetPasswordPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset password. Please try again later.'**
  String get failedToResetPasswordPleaseTryAgainLater;

  /// No description provided for @passwordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordIsRequired;

  /// No description provided for @failedToLoginPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Failed to login. Please try again later.'**
  String get failedToLoginPleaseTryAgainLater;

  /// No description provided for @failedToLogoutPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Failed to logout. Please try again later.'**
  String get failedToLogoutPleaseTryAgainLater;

  /// No description provided for @failedToGetUserProfilePleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Failed to get user profile. Please try again later.'**
  String get failedToGetUserProfilePleaseTryAgainLater;

  /// No description provided for @failedToSendVerificationEmailPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Failed to send verification email. Please try again later.'**
  String get failedToSendVerificationEmailPleaseTryAgainLater;

  /// No description provided for @failedToSignupPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Failed to signup. Please try again later.'**
  String get failedToSignupPleaseTryAgainLater;

  /// No description provided for @failedToListenAuthStateChanges.
  ///
  /// In en, this message translates to:
  /// **'Failed to listen auth state changes'**
  String get failedToListenAuthStateChanges;

  /// No description provided for @signupFailed.
  ///
  /// In en, this message translates to:
  /// **'Signup failed'**
  String get signupFailed;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @verificationEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Verification email sent'**
  String get verificationEmailSent;

  /// No description provided for @failedToSendVerificationEmail.
  ///
  /// In en, this message translates to:
  /// **'Failed to send verification email'**
  String get failedToSendVerificationEmail;

  /// No description provided for @failedToRefreshCurrentUser.
  ///
  /// In en, this message translates to:
  /// **'Failed to refresh current user'**
  String get failedToRefreshCurrentUser;

  /// No description provided for @failedToLogout.
  ///
  /// In en, this message translates to:
  /// **'Failed to logout'**
  String get failedToLogout;

  /// No description provided for @pleaseVerifyYourEmailFirst.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email first'**
  String get pleaseVerifyYourEmailFirst;

  /// No description provided for @profileCompletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile completed successfully'**
  String get profileCompletedSuccessfully;

  /// No description provided for @failedToCompleteProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to complete profile'**
  String get failedToCompleteProfile;

  /// No description provided for @imagePickerFailed.
  ///
  /// In en, this message translates to:
  /// **'Image picker failed'**
  String get imagePickerFailed;

  /// No description provided for @videoPickerFailed.
  ///
  /// In en, this message translates to:
  /// **'Video picker failed'**
  String get videoPickerFailed;

  /// No description provided for @cropImage.
  ///
  /// In en, this message translates to:
  /// **'Crop Image'**
  String get cropImage;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @pleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get pleaseTryAgain;

  /// No description provided for @provideEitherIconOrLottieAssetNotBoth.
  ///
  /// In en, this message translates to:
  /// **'Provide either icon or lottieAsset, not both.'**
  String get provideEitherIconOrLottieAssetNotBoth;

  /// No description provided for @tryRefreshingOrCheckBackLater.
  ///
  /// In en, this message translates to:
  /// **'Try refreshing or check back later'**
  String get tryRefreshingOrCheckBackLater;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @permissionLocationName.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get permissionLocationName;

  /// No description provided for @permissionCameraName.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get permissionCameraName;

  /// No description provided for @permissionPhotosName.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get permissionPhotosName;

  /// No description provided for @permissionMicrophoneName.
  ///
  /// In en, this message translates to:
  /// **'Microphone'**
  String get permissionMicrophoneName;

  /// No description provided for @permissionNotificationName.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get permissionNotificationName;

  /// No description provided for @permissionBluetoothName.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get permissionBluetoothName;

  /// No description provided for @permissionContactsName.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get permissionContactsName;

  /// No description provided for @permissionCalendarName.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get permissionCalendarName;

  /// No description provided for @permissionRemindersName.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get permissionRemindersName;

  /// No description provided for @permissionStorageName.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get permissionStorageName;

  /// No description provided for @enablePermissionAccess.
  ///
  /// In en, this message translates to:
  /// **'Enable {permission} Access'**
  String enablePermissionAccess(String permission);

  /// No description provided for @defaultPermissionExplanation.
  ///
  /// In en, this message translates to:
  /// **'We need access to your {permission} to provide full functionality. Rest assured, your data is kept secure.'**
  String defaultPermissionExplanation(String permission);

  /// No description provided for @grantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get grantPermission;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get notNow;

  /// No description provided for @serviceIsOff.
  ///
  /// In en, this message translates to:
  /// **'{service} is Off'**
  String serviceIsOff(String service);

  /// No description provided for @serviceOffExplanation.
  ///
  /// In en, this message translates to:
  /// **'Your system {service} seems to be disabled. To proceed, please toggle it on in settings.'**
  String serviceOffExplanation(String service);

  /// No description provided for @bluetoothService.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get bluetoothService;

  /// No description provided for @locationServices.
  ///
  /// In en, this message translates to:
  /// **'Location Services'**
  String get locationServices;

  /// No description provided for @serviceDisabledBullet1.
  ///
  /// In en, this message translates to:
  /// **'Required to scan and connect devices'**
  String get serviceDisabledBullet1;

  /// No description provided for @serviceDisabledBullet2.
  ///
  /// In en, this message translates to:
  /// **'Enables native discovery features'**
  String get serviceDisabledBullet2;

  /// No description provided for @serviceDisabledBullet3.
  ///
  /// In en, this message translates to:
  /// **'Turn on directly in your phone settings panel'**
  String get serviceDisabledBullet3;

  /// No description provided for @openSystemSettings.
  ///
  /// In en, this message translates to:
  /// **'Open System Settings'**
  String get openSystemSettings;

  /// No description provided for @goBackBtn.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBackBtn;

  /// No description provided for @permissionAccessDisabled.
  ///
  /// In en, this message translates to:
  /// **'{permission} Access Disabled'**
  String permissionAccessDisabled(String permission);

  /// No description provided for @permissionDisabledExplanation.
  ///
  /// In en, this message translates to:
  /// **'You have permanently disabled {permission} access. Please follow these quick steps to re-enable:'**
  String permissionDisabledExplanation(String permission);

  /// No description provided for @permanentlyDeniedBullet1.
  ///
  /// In en, this message translates to:
  /// **'1. Tap \"Open Settings\" below.'**
  String get permanentlyDeniedBullet1;

  /// No description provided for @permanentlyDeniedBullet2.
  ///
  /// In en, this message translates to:
  /// **'2. Select \"Permissions\" (or \"{permission}\").'**
  String permanentlyDeniedBullet2(String permission);

  /// No description provided for @permanentlyDeniedBullet3.
  ///
  /// In en, this message translates to:
  /// **'3. Toggle the permission to \"Allowed\" or \"Always\".'**
  String get permanentlyDeniedBullet3;

  /// No description provided for @openAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Open App Settings'**
  String get openAppSettings;

  /// No description provided for @bulletLocation1.
  ///
  /// In en, this message translates to:
  /// **'Find nearby locations and destinations'**
  String get bulletLocation1;

  /// No description provided for @bulletLocation2.
  ///
  /// In en, this message translates to:
  /// **'Get highly accurate mapping features'**
  String get bulletLocation2;

  /// No description provided for @bulletLocation3.
  ///
  /// In en, this message translates to:
  /// **'Optimize routes and navigation guidelines'**
  String get bulletLocation3;

  /// No description provided for @bulletCamera1.
  ///
  /// In en, this message translates to:
  /// **'Take beautiful photos and video directly in-app'**
  String get bulletCamera1;

  /// No description provided for @bulletCamera2.
  ///
  /// In en, this message translates to:
  /// **'Scan QR codes instantly'**
  String get bulletCamera2;

  /// No description provided for @bulletCamera3.
  ///
  /// In en, this message translates to:
  /// **'Personalize your avatar dynamically'**
  String get bulletCamera3;

  /// No description provided for @bulletPhotos1.
  ///
  /// In en, this message translates to:
  /// **'Select and upload existing photos from your library'**
  String get bulletPhotos1;

  /// No description provided for @bulletPhotos2.
  ///
  /// In en, this message translates to:
  /// **'Save downloaded media safely to your device'**
  String get bulletPhotos2;

  /// No description provided for @bulletPhotos3.
  ///
  /// In en, this message translates to:
  /// **'Manage album-specific selections'**
  String get bulletPhotos3;

  /// No description provided for @bulletMicrophone1.
  ///
  /// In en, this message translates to:
  /// **'Record high-quality voice audio notes'**
  String get bulletMicrophone1;

  /// No description provided for @bulletMicrophone2.
  ///
  /// In en, this message translates to:
  /// **'Enable hands-free speech interactions'**
  String get bulletMicrophone2;

  /// No description provided for @bulletMicrophone3.
  ///
  /// In en, this message translates to:
  /// **'Capture sound during video recordings'**
  String get bulletMicrophone3;

  /// No description provided for @bulletNotification1.
  ///
  /// In en, this message translates to:
  /// **'Receive instant real-time alerts and updates'**
  String get bulletNotification1;

  /// No description provided for @bulletNotification2.
  ///
  /// In en, this message translates to:
  /// **'Get notification of critical security events'**
  String get bulletNotification2;

  /// No description provided for @bulletNotification3.
  ///
  /// In en, this message translates to:
  /// **'Never miss a message or app reminder'**
  String get bulletNotification3;

  /// No description provided for @bulletBluetooth1.
  ///
  /// In en, this message translates to:
  /// **'Scan and sync with external hardware accessories'**
  String get bulletBluetooth1;

  /// No description provided for @bulletBluetooth2.
  ///
  /// In en, this message translates to:
  /// **'Enable local peer-to-peer data transfers'**
  String get bulletBluetooth2;

  /// No description provided for @bulletBluetooth3.
  ///
  /// In en, this message translates to:
  /// **'Provide premium local connectivity modes'**
  String get bulletBluetooth3;

  /// No description provided for @bulletContacts1.
  ///
  /// In en, this message translates to:
  /// **'Find and connect with friends instantly'**
  String get bulletContacts1;

  /// No description provided for @bulletContacts2.
  ///
  /// In en, this message translates to:
  /// **'Auto-complete recipient contact details'**
  String get bulletContacts2;

  /// No description provided for @bulletContacts3.
  ///
  /// In en, this message translates to:
  /// **'Share referral codes with direct contacts'**
  String get bulletContacts3;

  /// No description provided for @bulletCalendar1.
  ///
  /// In en, this message translates to:
  /// **'Sync events and deadlines directly'**
  String get bulletCalendar1;

  /// No description provided for @bulletCalendar2.
  ///
  /// In en, this message translates to:
  /// **'Avoid schedule overlaps and conflicts'**
  String get bulletCalendar2;

  /// No description provided for @bulletCalendar3.
  ///
  /// In en, this message translates to:
  /// **'Never miss your plan dates'**
  String get bulletCalendar3;

  /// No description provided for @bulletReminders1.
  ///
  /// In en, this message translates to:
  /// **'Schedule task-specific push alerts'**
  String get bulletReminders1;

  /// No description provided for @bulletReminders2.
  ///
  /// In en, this message translates to:
  /// **'Manage critical step checklists'**
  String get bulletReminders2;

  /// No description provided for @bulletReminders3.
  ///
  /// In en, this message translates to:
  /// **'Receive alarm calls for quick actions'**
  String get bulletReminders3;

  /// No description provided for @bulletStorage1.
  ///
  /// In en, this message translates to:
  /// **'Store and access documents offline'**
  String get bulletStorage1;

  /// No description provided for @bulletStorage2.
  ///
  /// In en, this message translates to:
  /// **'Save application cache to run faster'**
  String get bulletStorage2;

  /// No description provided for @bulletStorage3.
  ///
  /// In en, this message translates to:
  /// **'Import system files and download logs'**
  String get bulletStorage3;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
