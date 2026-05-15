import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_cubit.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_state.dart';
import 'package:mahtage_eh/widgets/profile_btn.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF4CAF50);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'الصفحة الشخصية',
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.0.w),
          child: Icon(Icons.edit, color: Colors.black, size: 24.w),
        ),
        actions: [
          IconButton(
            icon: Transform.scale(
              scaleX: -1,
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 25.w,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0.w),
          child: Column(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              SizedBox(height: 29.h),

              Column(
                children: [
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0XFF747476),
                        strokeAlign: BorderSide.strokeAlignInside,
                        width: 0.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.r,
                          offset: Offset(4.w, 4.h),
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.r,
                          offset: Offset(-4.w, 4.h),
                        ),
                      ],
                    ),
                    child: Icon(Icons.person, size: 90.w, color: primaryGreen),
                  ),
                  SizedBox(height: 24.h),
                  BlocBuilder<DonorCubit, DonorState>(
                    builder: (context, authState) {
                      final cubit = context.read<DonorCubit>();
                      final name =
                          (cubit.currentDonor?.name.isNotEmpty ?? false)
                          ? cubit.currentDonor!.name
                          : "مستخدم";

                      return Text(
                        name,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              ProfileButton(title: 'اسم المستخدم', icon: Icons.person),
              SizedBox(height: 32.h),

              ProfileButton(title: 'طلبات سابقة', icon: LucideIcons.box),
              SizedBox(height: 32.h),

              ProfileButton(title: 'الإعدادات', icon: Icons.settings),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
