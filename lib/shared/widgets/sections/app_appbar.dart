import 'package:flutter/material.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;

  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  final bool centerTitle;
  final bool automaticallyImplyLeading;

  final double height;
  final double elevation;

  final Color? backgroundColor;
  final Color? foregroundColor;

  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.bottom,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.height = kToolbarHeight,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
  });

  factory AppAppBar.primary({required String title, List<Widget>? actions}) {
    return AppAppBar(title: title, actions: actions);
  }

  factory AppAppBar.transparent({
    required String title,
    List<Widget>? actions,
  }) {
    return AppAppBar(
      title: title,
      actions: actions,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  factory AppAppBar.modal({required String title}) {
    return AppAppBar(title: title, centerTitle: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: height,
      elevation: elevation,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
      foregroundColor: foregroundColor ?? theme.appBarTheme.foregroundColor,
      leading: leading,
      actions: actions,
      bottom: bottom,
      title: titleWidget ?? (title != null ? Text(title!) : null),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));
}
