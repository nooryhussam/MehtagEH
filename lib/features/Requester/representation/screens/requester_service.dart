import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/requester_cubit.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/requester_state.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/tracking.dart';
import 'package:mahtage_eh/widgets/carde_requester.dart';

class RequesterService extends StatefulWidget {
  const RequesterService({super.key});

  @override
  State<RequesterService> createState() => _RequesterServiceState();
}

class _RequesterServiceState extends State<RequesterService> {
  @override
  void initState() {
    super.initState();
    context.read<RequesterCubit>().getRequests();
  }

  ({String label, Color color, Color bgColor}) _resolveStatus(
    OrderModel order,
  ) {
    final delivered = order.deliveryCompleted;
    final onWay = order.onTheWay;
    final match = order.matchingWithDonor;
    final review = order.underReview;

    if (delivered == 'completed') {
      return (
        label: 'تم التوصيل',
        color: const Color(0xFF6B7280),
        bgColor: const Color(0xFFE6E6E6),
      );
    } else if (onWay == 'in_progress' || onWay == 'completed') {
      return (
        label: 'في الطريق',
        color: const Color(0xFF2BA12F),
        bgColor: const Color(0xFFD7F4D8),
      );
    } else if (match == 'in_progress' || match == 'completed') {
      return (
        label: 'جاري التنفيذ',
        color: const Color(0xFF2BA12F),
        bgColor: const Color(0xFFD7F4D8),
      );
    } else if (review == 'in_progress' || review == 'completed') {
      return (
        label: 'جاري التنفيذ',
        color: const Color(0xFF2BA12F),
        bgColor: const Color(0xFFD7F4D8),
      );
    } else {
      return (
        label: 'تم الإرسال',
        color: const Color(0xFFC1630B),
        bgColor: const Color(0xFFFCE5CF),
      );
    }
  }

  String _resolveImage(String requestType) {
    switch (requestType) {
      case 'علاج':
        return 'assets/images/firstaid1.png';
      case 'لبس':
        return 'assets/images/cl2.png';
      case 'طعام':
        return 'assets/images/food1.png';
      default:
        return 'Nothing';
    }
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
        title: Text(
          "طلبات",
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocBuilder<RequesterCubit, RequesterState>(
        builder: (context, state) {
          // ── Loading ──────────────────────────────────────────────────────
          if (state is RequesterLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2BA12F)),
            );
          }

          // ── Error ────────────────────────────────────────────────────────
          if (state is RequesterError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: GoogleFonts.tajawal(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<RequesterCubit>().getRequests(),
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

          // ── Success ──────────────────────────────────────────────────────
          if (state is GetRequestsSuccess) {
            final List<OrderModel> orders = state.requests;

            if (orders.isEmpty) {
              return Center(
                child: Text(
                  'لا توجد طلبات حتى الآن',
                  style: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final OrderModel order = orders[index];
                final statusData = _resolveStatus(order);

                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CardsRequester(
                    model: order,
                    imagepath: _resolveImage(order.requestType),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderTrackingScreen(order: order),
                        ),
                      );
                    },
                    textbutton: 'تتبع الطلب',
                    color: statusData.color,
                    colorbutton: statusData.bgColor,
                  ),
                );
              },
            );
          }

          // ── Initial / fallback ───────────────────────────────────────────
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
