import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/textstyle_extenstion.dart';
import 'package:starter_project/shared/services/media_selector_service.dart';

class AppMediaPickerSheet extends StatefulWidget {
  final List<CropAspectRatioPreset>? aspectRatioPresets;
  final bool lockAspectRatio;
  final bool isVideo;

  const AppMediaPickerSheet({
    super.key,
    this.aspectRatioPresets,
    this.lockAspectRatio = false,
   required this.isVideo
  });

  @override
  State<AppMediaPickerSheet> createState() => _CustomImagePickerSheetState();
}

class _CustomImagePickerSheetState extends State<AppMediaPickerSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildOptionTile(
            icon: Icons.photo_library_rounded,
            title: "Choose from Gallery",
            subtitle: widget.isVideo
                ? "Select from your video library"
                : "Select from your photo library",
            onTap: () async { 
              final pickedFile = widget.isVideo
                  ? await MediaPickerService.pickVideo(ImageSourceType.gallery)
                  : await MediaPickerService.pickImage(ImageSourceType.gallery);

              if (!mounted) return;
              context.pop<XFile?>(pickedFile);
            },
          ),
          const SizedBox(height: 12),
          _buildOptionTile(
            icon: Icons.camera_alt_rounded,
            title: "Take a Photo",
            subtitle: "Use camera to capture new image",
            onTap: () async { 
              final pickedFile = widget.isVideo
                  ? await MediaPickerService.pickVideo(ImageSourceType.camera)
                  : await MediaPickerService.pickImage(ImageSourceType.camera);

              if (!mounted) return;
              context.pop<XFile?>(pickedFile);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.borderLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: context.colors.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.colors.primary.withValues(alpha: 0.9),
                      context.colors.primary.withValues(alpha: 0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.backgroundLight.withValues(
                        alpha: 0.2,
                      ),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: context.colors.surface, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: context.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: context.textTheme.labelMedium!.colour(
                        context.colors.onSurfaceSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: context.colors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
