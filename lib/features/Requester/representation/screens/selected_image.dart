import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedImage extends StatefulWidget {
  final Function(String?) onImageSelected;
  final String? errorText;

  const SelectedImage({
    super.key,
    required this.onImageSelected,
    this.errorText,
  });

  @override
  State<SelectedImage> createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {
  String? _imageName;

  Future<void> _pickImage() async {
    try {
      // ✅ image_picker بدون أي compression أو maxWidth
      final XFile? picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        requestFullMetadata:
            false, // ✅ بيجيب الصورة الأصلية بدون metadata processing
      );

      if (picked == null) return;

      // ✅ نقرأ الصورة كـ bytes من XFile مباشرة — ده بيتجنب أي cache
      final bytes = await picked.readAsBytes();

      // ✅ نحفظها في temp file بنفس البيانات الأصلية
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/${picked.name}');
      await tempFile.writeAsBytes(bytes);

      debugPrint(
        'Original size: ${(bytes.length / 1024).toStringAsFixed(1)} KB',
      );

      setState(() {
        _imageName = picked.name;
      });

      widget.onImageSelected(tempFile.path);
    } catch (e) {
      debugPrint('Image picker error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_imageName != null)
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 18),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    _imageName!,
                    style: TextStyle(fontSize: 14.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

        ElevatedButton.icon(
          onPressed: _pickImage,
          label: Text(
            "صورة البطاقة",
            style: GoogleFonts.tajawal(
              color: const Color(0xff999999),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          icon: const Icon(
            Icons.file_upload_outlined,
            color: Color(0xFF666666),
          ),
          iconAlignment: IconAlignment.end,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
              side: BorderSide(
                color: widget.errorText != null ? Colors.red : Colors.black,
                width: 0.5,
              ),
            ),
            backgroundColor: const Color(0xffFEF2E7),
            fixedSize: Size(140.w, 40.h),
            elevation: 0,
          ),
        ),

        if (widget.errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 8.h, right: 12.w),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
              textDirection: TextDirection.rtl,
            ),
          ),
      ],
    );
  }
}
