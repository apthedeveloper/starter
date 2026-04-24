import 'package:flutter/material.dart';
import 'package:starter_project/app/theme/colors/color_extenstion.dart';

class AppThemeAccessor {
  final BuildContext context;

  AppThemeAccessor(this.context);

  ColorScheme get _scheme => Theme.of(context).colorScheme;
  AppThemeColors get _extra => Theme.of(context).extension<AppThemeColors>()!;

  /// Material colors
  Color get primary => _scheme.primary;
  Color get onPrimary => _scheme.onPrimary;
  Color get secondary => _scheme.secondary;
  Color get surface => _scheme.surface;
  Color get onSurface => _scheme.onSurface;
  Color get error => _scheme.error;

  /// Custom colors
  Color get success => _extra.success;
  Color get successLight => _extra.successLight;
  Color get warning => _extra.warning;
  Color get warningLight => _extra.warningLight;
  Color get info => _extra.info;
  Color get infoLight => _extra.infoLight;
  Color get errorLight => _extra.errorLight;

  Color get borderLight => _extra.borderLight;
  Color get borderDark => _extra.borderDark;
  Color get onSurfaceSecondary => _extra.onSurfaceSecondary;
  Color get backgroundLight => _extra.backgroundLight;
  Color get backgroundDark => _extra.backgroundDark;
}
