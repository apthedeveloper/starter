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
}
