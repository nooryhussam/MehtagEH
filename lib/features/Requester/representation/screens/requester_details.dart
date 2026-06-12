import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/core/model/validators.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/order_decription.dart';
import 'package:mahtage_eh/widgets/button_app.dart';
import 'package:mahtage_eh/widgets/custom_dropdown.dart';
import 'package:mahtage_eh/widgets/custom_textfield.dart';

class RegisterDetailsScreen extends StatefulWidget {
  final String requestType;

  const RegisterDetailsScreen({super.key, required this.requestType});

  @override
  State<RegisterDetailsScreen> createState() => _RegisterDetailsScreenState();
}

class _RegisterDetailsScreenState extends State<RegisterDetailsScreen> {
  String? selectedJob;
  String? selectedTypeFamily;
  int? hasChildren;
  int? hasDisability;

  // يتحول true بس لما المستخدم يضغط استمرار
  bool _validateRadios = false;

  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _villageController = TextEditingController();
  final _ageController = TextEditingController();
  final _familyMembersController = TextEditingController();

  final List<String> job = ['موظف', 'لا يعمل'];
  final List<String> family = ['فردي', 'أسرة'];
  final Color primaryGreen = const Color(0xFF32A832);

  @override
  void dispose() {
    _cityController.dispose();
    _villageController.dispose();
    _ageController.dispose();
    _familyMembersController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    setState(() => _validateRadios = true);

    final formValid = _formKey.currentState!.validate();
    final radiosValid = hasChildren != null && hasDisability != null;

    if (!formValid || !radiosValid) return;

    final isFamily = selectedTypeFamily == 'أسرة';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderDescription(
          requestType: widget.requestType,
          age: int.tryParse(_ageController.text) ?? 0,
          workStatus: selectedJob ?? '',
          isFamily: isFamily,
          familyMembers: isFamily
              ? (int.tryParse(_familyMembersController.text) ?? 0)
              : 0,
          city: _cityController.text.trim(),
          village: _villageController.text.trim(),
          hasDisability: hasDisability == 1,
        ),
      ),
    );
  }

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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              textDirection: TextDirection.rtl,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 93.w,
                    height: 65.h,
                  ),
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
                SizedBox(height: 8.h),
                Text(
                  'يرجى تسجيل بيانات مقدم الطلب',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF666666),
                  ),
                ),
                SizedBox(height: 32.h),

                CustomTextField(
                  hint: 'السن',
                  width: double.infinity,
                  validator: (val) =>
                      Validators.numeric(val, 'برجاء ادخال السن'),
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),

                CustomDropdownField(
                  value: selectedJob,
                  hintText: 'الحالة الوظيفية',
                  items: job,
                  validator: (value) => Validators.validateSelection(
                    value,
                    'برجاء اختيار الحالة الوظيفية',
                  ),
                  onChanged: (val) => setState(() => selectedJob = val),
                ),
                SizedBox(height: 16.h),

                CustomDropdownField(
                  value: selectedTypeFamily,
                  hintText: 'فردى / أسرة',
                  items: family,
                  validator: (value) => Validators.validateSelection(
                    value,
                    'برجاء اختيار العائلية',
                  ),
                  onChanged: (val) => setState(() => selectedTypeFamily = val),
                ),
                SizedBox(height: 16.h),

                if (selectedTypeFamily == 'أسرة') ...[
                  CustomTextField(
                    hint: 'عدد أفراد الأسرة',
                    width: double.infinity,
                    controller: _familyMembersController,
                    validator: (val) =>
                        Validators.numeric(val, 'برجاء إدخال عدد أفراد الأسرة'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.h),
                ],

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'الموقع',
                    style: GoogleFonts.tajawal(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _cityController,
                        validator: (value) => Validators.validateRequired(
                          value,
                          'برجاء اكمال البيانات',
                        ),
                        hint: 'مدينة',
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomTextField(
                        controller: _villageController,
                        validator: (value) => Validators.validateRequired(
                          value,
                          'برجاء اكمال البيانات',
                        ),
                        hint: 'قرية',
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                _buildRadioRow(
                  'هل يوجد اطفال؟',
                  hasChildren,
                  (val) => setState(() => hasChildren = val),
                  showError: _validateRadios && hasChildren == null,
                ),
                _buildRadioRow(
                  'هل يوجد إعاقة؟',
                  hasDisability,
                  (val) => setState(() => hasDisability = val),
                  showError: _validateRadios && hasDisability == null,
                ),
                SizedBox(height: 40.h),

                AppButton(
                  text: 'استمرار',
                  onTap: _onSubmit,
                  size: Size(279.w, 48.h),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioRow(
    String title,
    int? groupValue,
    Function(int?) onChanged, {
    bool showError = false,
    String errorText = 'يرجى اختيار أحد الخيارات',
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 14.sp)),
              Row(
                children: [
                  Text('نعم', style: TextStyle(fontSize: 13.sp)),
                  Radio<int>(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    activeColor: primaryGreen,
                  ),
                  SizedBox(width: 8.w),
                  Text('لا', style: TextStyle(fontSize: 13.sp)),
                  Radio<int>(
                    value: 0,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    activeColor: primaryGreen,
                  ),
                ],
              ),
            ],
          ),
          if (showError)
            Padding(
              padding: EdgeInsets.only(top: 4.h, right: 4.w),
              child: Text(
                errorText,
                style: TextStyle(color: Colors.red, fontSize: 11.sp),
              ),
            ),
        ],
      ),
    );
  }
}
