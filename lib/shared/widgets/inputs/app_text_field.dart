import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppTextFieldType { normal, password, search, date, dropDown }

class AppTextField extends StatefulWidget {
  // ================= CORE =================
  final AppTextFieldType type;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;

  // ================= DECORATION =================
  final InputDecoration? decoration;

  // ================= TEXT INPUT =================
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextStyle? style;
  final StrutStyle? strutStyle;

  // ================= STATE =================
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool expands;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool enableInteractiveSelection;
  final bool showCursor;

  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  final List<TextInputFormatter>? inputFormatters;

  final Iterable<String>? autofillHints;

  // ================= CALLBACKS =================
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;

  final Widget? customSuffixIcon;
  final Widget? customPrefixIcon;
  final VoidCallback? onSuffixTap;
  final GestureTapCallback? onOutsideTap;

  const AppTextField({
    super.key,
    this.type = AppTextFieldType.normal,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.style,
    this.strutStyle,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.expands = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.enableInteractiveSelection = true,
    this.showCursor = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.autofillHints,
    this.onChanged,
    this.onTap,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.customSuffixIcon,
    this.customPrefixIcon,
    this.onSuffixTap,
    this.onOutsideTap,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  bool get _isPassword => widget.type == AppTextFieldType.password;
  bool get _isSearch => widget.type == AppTextFieldType.search;
  bool get _isDate => widget.type == AppTextFieldType.date;
  bool get _isDropdown => widget.type == AppTextFieldType.dropDown;

  @override
  void initState() {
    super.initState();
    _obscureText = _isPassword;
  }

  void _togglePasswordVisibility() {
    if (!_isPassword) return;
    setState(() => _obscureText = !_obscureText);
  }

  Widget? _buildPrefixIcon() {
    if (widget.customPrefixIcon != null) {
      return widget.customPrefixIcon;
    }

    if (_isSearch) {
      return const Icon(Icons.search);
    }

    return widget.decoration?.prefixIcon;
  }

  Widget? _buildSuffixIcon() {
    final userSuffix = widget.customSuffixIcon ?? widget.decoration?.suffixIcon;

    if (_isPassword) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ?userSuffix,
          IconButton(
            onPressed: _togglePasswordVisibility,
            splashRadius: 20,
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          ),
        ],
      );
    }

    if (userSuffix != null) {
      return widget.onSuffixTap != null
          ? GestureDetector(
              onTap: widget.onSuffixTap,
              behavior: HitTestBehavior.opaque,
              child: userSuffix,
            )
          : userSuffix;
    }
    if(_isDropdown){
      return const Icon(Icons.arrow_drop_down);
    }
    if (_isDate) {
      return const Icon(Icons.calendar_today_outlined);
    }

    return null;
  }

  TextInputType? _resolveKeyboardType() {
    if (widget.keyboardType != null) return widget.keyboardType;

    switch (widget.type) {
      case AppTextFieldType.password:
        return TextInputType.visiblePassword;
      case AppTextFieldType.search:
        return null;
      case AppTextFieldType.date:
        return TextInputType.datetime;
      case AppTextFieldType.normal:
        return TextInputType.text;
      case AppTextFieldType.dropDown:
        return TextInputType.text;
    }
  }

  TextInputAction? _resolveTextInputAction() {
    if (widget.textInputAction != null) return widget.textInputAction;

    switch (widget.type) {
      case AppTextFieldType.search:
        return TextInputAction.search;
      default:
        return TextInputAction.next;
    }
  }

  Iterable<String>? _resolveAutofillHints() {
    if (widget.autofillHints != null) return widget.autofillHints;

    switch (widget.type) {
      case AppTextFieldType.password:
        return const [AutofillHints.password];
      case AppTextFieldType.search:
        return const [AutofillHints.username];
      case AppTextFieldType.date:
        return null;
      case AppTextFieldType.normal:
        return null;
      case AppTextFieldType.dropDown:
        return null;
    }
  }

  bool get _effectiveReadOnly => widget.readOnly || _isDate || _isDropdown;

  int? get _effectiveMaxLines {
    if (_isPassword) return 1;
    return widget.expands ? null : widget.maxLines;
  }

  InputDecoration _buildDecoration(BuildContext context) {
    final themeDecoration = const InputDecoration().applyDefaults(
      Theme.of(context).inputDecorationTheme,
    );

    final userDecoration = widget.decoration;

    return themeDecoration.copyWith(
      hintText: userDecoration?.hintText,
      hintStyle: userDecoration?.hintStyle,
      labelText: userDecoration?.labelText,
      labelStyle: userDecoration?.labelStyle,
      helperText: userDecoration?.helperText,
      helperStyle: userDecoration?.helperStyle,
      errorText: userDecoration?.errorText,
      errorStyle: userDecoration?.errorStyle,
      counterText: userDecoration?.counterText,
      prefixIcon: _buildPrefixIcon(),
      prefix: userDecoration?.prefix,
      suffix: userDecoration?.suffix,
      suffixIcon: _buildSuffixIcon(),
      prefixText: userDecoration?.prefixText,
      suffixText: userDecoration?.suffixText,
      filled: userDecoration?.filled,
      fillColor: userDecoration?.fillColor,
      border: userDecoration?.border,
      enabledBorder: userDecoration?.enabledBorder,
      focusedBorder: userDecoration?.focusedBorder,
      disabledBorder: userDecoration?.disabledBorder,
      errorBorder: userDecoration?.errorBorder,
      focusedErrorBorder: userDecoration?.focusedErrorBorder,
      contentPadding: userDecoration?.contentPadding,
      isDense: userDecoration?.isDense,
      alignLabelWithHint: userDecoration?.alignLabelWithHint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      initialValue: widget.initialValue,
      keyboardType: _resolveKeyboardType(),
      textInputAction: _resolveTextInputAction(),
      textCapitalization: widget.textCapitalization,
      textAlign: widget.textAlign,
      style: widget.style,
      strutStyle: widget.strutStyle,
      obscureText: _obscureText,
      readOnly: _effectiveReadOnly,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      expands: widget.expands,
      autocorrect: _isPassword ? false : widget.autocorrect,
      enableSuggestions: _isPassword ? false : widget.enableSuggestions,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      showCursor: widget.showCursor,
      maxLines: _effectiveMaxLines,
      minLines: widget.expands ? null : widget.minLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      autofillHints: _resolveAutofillHints(),
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,
      decoration: _buildDecoration(context),
      onTapOutside: (_) => widget.onOutsideTap?.call(),
    );
  }
}
