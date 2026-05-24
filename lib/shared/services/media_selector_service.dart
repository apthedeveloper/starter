import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_project/app/theme/colors/color_accessor.dart';
import 'package:starter_project/core/error/api_exception.dart';

enum ImageSourceType { camera, gallery }

class MediaPickerService {
  static Future<XFile?> pickImage(
    ImageSourceType source, {
    int imageQuality = 100,
    double? maxWidth,
    double? maxHeight,
  }) async {
    try {
      return await ImagePicker().pickImage(
        source: source == ImageSourceType.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        requestFullMetadata: true,
      );
    } catch (e) {
      throw ApiException(
        'Image picker failed',
        raw: e,
        stackTrace: StackTrace.current,
      );
    }
  }

  static Future<List<XFile>?> pickMultipleImages({
    int imageQuality = 100,
    double? maxWidth,
    double? maxHeight,
    int? limit = 5,
  }) async {
    try {
      return await ImagePicker().pickMultiImage(
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        requestFullMetadata: true,
        limit: limit,
      );
    } catch (e) {
      throw ApiException(
        'Image picker failed',
        raw: e,
        stackTrace: StackTrace.current,
      );
    }
  }

  static Future<XFile?> pickVideo(
    ImageSourceType source, {
    Duration? maxDuration = const Duration(seconds: 30),
  }) async {
    try {
      return await ImagePicker().pickVideo(
        source: source == ImageSourceType.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        maxDuration: maxDuration,
      );
    } catch (e) {
      throw ApiException(
        'Video picker failed',
        raw: e,
        stackTrace: StackTrace.current,
      );
    }
  }

  static Future<List<XFile>?> pickMutlipleVideo(
    ImageSourceType source, {
    Duration? maxDuration = const Duration(seconds: 30),
    int? limit = 3,
  }) async {
    try {
      return await ImagePicker().pickMultiVideo(
        maxDuration: maxDuration,
        limit: limit,
      );
    } catch (e) {
      throw ApiException(
        'Video picker failed',
        raw: e,
        stackTrace: StackTrace.current,
      );
    }
  }

 static Future<XFile?> cropImage(
    String path,
    AppThemeAccessor theme, {
    List<CropAspectRatioPreset>? aspectRatioPresets,
    bool lockAspectRatio = false,
  }) async {
    try {
      List<CropAspectRatioPreset> aspectRatio =
          aspectRatioPresets ??
          [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ];

      CropAspectRatioPreset initAspectRatio = aspectRatio.isNotEmpty
          ? aspectRatio[0]
          : CropAspectRatioPreset.original;

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        compressQuality: 100,
        maxWidth: 2048,
        maxHeight: 2048,

        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Crop Image",
            toolbarColor: theme.primary,
            toolbarWidgetColor: theme.onSurface,
            backgroundColor: theme.surface,
            activeControlsWidgetColor: theme.primary,
            dimmedLayerColor: theme.onSurfaceSecondary,
            cropFrameColor: theme.primary,
            cropGridColor: theme.borderDark,
            initAspectRatio: initAspectRatio,
            lockAspectRatio: lockAspectRatio,
            cropFrameStrokeWidth: 2,
            cropGridStrokeWidth: 1,
            showCropGrid: true,
            hideBottomControls: false,
          ),
          IOSUiSettings(
            title: "Crop Image",
            doneButtonTitle: "Done",
            cancelButtonTitle: "Cancel",
            aspectRatioLockEnabled: !lockAspectRatio,
            resetAspectRatioEnabled: !lockAspectRatio,
            aspectRatioPickerButtonHidden: lockAspectRatio,
            rotateClockwiseButtonHidden: false,
            rotateButtonsHidden: false,
            resetButtonHidden: false,
            aspectRatioLockDimensionSwapEnabled: !lockAspectRatio,
          ),
        ],
      );

      return XFile(croppedFile!.path);
    } catch (e) {
      throw ApiException(
        'Image picker failed',
        raw: e,
        stackTrace: StackTrace.current,
      );
    }
  }
}
