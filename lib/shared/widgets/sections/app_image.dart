import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quick_container/quick_container.dart';
import 'package:shimmer/shimmer.dart';

enum AppImageType { network, asset, file, memory }

class AppImage extends StatelessWidget {
  final AppImageType type;

  final String? imageUrl;
  final String? assetPath;
  final File? file;
  final Uint8List? memoryBytes;

  final double? width;
  final double? height;

  final BoxFit fit;

  final BorderRadius? borderRadius;
  final ImageProvider? fallbackImage;

  final Widget? errorWidget;
  final Widget? placeholder;

  final Color? color;
  final Color? backgroundColor;

  final bool enableHero;
  final String? heroTag;

  final bool enableShimmer;

  final Duration fadeDuration;

  final BoxShape shape;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final VoidCallback? onTap;
  AppImage({
    super.key,
    required this.type,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorWidget,
    this.placeholder,
    this.color,
    this.backgroundColor,
    this.enableHero = false,
    this.heroTag,
    this.enableShimmer = true,
    this.fadeDuration = const Duration(milliseconds: 250),
    this.shape = BoxShape.rectangle,
    this.padding,
    this.margin,
    this.onTap,
    this.assetPath,
    this.file,
    this.memoryBytes,
    this.fallbackImage,
  }) : assert(switch (type) {
         AppImageType.network =>
           imageUrl != null &&
               imageUrl.isNotEmpty &&
               assetPath == null &&
               file == null &&
               memoryBytes == null,

         AppImageType.asset =>
           assetPath != null &&
               assetPath.isNotEmpty &&
               imageUrl == null &&
               file == null &&
               memoryBytes == null,

         AppImageType.file =>
           file != null &&
               imageUrl == null &&
               assetPath == null &&
               memoryBytes == null,

         AppImageType.memory =>
           memoryBytes != null &&
               imageUrl == null &&
               assetPath == null &&
               file == null,
       }, 'Invalid image source configuration');
  const AppImage.network({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorWidget,
    this.placeholder,
    this.color,
    this.backgroundColor,
    this.enableHero = false,
    this.heroTag,
    this.enableShimmer = true,
    this.fadeDuration = const Duration(milliseconds: 250),
    this.shape = BoxShape.rectangle,
    this.padding,
    this.margin,
    this.onTap,
    this.fallbackImage,
  }) : type = AppImageType.network,
       assetPath = null,
       file = null,
       memoryBytes = null;

  const AppImage.asset({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.color,
    this.backgroundColor,
    this.enableHero = false,
    this.heroTag,
    this.enableShimmer = false,
    this.fadeDuration = const Duration(milliseconds: 250),
    this.shape = BoxShape.rectangle,
    this.padding,
    this.margin,
    this.onTap,
    this.fallbackImage,
  }) : type = AppImageType.asset,
       imageUrl = null,
       file = null,
       memoryBytes = null,
       errorWidget = null,
       placeholder = null;

  const AppImage.file({
    super.key,
    required this.file,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.backgroundColor,
    this.enableHero = false,
    this.heroTag,
    this.enableShimmer = false,
    this.fadeDuration = const Duration(milliseconds: 250),
    this.shape = BoxShape.rectangle,
    this.padding,
    this.margin,
    this.onTap,
    this.fallbackImage,
  }) : type = AppImageType.file,
       imageUrl = null,
       assetPath = null,
       memoryBytes = null,
       errorWidget = null,
       placeholder = null,
       color = null;

  const AppImage.memory({
    super.key,
    required this.memoryBytes,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.backgroundColor,
    this.enableHero = false,
    this.heroTag,
    this.enableShimmer = false,
    this.fadeDuration = const Duration(milliseconds: 250),
    this.shape = BoxShape.rectangle,
    this.padding,
    this.margin,
    this.onTap,
    this.fallbackImage,
  }) : type = AppImageType.memory,
       imageUrl = null,
       assetPath = null,
       file = null,
       errorWidget = null,
       placeholder = null,
       color = null;

  @override
  Widget build(BuildContext context) {
    Widget child;

    switch (type) {
      case AppImageType.network:
        child = CachedNetworkImage(
          imageUrl: imageUrl ?? '',
          width: width,
          height: height,
          fit: fit,
          color: color,
          fadeInDuration: fadeDuration,

          placeholder: (_, _) =>
              placeholder ??
              _ShimmerPlaceholder(
                width: width,
                height: height,
                borderRadius: borderRadius,
                enabled: enableShimmer,
              ),

          errorWidget: errorBuilder,
        );
        break;

      case AppImageType.asset:
        child = Image.asset(
          assetPath ?? '',
          width: width,
          height: height,
          fit: fit,
          color: color,
          errorBuilder: errorBuilder,
        );
        break;

      case AppImageType.file:
        child = Image.file(
          file!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: errorBuilder,
        );
        break;

      case AppImageType.memory:
        child = Image.memory(
          memoryBytes!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: errorBuilder,
        );
        break;
    }

    child = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: shape == BoxShape.circle ? null : borderRadius,
        shape: shape,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );

    if (enableHero && heroTag != null) {
      child = Hero(tag: heroTag!, child: child);
    }

    if (onTap != null) {
      child = GestureDetector(onTap: onTap, child: child);
    }

    return child;
  }

  Widget errorBuilder(_, _, _) {
    if (fallbackImage != null) {
      return Image(
        image: fallbackImage!,
        width: width,
        height: height,
        fit: fit,
      );
    }

    return errorWidget ??
        QuickContainer(
          w: width,
          h: height,
          alignment: Alignment.center,
          color: Colors.grey.shade200,
          child: Icon(Icons.broken_image_outlined, color: Colors.grey.shade500),
        );
  }
}

class _ShimmerPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool enabled;

  const _ShimmerPlaceholder({
    this.width,
    this.height,
    this.borderRadius,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final child = QuickContainer(
      w: width,
      h: height,
        color: Colors.grey.shade300,
        borderRadius: borderRadius,
    );

    if (!enabled) return child;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }
}
