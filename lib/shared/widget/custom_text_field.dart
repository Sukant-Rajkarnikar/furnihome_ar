import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/text_styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final TextInputType inputType;
  final String hintText;
  final bool hasError;
  final bool obscureText;
  final bool isEnabled;
  final bool isReadOnly;
  final bool isPassword;
  final double borderRadius;
  final Function(String)? onChanged;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;

  const CustomTextField({
    super.key,
    required this.textController,
    required this.hintText,
    this.hasError = false,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.isPassword = false,
    this.borderRadius = Dimens.spacing_12,
    this.decoration,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: const AppColors().primaryColor.withAlpha(50),
                  blurRadius: Dimens.spacing_4,
                  offset: const Offset(0, 4),
                )
              ]
            : [BoxShadow(
            color: AppColors.grey_rgba_4C4C4C.withAlpha(30),
            blurRadius: 2,
            blurStyle: BlurStyle.normal,
            offset: const Offset(0, 1))],
      ),
      child: TextField(
        textInputAction: widget.textInputAction,
        onSubmitted: widget.onSubmitted,
        focusNode: _focusNode,
        style: text_1F2024_14_regular_w400,
        keyboardType: widget.inputType,
        controller: widget.textController,
        enabled: widget.isEnabled,
        readOnly: widget.isReadOnly,
        obscureText: widget.isPassword,
        inputFormatters: widget.inputFormatters ?? [],
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        decoration: (widget.decoration != null)
            ? widget.decoration
            : InputDecoration(
                errorText: widget.hasError ? "" : null,
                errorStyle: const TextStyle(fontSize: 0),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: Dimens.spacing_12,
                  horizontal: Dimens.spacing_24,
                ),
                filled: true,
                hintText: widget.hintText,
                hintStyle: text_7C8BA0_14_regular_w400,
                fillColor: AppColors.white_rbga_ffffff,
                hoverColor: AppColors.white_rbga_ffffff,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isFocused
                          ? const AppColors().primaryColor
                          : Colors.transparent),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isFocused
                          ? const AppColors().primaryColor
                          : Colors.transparent),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.red_rbga_ED3241),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const AppColors().primaryColor),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
      ),
    );
  }
}
