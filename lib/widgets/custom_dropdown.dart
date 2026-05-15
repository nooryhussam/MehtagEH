import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/widgets/app_style.dart';

class CustomDropdownField extends StatelessWidget {
  final String? value;
  final String hintText;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    super.key,
    required this.value,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonFormField<String>(
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
        initialValue: value,
        decoration: AppStyle.inputDecoration(
          hint: Text(
            hintText,
            style: GoogleFonts.tajawal(color: Color(0xFF747476), fontSize: 14),
          ),
        ),
        validator: validator,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: GoogleFonts.tajawal()),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
