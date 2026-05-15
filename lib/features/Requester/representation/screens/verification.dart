import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  File? _imageTaken;

  void _pickImage() async {
    final imagepicker = ImagePicker();
    final XFile? pickedImage = await imagepicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _imageTaken = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(50),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/person.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'ابقِ وجهك داخل الإطار',
              style: GoogleFonts.tajawal(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 60),
            // Image.asset('assets/images/screen.png', width: 401, height: 401),
            SizedBox(
              width: 401,
              height: 401,
              child: _imageTaken == null
                  ? Image.asset('assets/images/screen.png', fit: BoxFit.cover)
                  : Image.file(_imageTaken!, fit: BoxFit.cover),
            ),

            const SizedBox(height: 20),
            Text(
              " تأكد من ان وجهك بالكامل داخل الإطار \n لإجراء مسح دقيق ",
              style: GoogleFonts.tajawal(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: _pickImage,
              child: Image.asset(
                'assets/images/press.png',
                width: 67.51,
                height: 67.51,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
