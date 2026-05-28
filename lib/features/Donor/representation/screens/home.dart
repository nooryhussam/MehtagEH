import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_cubit.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_state.dart';
import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';

import 'package:mahtage_eh/widgets/cards_donor.dart';
import 'package:mahtage_eh/widgets/helpcard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<DonorCubit>().getApprovedRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: Image.asset('assets/icons/notification.png'),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 8.w),
        actions: [
          BlocBuilder<DonorCubit, DonorState>(
            builder: (context, authState) {
              final cubit = context.read<DonorCubit>();
              final name = (cubit.currentDonor?.name.isNotEmpty ?? false)
                  ? cubit.currentDonor!.name
                  : "مستخدم";
              return Row(
                children: [
                  Text(
                    'أهلا بك  \n $name',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // ClipOval(
                  //   child: Image.asset(
                  //     'assets/images/profile.jpg',
                  //     width: 40.r,
                  //     height: 40.r,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  SizedBox(width: 8.w),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<DonorCubit, DonorState>(
        builder: (context, state) {
          if (state is DonorLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2BA12F)),
            );
          }

          if (state is DonorError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: GoogleFonts.tajawal(fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<DonorCubit>().getApprovedRequests(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2BA12F),
                    ),
                    child: Text(
                      'إعادة المحاولة',
                      style: GoogleFonts.tajawal(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          final List<OrderModel> orders = state is GetApprovedRequestsSuccess
              ? state.requests
              : [];

          final urgent = orders.take(2).toList();
          final all = orders.skip(2).toList();

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  HelpCard(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.donorOrder),
                    text1: 'تقدر تقدم مساعدة ؟',
                    text2: 'اعرض تبرعك الآن',
                    textButton: 'تبرع',
                  ),
                  SizedBox(height: 24.h),

                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: const Color(0xFFEA580C),
                        size: 20.r,
                      ),
                      SizedBox(width: 7.w),
                      Text(
                        'الإحتياجات الأكثر ضرورة',
                        style: GoogleFonts.tajawal(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRoutes.serviceScreenDonor,
                        ),
                        child: Text(
                          'رؤية المزيد',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFFC1630B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  if (urgent.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Text(
                        'لا توجد احتياجات حالياً',
                        style: GoogleFonts.tajawal(color: Colors.grey),
                      ),
                    )
                  else
                    ...urgent.map(
                      (order) => Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CardsDonor(
                          title: order.title,
                          subtitle: order.description,
                          imagepath: order.resolvedImage,
                          textlocation: order.locationLabel,
                          score: order.priorityLabel,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.donorOrder,
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 8.h),

                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'جميع الإحتياجات',
                        style: GoogleFonts.tajawal(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.donorOrder),
                        child: Text(
                          'رؤية المزيد',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFFC1630B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  if (all.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Text(
                        'لا توجد احتياجات إضافية',
                        style: GoogleFonts.tajawal(color: Colors.grey),
                      ),
                    )
                  else
                    ...all.map(
                      (order) => Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CardsDonor(
                          title: order.title,
                          subtitle: order.description,
                          imagepath: order.resolvedImage,
                          textlocation: order.locationLabel,
                          score: order.priorityLabel,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.donorOrder,
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 16.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
