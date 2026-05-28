import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:mahtage_eh/core/model/validators.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_cubit.dart';
import 'package:mahtage_eh/features/Donor/data/model/donor_model.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/requester_cubit.dart';
import 'package:mahtage_eh/features/auth/auth_cubit.dart';
import 'package:mahtage_eh/features/auth/auth_state.dart';
import 'package:mahtage_eh/widgets/button_app.dart';
import 'package:mahtage_eh/widgets/custom_icons.dart';
import 'package:mahtage_eh/widgets/custom_text.dart';
import 'package:mahtage_eh/widgets/custom_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _identifierController.dispose();
    _passcontroller.dispose();
    super.dispose();
  }

  void _onLogin(BuildContext context) {
    if (!_formkey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
      identifier: _identifierController.text.trim(),
      password: _passcontroller.text,
    );
  }

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) async {
              if (state is AuthSuccess) {
                if (state.role == UserRole.requester) {
                  final requesterCubit = context.read<RequesterCubit>();
                  await requesterCubit.loadUserFromToken(state.token);

                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.homeScreenRequester,
                    (route) => false,
                  );
                } else if (state.role == UserRole.donor) {
                  context.read<DonorCubit>().currentDonor = DonorModel(
                    name: state.userName ?? '',
                    email: '',
                    password: '',
                    phone: '',
                    donorType: '',
                    token: state.token,
                  );

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.homeScreenDonor,
                    (route) => false,
                  );
                }
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: const TextStyle(
                        color: Color(0xFFFF3333),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 8.h),
                        Image.asset(
                          'assets/images/logo.png',
                          height: 65.h,
                          width: 93.w,
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'تسجيل دخول',
                          style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "مرحباً بك مرة اخرى ! يرجى تسجيل الدخول",
                          style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: const Color(0xFF747476),
                          ),
                        ),
                        SizedBox(height: 72.h),
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              CustomTextField(
                                width: double.infinity,
                                suffixIcon: Icon(
                                  IconaMoon.profile,
                                  size: 24.r,
                                  color: const Color(0xFF666666),
                                ),
                                hint: 'رقم الهاتف',
                                controller: _identifierController,
                                keyboardType: TextInputType.number,
                                validator: Validators.phone,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextField(
                                width: double.infinity,
                                suffixIcon: Image.asset(
                                  'assets/icons/bx_lock.png',
                                  width: 24.r,
                                  height: 24.r,
                                  color: const Color(0xFF666666),
                                ),
                                obscureText: _isObscure,

                                prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: const Color(0xFF666666),
                                  ),
                                ),
                                hint: "كلمة السر",
                                controller: _passcontroller,
                                keyboardType: TextInputType.text,
                                validator: Validators.password,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text.rich(
                            TextSpan(
                              text: "نسيت كلمة السر؟",
                              style: GoogleFonts.tajawal(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ),
                        ),
                        SizedBox(height: 94.h),
                        AppButton(
                          text: 'تسجيل',
                          onTap: () => _onLogin(context),
                          size: Size(279.w, 48.h),
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: Color(0xff747476)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                'أو سجل عن طريق',
                                style: GoogleFonts.tajawal(
                                  color: const Color(0xFF747476),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: Color(0xff747476)),
                            ),
                          ],
                        ),
                        SizedBox(height: 27.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIcons(imagepath: 'assets/icons/google2.png'),
                            SizedBox(width: 21.w),
                            CustomIcons(
                              imagepath: 'assets/icons/facebook3.png',
                            ),
                            SizedBox(width: 21.w),
                            CustomIcons(imagepath: 'assets/icons/apple2.png'),
                          ],
                        ),
                        SizedBox(height: 45.h),
                        CustomText(
                          text1: 'ليس لديك حساب؟ ',
                          text2: 'إنشئ حساب',
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.chooseUser,
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                  // Loading Overlay
                  if (state is AuthLoading)
                    // Container(
                    //   color: Colors.black.withOpacity(0.3),
                    const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF1B5E20),
                        // ),
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
