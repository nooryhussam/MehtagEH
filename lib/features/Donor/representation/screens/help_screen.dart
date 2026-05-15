import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/Donor/data/model/recommendation_model.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_cubit.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_state.dart';
import 'package:mahtage_eh/widgets/card_tracking.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
          "تبرعات",
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocBuilder<DonorCubit, DonorState>(
        builder: (context, state) {
          final List<RecommendedRequest> confirmed = context
              .read<DonorCubit>()
              .confirmedDonations;

          if (confirmed.isEmpty) {
            return Center(
              child: Text(
                'لا توجد تبرعات مؤكدة حتى الآن',
                style: GoogleFonts.tajawal(fontSize: 16.sp, color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(16.r),
            itemCount: confirmed.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final req = confirmed[index];
              return CardTracking(
                title: req.title,
                subtitle: req.description,
                location: req.fullLocation,
                priority: req.priority,
                imagePath: _getImage(req.requestType),
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.trackOrderScreenDonor,
                  arguments: req,
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _getImage(String type) {
    switch (type) {
      case 'دواء':
      case 'علاج':
        return 'assets/images/firstaid.png';
      case 'ملابس':
      case 'لبس':
        return 'assets/images/cl2.png';
      default:
        return 'assets/images/food.png';
    }
  }
}
