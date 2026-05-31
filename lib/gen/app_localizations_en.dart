// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appNameSplash => 'Starter';

  @override
  String get tagline => 'Your journey starts here';

  @override
  String get loginTitle => 'Login';

  @override
  String get signUpTitle => 'Sign Up';

  @override
  String get dontHaveAccountText => 'If you don\'t have any account';

  @override
  String get haveAccountText => 'If you have any account';

  @override
  String get signup => 'Signup';

  @override
  String get login => 'Login';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Password';

  @override
  String get completeProfileTitle => 'Complete Profile';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get fullNameRequired => 'Name is required';

  @override
  String get bioLabel => 'Bio';

  @override
  String get bioHint => 'Tell us about yourself';

  @override
  String get dobLabel => 'Date of Birth';

  @override
  String get dobHint => 'Select your date of birth';

  @override
  String get dobRequired => 'Date of birth is required';

  @override
  String get genderLabel => 'Gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderOther => 'Other';

  @override
  String get genderUnknown => 'Unknown';

  @override
  String get emailAddressHint => 'Your email address';

  @override
  String get fillRequiredFieldsError => 'Please fill all required fields';

  @override
  String get selectGenderError => 'Please select a gender';

  @override
  String get selectProfileImageError => 'Please select a profile image';

  @override
  String get checkYourEmail => 'Check Your Email';

  @override
  String get sentVerificationLink => 'We\'ve sent a verification link to';

  @override
  String get checkInboxInstructions =>
      'Please check your inbox and tap the verification link to continue.';

  @override
  String get resendEmail => 'Resend Email';

  @override
  String resendEmailWithSeconds(int seconds) {
    return 'Resend Email (${seconds}s)';
  }

  @override
  String get continueBtn => 'Continue';

  @override
  String get wrongEmailText => 'Wrong email? ';

  @override
  String get goBack => 'Go Back';

  @override
  String get failedToLoadMore => 'Failed to load more';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get noDataFound => 'No data found';

  @override
  String fieldRequired(String fieldName) {
    return '$fieldName is required';
  }

  @override
  String get thisField => 'This field';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get enterValidEmail => 'Enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String passwordMinLengthError(int minLength) {
    return 'Password must be at least $minLength characters';
  }

  @override
  String get strongPasswordError =>
      'Password must include upper, lower, number & special char';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get enterValidPhone => 'Enter valid 10-digit phone number';

  @override
  String minLengthError(int length) {
    return 'Minimum $length characters required';
  }

  @override
  String maxLengthError(int length) {
    return 'Maximum $length characters allowed';
  }

  @override
  String get thisFieldRequired => 'This field is required';

  @override
  String get enterValidNumber => 'Enter a valid number';

  @override
  String get pleaseConfirmPassword => 'Please confirm password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get exitApp => 'Exit App';

  @override
  String get areYouSureYouWantToLeaveAnyUnsavedChangesWillBeLost =>
      'Are you sure you want to leave? Any unsaved changes will be lost.';

  @override
  String get exit => 'Exit';

  @override
  String get thisItem => 'this item';

  @override
  String get thisActionCannotBeUndoneAreYouAbsolutelySure =>
      'This action cannot be undone. Are you absolutely sure?';

  @override
  String get keep => 'Keep';

  @override
  String get delete => 'Delete';

  @override
  String get great => 'Great!';

  @override
  String get proceed => 'Proceed';

  @override
  String get gotIt => 'Got it';

  @override
  String get logOut => 'Log Out';

  @override
  String get youWillBeSignedOutOfYourAccount =>
      'You will be signed out of your account.';

  @override
  String get selectAVideo => 'Select a video';

  @override
  String get selectAnImage => 'Select an image';

  @override
  String get chooseFromYourVideoLibraryOrTakeAVideo =>
      'Choose from your video library or take a video';

  @override
  String get chooseFromYourGalleryOrTakeAPhoto =>
      'Choose from your gallery or take a photo';

  @override
  String get searchItem => 'Search item';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get selectFromYourVideoLibrary => 'Select from your video library';

  @override
  String get selectFromYourPhotoLibrary => 'Select from your photo library';

  @override
  String get takeAPhoto => 'Take a Photo';

  @override
  String get useCameraToCaptureNewImage => 'Use camera to capture new image';

  @override
  String get invalidImageSourceConfiguration =>
      'Invalid image source configuration';

  @override
  String get withoutContextMessages => 'withoutContextMessages';

  @override
  String get connectionTimeout => 'Connection timeout';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get requestCancelled => 'Request cancelled';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get serverError => 'Server error';

  @override
  String get failedToParseResponse => 'Failed to parse response';

  @override
  String get noFilesProvided => 'No files provided';

  @override
  String get requestFailed => 'Request failed';

  @override
  String get unexpectedError => 'Unexpected error';

  @override
  String get invalidEmailOrPassword => 'Invalid email or password';

  @override
  String get userNotFound => 'User not found';

  @override
  String get emailAlreadyInUse => 'Email already in use';

  @override
  String get weakPassword => 'Weak password';

  @override
  String get tooManyRequestsTryAgainLater =>
      'Too many requests. Try again later.';

  @override
  String get userAccountDisabled => 'User account disabled';

  @override
  String get documentNotFound => 'Document not found';

  @override
  String get authenticationFailed => 'Authentication failed';

  @override
  String get serviceUnavailable => 'Service unavailable';

  @override
  String get databaseError => 'Database error';

  @override
  String get requestTimeout => 'Request timeout';

  @override
  String get invalidDataFormat => 'Invalid data format';

  @override
  String get permissionDenied => 'Permission denied';

  @override
  String get userIsNotLoggedIn => 'User is not logged in';

  @override
  String get failedToUpdateProfilePleaseTryAgainLater =>
      'Failed to update profile. Please try again later.';

  @override
  String get failedToDeleteProfilePleaseTryAgainLater =>
      'Failed to delete profile. Please try again later.';

  @override
  String get emailIsRequired => 'Email is required';

  @override
  String get failedToResetPasswordPleaseTryAgainLater =>
      'Failed to reset password. Please try again later.';

  @override
  String get passwordIsRequired => 'Password is required';

  @override
  String get failedToLoginPleaseTryAgainLater =>
      'Failed to login. Please try again later.';

  @override
  String get failedToLogoutPleaseTryAgainLater =>
      'Failed to logout. Please try again later.';

  @override
  String get failedToGetUserProfilePleaseTryAgainLater =>
      'Failed to get user profile. Please try again later.';

  @override
  String get failedToSendVerificationEmailPleaseTryAgainLater =>
      'Failed to send verification email. Please try again later.';

  @override
  String get failedToSignupPleaseTryAgainLater =>
      'Failed to signup. Please try again later.';

  @override
  String get failedToListenAuthStateChanges =>
      'Failed to listen auth state changes';

  @override
  String get signupFailed => 'Signup failed';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get verificationEmailSent => 'Verification email sent';

  @override
  String get failedToSendVerificationEmail =>
      'Failed to send verification email';

  @override
  String get failedToRefreshCurrentUser => 'Failed to refresh current user';

  @override
  String get failedToLogout => 'Failed to logout';

  @override
  String get pleaseVerifyYourEmailFirst => 'Please verify your email first';

  @override
  String get profileCompletedSuccessfully => 'Profile completed successfully';

  @override
  String get failedToCompleteProfile => 'Failed to complete profile';

  @override
  String get imagePickerFailed => 'Image picker failed';

  @override
  String get videoPickerFailed => 'Video picker failed';

  @override
  String get cropImage => 'Crop Image';

  @override
  String get done => 'Done';

  @override
  String get pleaseTryAgain => 'Please try again';

  @override
  String get provideEitherIconOrLottieAssetNotBoth =>
      'Provide either icon or lottieAsset, not both.';

  @override
  String get tryRefreshingOrCheckBackLater =>
      'Try refreshing or check back later';

  @override
  String get retry => 'Retry';

  @override
  String get refresh => 'Refresh';

  @override
  String get permissionLocationName => 'Location';

  @override
  String get permissionCameraName => 'Camera';

  @override
  String get permissionPhotosName => 'Photos';

  @override
  String get permissionMicrophoneName => 'Microphone';

  @override
  String get permissionNotificationName => 'Notifications';

  @override
  String get permissionBluetoothName => 'Bluetooth';

  @override
  String get permissionContactsName => 'Contacts';

  @override
  String get permissionCalendarName => 'Calendar';

  @override
  String get permissionRemindersName => 'Reminders';

  @override
  String get permissionStorageName => 'Storage';

  @override
  String enablePermissionAccess(String permission) {
    return 'Enable $permission Access';
  }

  @override
  String defaultPermissionExplanation(String permission) {
    return 'We need access to your $permission to provide full functionality. Rest assured, your data is kept secure.';
  }

  @override
  String get grantPermission => 'Grant Permission';

  @override
  String get notNow => 'Not Now';

  @override
  String serviceIsOff(String service) {
    return '$service is Off';
  }

  @override
  String serviceOffExplanation(String service) {
    return 'Your system $service seems to be disabled. To proceed, please toggle it on in settings.';
  }

  @override
  String get bluetoothService => 'Bluetooth';

  @override
  String get locationServices => 'Location Services';

  @override
  String get serviceDisabledBullet1 => 'Required to scan and connect devices';

  @override
  String get serviceDisabledBullet2 => 'Enables native discovery features';

  @override
  String get serviceDisabledBullet3 =>
      'Turn on directly in your phone settings panel';

  @override
  String get openSystemSettings => 'Open System Settings';

  @override
  String get goBackBtn => 'Go Back';

  @override
  String permissionAccessDisabled(String permission) {
    return '$permission Access Disabled';
  }

  @override
  String permissionDisabledExplanation(String permission) {
    return 'You have permanently disabled $permission access. Please follow these quick steps to re-enable:';
  }

  @override
  String get permanentlyDeniedBullet1 => '1. Tap \"Open Settings\" below.';

  @override
  String permanentlyDeniedBullet2(String permission) {
    return '2. Select \"Permissions\" (or \"$permission\").';
  }

  @override
  String get permanentlyDeniedBullet3 =>
      '3. Toggle the permission to \"Allowed\" or \"Always\".';

  @override
  String get openAppSettings => 'Open App Settings';

  @override
  String get bulletLocation1 => 'Find nearby locations and destinations';

  @override
  String get bulletLocation2 => 'Get highly accurate mapping features';

  @override
  String get bulletLocation3 => 'Optimize routes and navigation guidelines';

  @override
  String get bulletCamera1 => 'Take beautiful photos and video directly in-app';

  @override
  String get bulletCamera2 => 'Scan QR codes instantly';

  @override
  String get bulletCamera3 => 'Personalize your avatar dynamically';

  @override
  String get bulletPhotos1 =>
      'Select and upload existing photos from your library';

  @override
  String get bulletPhotos2 => 'Save downloaded media safely to your device';

  @override
  String get bulletPhotos3 => 'Manage album-specific selections';

  @override
  String get bulletMicrophone1 => 'Record high-quality voice audio notes';

  @override
  String get bulletMicrophone2 => 'Enable hands-free speech interactions';

  @override
  String get bulletMicrophone3 => 'Capture sound during video recordings';

  @override
  String get bulletNotification1 =>
      'Receive instant real-time alerts and updates';

  @override
  String get bulletNotification2 =>
      'Get notification of critical security events';

  @override
  String get bulletNotification3 => 'Never miss a message or app reminder';

  @override
  String get bulletBluetooth1 =>
      'Scan and sync with external hardware accessories';

  @override
  String get bulletBluetooth2 => 'Enable local peer-to-peer data transfers';

  @override
  String get bulletBluetooth3 => 'Provide premium local connectivity modes';

  @override
  String get bulletContacts1 => 'Find and connect with friends instantly';

  @override
  String get bulletContacts2 => 'Auto-complete recipient contact details';

  @override
  String get bulletContacts3 => 'Share referral codes with direct contacts';

  @override
  String get bulletCalendar1 => 'Sync events and deadlines directly';

  @override
  String get bulletCalendar2 => 'Avoid schedule overlaps and conflicts';

  @override
  String get bulletCalendar3 => 'Never miss your plan dates';

  @override
  String get bulletReminders1 => 'Schedule task-specific push alerts';

  @override
  String get bulletReminders2 => 'Manage critical step checklists';

  @override
  String get bulletReminders3 => 'Receive alarm calls for quick actions';

  @override
  String get bulletStorage1 => 'Store and access documents offline';

  @override
  String get bulletStorage2 => 'Save application cache to run faster';

  @override
  String get bulletStorage3 => 'Import system files and download logs';
}
