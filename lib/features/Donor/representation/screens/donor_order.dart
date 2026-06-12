import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/core/model/validators.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/Donor/data/model/donation_model.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_cubit.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_state.dart';
import 'package:mahtage_eh/widgets/button_app.dart';
import 'package:mahtage_eh/widgets/custom_dropdown.dart';
import 'package:mahtage_eh/widgets/custom_textfield.dart';

class DonorOrder extends StatefulWidget {
  const DonorOrder({super.key});

  @override
  State<DonorOrder> createState() => _DonorOrderState();
}

class _DonorOrderState extends State<DonorOrder> {
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _villageController = TextEditingController();
  final _quantityController = TextEditingController();

  final List<String> donorCategory = ['طعام', 'لبس', 'علاج'];
  final List<String> donortime = ['غدا', 'اليوم', 'خلال الاسبوع'];
  String? selectedCategory;
  String? selectedTime;

  @override
  void dispose() {
    _cityController.dispose();
    _villageController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocConsumer<DonorCubit, DonorState>(
            listener: (context, state) {
              if (state is CreateDonationSuccess) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.matchingScreen,
                  arguments: state.recommendations,
                );
              } else if (state is DonorError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                    ),
                    backgroundColor: const Color.fromARGB(255, 251, 236, 235),
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is DonorLoading;

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        textDirection: TextDirection.rtl,
                        children: [
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 22.r,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    height: 50.h,
                                    width: 72.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 48.w),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "تسجيل تبرع",
                            style: GoogleFonts.tajawal(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "يرجى تسجيل بيانات التبرع",
                            style: GoogleFonts.tajawal(
                              color: const Color(0xFF747476),
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 50.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "نوع التبرع",
                              style: GoogleFonts.tajawal(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomDropdownField(
                            value: selectedCategory,
                            hintText: '',
                            items: donorCategory,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء اختيار نوع التبرع';
                              }
                              return null;
                            },
                            onChanged: (val) =>
                                setState(() => selectedCategory = val),
                          ),
                          SizedBox(height: 16.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "وقت التوفر",
                              style: GoogleFonts.tajawal(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomDropdownField(
                            value: selectedTime,
                            hintText: '',
                            items: donortime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء اختيار وقت التوفر';
                              }
                              return null;
                            },
                            onChanged: (val) =>
                                setState(() => selectedTime = val),
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            controller: _quantityController,
                            validator: (val) =>
                                Validators.numeric(val, 'برجاء ادخال الكمية'),
                            hint: 'الكمية',
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 16.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "الموقع",
                              style: GoogleFonts.tajawal(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: _cityController,
                                  validator: (value) =>
                                      Validators.validateRequired(
                                        value,
                                        'برجاء اكمال البيانات',
                                      ),
                                  hint: 'مدينة',
                                  keyboardType: TextInputType.streetAddress,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: CustomTextField(
                                  controller: _villageController,
                                  validator: (value) =>
                                      Validators.validateRequired(
                                        value,
                                        'برجاء اكمال البيانات',
                                      ),
                                  hint: 'قرية',
                                  keyboardType: TextInputType.streetAddress,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 110.h),
                          AppButton(
                            text: 'تأكيد',
                            onTap: isLoading
                                ? () {}
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      final donation = DonationModel(
                                        donationType: selectedCategory!,
                                        availability: selectedTime!,
                                        location: _cityController.text.trim(),
                                        village: _villageController.text.trim(),
                                        quantity:
                                            int.tryParse(
                                              _quantityController.text.trim(),
                                            ) ??
                                            0,
                                      );
                                      context.read<DonorCubit>().createDonation(
                                        donation,
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

                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF2BA12F),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
