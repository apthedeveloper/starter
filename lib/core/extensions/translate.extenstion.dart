import 'package:flutter/widgets.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/gen/app_localizations_en.dart';

extension TranslateExtension on String {
  String tr(BuildContext context) {
    final loc = AppLocalizationsEn();

    if (this == loc.withoutContextMessages) {
      return context.localizations.withoutContextMessages;
    }
    if (this == loc.connectionTimeout) {
      return context.localizations.connectionTimeout;
    }
    if (this == loc.today) {
      return context.localizations.today;
    }
    if (this == loc.yesterday) {
      return context.localizations.yesterday;
    }
    if (this == loc.tomorrow) {
      return context.localizations.tomorrow;
    }
    if (this == loc.requestCancelled) {
      return context.localizations.requestCancelled;
    }
    if (this == loc.noInternetConnection) {
      return context.localizations.noInternetConnection;
    }
    if (this == loc.serverError) {
      return context.localizations.serverError;
    }
    if (this == loc.failedToParseResponse) {
      return context.localizations.failedToParseResponse;
    }
    if (this == loc.noFilesProvided) {
      return context.localizations.noFilesProvided;
    }
    if (this == loc.requestFailed) {
      return context.localizations.requestFailed;
    }
    if (this == loc.unexpectedError) {
      return context.localizations.unexpectedError;
    }
    if (this == loc.invalidEmailOrPassword) {
      return context.localizations.invalidEmailOrPassword;
    }
    if (this == loc.userNotFound) {
      return context.localizations.userNotFound;
    }
    if (this == loc.emailAlreadyInUse) {
      return context.localizations.emailAlreadyInUse;
    }
    if (this == loc.weakPassword) {
      return context.localizations.weakPassword;
    }
    if (this == loc.tooManyRequestsTryAgainLater) {
      return context.localizations.tooManyRequestsTryAgainLater;
    }
    if (this == loc.userAccountDisabled) {
      return context.localizations.userAccountDisabled;
    }
    if (this == loc.documentNotFound) {
      return context.localizations.documentNotFound;
    }
    if (this == loc.authenticationFailed) {
      return context.localizations.authenticationFailed;
    }
    if (this == loc.serviceUnavailable) {
      return context.localizations.serviceUnavailable;
    }
    if (this == loc.databaseError) {
      return context.localizations.databaseError;
    }
    if (this == loc.requestTimeout) {
      return context.localizations.requestTimeout;
    }
    if (this == loc.invalidDataFormat) {
      return context.localizations.invalidDataFormat;
    }
    if (this == loc.permissionDenied) {
      return context.localizations.permissionDenied;
    }
    if (this == loc.userIsNotLoggedIn) {
      return context.localizations.userIsNotLoggedIn;
    }
    if (this == loc.failedToUpdateProfilePleaseTryAgainLater) {
      return context.localizations.failedToUpdateProfilePleaseTryAgainLater;
    }
    if (this == loc.failedToDeleteProfilePleaseTryAgainLater) {
      return context.localizations.failedToDeleteProfilePleaseTryAgainLater;
    }
    if (this == loc.emailIsRequired) {
      return context.localizations.emailIsRequired;
    }
    if (this == loc.failedToResetPasswordPleaseTryAgainLater) {
      return context.localizations.failedToResetPasswordPleaseTryAgainLater;
    }
    if (this == loc.passwordIsRequired) {
      return context.localizations.passwordIsRequired;
    }
    if (this == loc.failedToLoginPleaseTryAgainLater) {
      return context.localizations.failedToLoginPleaseTryAgainLater;
    }
    if (this == loc.failedToLogoutPleaseTryAgainLater) {
      return context.localizations.failedToLogoutPleaseTryAgainLater;
    }
    if (this == loc.failedToGetUserProfilePleaseTryAgainLater) {
      return context.localizations.failedToGetUserProfilePleaseTryAgainLater;
    }
    if (this == loc.failedToSendVerificationEmailPleaseTryAgainLater) {
      return context
          .localizations
          .failedToSendVerificationEmailPleaseTryAgainLater;
    }
    if (this == loc.failedToSignupPleaseTryAgainLater) {
      return context.localizations.failedToSignupPleaseTryAgainLater;
    }
    if (this == loc.failedToListenAuthStateChanges) {
      return context.localizations.failedToListenAuthStateChanges;
    }
    if (this == loc.signupFailed) {
      return context.localizations.signupFailed;
    }
    if (this == loc.loginFailed) {
      return context.localizations.loginFailed;
    }
    if (this == loc.verificationEmailSent) {
      return context.localizations.verificationEmailSent;
    }
    if (this == loc.failedToSendVerificationEmail) {
      return context.localizations.failedToSendVerificationEmail;
    }
    if (this == loc.failedToRefreshCurrentUser) {
      return context.localizations.failedToRefreshCurrentUser;
    }
    if (this == loc.failedToLogout) {
      return context.localizations.failedToLogout;
    }
    if (this == loc.pleaseVerifyYourEmailFirst) {
      return context.localizations.pleaseVerifyYourEmailFirst;
    }
    if (this == loc.profileCompletedSuccessfully) {
      return context.localizations.profileCompletedSuccessfully;
    }
    if (this == loc.failedToCompleteProfile) {
      return context.localizations.failedToCompleteProfile;
    }
    if (this == loc.imagePickerFailed) {
      return context.localizations.imagePickerFailed;
    }
    if (this == loc.videoPickerFailed) {
      return context.localizations.videoPickerFailed;
    }
    if (this == loc.cropImage) {
      return context.localizations.cropImage;
    }
    if (this == loc.done) {
      return context.localizations.done;
    }
    if (this == loc.pleaseTryAgain) {
      return context.localizations.pleaseTryAgain;
    }
    if (this == loc.provideEitherIconOrLottieAssetNotBoth) {
      return context.localizations.provideEitherIconOrLottieAssetNotBoth;
    }
    if (this == loc.tryRefreshingOrCheckBackLater) {
      return context.localizations.tryRefreshingOrCheckBackLater;
    }
    if (this == loc.retry) {
      return context.localizations.retry;
    }
    if (this == loc.refresh) {
      return context.localizations.refresh;
    }

    return this;
  }
}
