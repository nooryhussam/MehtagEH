import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_cubit.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_state.dart';
import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
import 'package:mahtage_eh/widgets/cards_donor.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "مساعدات",
          style: GoogleFonts.tajawal(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward, color: Colors.black, size: 22.r),
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

          if (state is GetApprovedRequestsSuccess) {
            final List<OrderModel> orders = state.requests;

            if (orders.isEmpty) {
              return Center(
                child: Text(
                  'لا توجد مساعدات حالياً',
                  style: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final OrderModel order = orders[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CardsDonor(
                    title: order.title,
                    subtitle: order.description,
                    imagepath: order.resolvedImage,
                    textlocation: order.locationLabel,
                    score: order.priorityLabel,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.donorOrder),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
