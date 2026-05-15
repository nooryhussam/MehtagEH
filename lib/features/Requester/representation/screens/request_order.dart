import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/requester_details.dart';
import 'package:mahtage_eh/widgets/button_app.dart';
import 'package:mahtage_eh/widgets/custom_dropdown.dart';

class RegisterOrderScreen extends StatefulWidget {
  const RegisterOrderScreen({super.key});

  @override
  State<RegisterOrderScreen> createState() => _RegisterOrderScreenState();
}

class _RegisterOrderScreenState extends State<RegisterOrderScreen> {
  String? selectedOrderType;
  final _formKey = GlobalKey<FormState>();
  final List<String> orderTypes = ['طعام', 'لبس', 'علاج'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Transform.scale(
            scaleX: -1,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 22.r,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 93.w,
                height: 65.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 7.h),
              Text(
                'تسجيل طلب',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1C3D),
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                'يرجى تسجيل بيانات الطلب',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: 40.h),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'نوع الطلب',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 14.h),

              Form(
                key: _formKey,
                child: CustomDropdownField(
                  value: selectedOrderType,
                  hintText: '',
                  items: orderTypes,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'برجاء اختيار نوع الطلب';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() => selectedOrderType = val),
                ),
              ),

              SizedBox(height: 235.h),

              AppButton(
                text: 'استمرار',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterDetailsScreen(
                          requestType: selectedOrderType!,
                        ),
                      ),
                    );
                  }
                },
                size: Size(279.w, 48.h),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
