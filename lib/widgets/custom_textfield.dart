import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.height,
    this.width,
    this.maxLines = 1,
    this.obscureText = false,
  });

  final double? height;
  final double? width;
  final Widget? suffixIcon;
  final String hint;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      obscureText: obscureText,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      cursorColor: Colors.black,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: maxLines == 1 ? 1 : maxLines,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: GoogleFonts.tajawal(color: const Color(0xff999999)),
        filled: true,
        fillColor: const Color(0xFFEBEBEB),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: maxLines > 1 ? 20 : 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );

    if (height != null) {
      return SizedBox(
        width: width,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height!, maxHeight: height!),
          child: field,
        ),
      );
    }

    return SizedBox(width: width, child: field);
  }
}
