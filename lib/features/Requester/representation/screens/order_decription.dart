import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahtage_eh/core/model/validators.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/requester_cubit.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/requester_state.dart';
import 'package:mahtage_eh/widgets/button_app.dart';
import 'package:mahtage_eh/widgets/custom_textfield.dart';
import 'package:mahtage_eh/widgets/dialog_message.dart';

class OrderDescription extends StatefulWidget {
  final String requestType;
  final int age;
  final String workStatus;
  final bool isFamily;
  final int familyMembers;
  final String city;
  final String village;
  final bool hasDisability;

  const OrderDescription({
    super.key,
    required this.requestType,
    required this.age,
    required this.workStatus,
    required this.isFamily,
    required this.familyMembers,
    required this.city,
    required this.village,
    required this.hasDisability,
  });

  @override
  State<OrderDescription> createState() => _OrderDescriptionState();
}

class _OrderDescriptionState extends State<OrderDescription> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  String? _imagePath;
  OrderModel? _lastCreatedOrder;
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (picked == null) return;
    setState(() => _imagePath = picked.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 22.r,
            ),
          ),
        ],
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 50.h, width: 72.w),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocConsumer<RequesterCubit, RequesterState>(
            listener: (context, state) {
              if (state is CreateRequestSuccess) {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    child: DialogMessage(
                      text: 'تم تأكيد الطلب بنجاح',
                      text2: 'تتبع الطلب',
                      imagepath: 'assets/images/accepted.png',
                      color: const Color(0xFFF38C2B),
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.orderTracking,
                        arguments: state.request,
                      ),
                    ),
                  ),
                );
              } else if (state is RequesterError) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: const TextStyle(
                        color: Color(0xFFFF3333),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: const Color.fromARGB(255, 235, 229, 229),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      Text(
                        "تسجيل طلب",
                        style: GoogleFonts.tajawal(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "يرجى تسجيل بيانات الطلب",
                        style: GoogleFonts.tajawal(
                          color: const Color(0xFF747476),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      CustomTextField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'برجاء إدخال اسم الطلب';
                          }
                          return null;
                        },
                        hint: 'اسم الطلب',
                        height: 80.h,
                        width: double.infinity,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: _descriptionController,
                        validator: (value) => Validators.validateRequired(
                          value,
                          'برجاء إدخال الوصف',
                        ),
                        hint:
                            'اكتب تفاصيل الطلب بشكل بسيط يساعدنا نفهم احتياجك، مثل نوع الطلب، الأعمار أو المقاسات إن وجدت، وهل المستفيد ولد أم بنت.',
                        height: 170.h,
                        maxLines: 5,
                        width: double.infinity,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: _quantityController,
                        validator: (val) =>
                            Validators.numeric(val, 'برجاء إدخال الكمية'),
                        hint: 'الكمية المطلوبة',
                        height: 80.h,
                        width: double.infinity,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 24.h),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: Text(
                      //     "ارفق صورة للروشتة الطبية (فى حالة العلاج)",
                      //     style: GoogleFonts.tajawal(
                      //       color: const Color(0xff666666),
                      //       fontSize: 14.sp,
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 12.h),
                      if (widget.requestType == 'علاج' ||
                          widget.requestType == 'دواء') ...[
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "ارفق صورة للروشتة الطبية (فى حالة العلاج)",
                            style: GoogleFonts.tajawal(
                              color: const Color(0xff666666),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton.icon(
                            onPressed: _pickImage,
                            label: Text(
                              _imagePath != null
                                  ? "تم اختيار صورة"
                                  : "صورة الروشتة",
                              style: GoogleFonts.tajawal(
                                color: const Color(0xff999999),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            icon: Icon(
                              Icons.file_upload_outlined,
                              color: const Color(0xFF666666),
                              size: 20.r,
                            ),
                            iconAlignment: IconAlignment.end,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              shadowColor: Colors.transparent,
                              backgroundColor: const Color(0xffFEF2E7),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 0.5,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              minimumSize: Size(140.w, 40.h),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                      ],

                      SizedBox(height: 40.h),
                      state is RequesterLoading
                          ? const CircularProgressIndicator(
                              color: Color(0xFFF38C2B),
                            )
                          : AppButton(
                              text: 'تأكيد',
                              textSize: 16,
                              borderRadius: 10,
                              size: Size(279.w, 48.h),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  final cubit = context.read<RequesterCubit>();

                                  debugPrint('==== SUBMIT ARGS ====');

                                  debugPrint(
                                    'User ID: ${cubit.currentUser?.id}',
                                  );

                                  final order = OrderModel(
                                    needyId: cubit.currentUser?.id,
                                    requestType: widget.requestType,
                                    age: widget.age,
                                    workStatus: widget.workStatus,
                                    isFamily: widget.isFamily,
                                    familyMembers: widget.familyMembers,
                                    city: widget.city,
                                    village: widget.village,
                                    hasDisability: widget.hasDisability,
                                    title: _nameController.text.trim(),
                                    description: _descriptionController.text
                                        .trim(),
                                    prescriptionImage: _imagePath,
                                  );
                                  setState(() => _lastCreatedOrder = order);
                                  cubit.createRequest(order);
                                }
                              },
                            ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
