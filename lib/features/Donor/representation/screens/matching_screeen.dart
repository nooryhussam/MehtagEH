import 'package:mahtage_eh/features/Donor/data/model/recommendation_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/reqt_info.dart';
import 'package:mahtage_eh/widgets/cards_donor.dart';

class MatchingScreeen extends StatelessWidget {
  final List<RecommendedRequest> recommendations;
  const MatchingScreeen({super.key, this.recommendations = const []});

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
          "نتائج مطابقة",
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: recommendations.isEmpty
          ? Center(
              child: Text(
                'لا توجد نتائج مطابقة',
                style: GoogleFonts.tajawal(fontSize: 16.sp, color: Colors.grey),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: recommendations.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final req = recommendations[index];
                return CardsDonor(
                  title: req.title,
                  subtitle: req.description,
                  imagepath: _getImage(req.requestType),
                  textlocation: req.fullLocation,
                  score: req.priority,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ReqInfo(request: req)),
                    );
                  },
                );
              },
            ),
    );
  }

  String _getImage(String type) {
    switch (type) {
      case 'علاج':
        return 'assets/images/firstaid.png';
      case 'ملابس':
        return 'assets/images/cl2.png';
      default:
        return 'assets/images/food.png';
    }
  }
}
