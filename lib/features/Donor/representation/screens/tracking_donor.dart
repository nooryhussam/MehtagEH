import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/Donor/data/model/recommendation_model.dart';
import 'package:mahtage_eh/widgets/detail_row.dart';

class OrderTrackingDonorScreen extends StatelessWidget {
  final RecommendedRequest request;
  const OrderTrackingDonorScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'تتبع التبرع',
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.homeDonor);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildOrderDetailsCard(request),
            const SizedBox(height: 24),
            _buildOrderStatusCard(),
            const SizedBox(height: 24),
            _buildBottomInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailsCard(RecommendedRequest req) {
    final bool isUrgent = req.priority == 'عاجل';
    final Color badgeBg = isUrgent
        ? const Color(0xFFFFEBEB)
        : const Color(0xFFFFF3CD);
    final Color badgeText = isUrgent
        ? const Color(0xFFE53935)
        : const Color(0xFF856404);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  req.priority,
                  style: GoogleFonts.tajawal(
                    color: badgeText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    req.requestType,
                    style: GoogleFonts.tajawal(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2BA12F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      _getImage(req.requestType),
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          DetailRow(
            icon: LucideIcons.box,
            label: 'الوصف',
            value: req.description,
          ),
          const SizedBox(height: 16),
          if (req.isFamily) ...[
            DetailRow(
              icon: Icons.person,
              label: 'عدد المستفيدين',
              value: '${req.familyMembers} أشخاص',
            ),
            const SizedBox(height: 16),
          ],
          DetailRow(
            icon: Icons.location_on_outlined,
            label: 'مكان التوصيل',
            value: req.fullLocation,
          ),
          if (req.hasDisability) ...[
            const SizedBox(height: 16),
            DetailRow(
              icon: Icons.accessible_outlined,
              label: 'ملاحظة',
              value: 'صاحب الطلب لديه إعاقة',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'حالة الطلب',
            style: GoogleFonts.tajawal(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),
          _buildTimelineItem(
            status: 'تم عرض المساعدة',
            substatus: '✓ مكتمل',
            isCompleted: true,
            isCurrent: false,
            isFirst: true,
            icon: Icons.check,
          ),
          _buildTimelineItem(
            status: 'تجهيز التبرع',
            substatus: '',
            isCompleted: false,
            isCurrent: true,
            icon: LucideIcons.box,
          ),
          _buildTimelineItem(
            status: 'في الطريق',
            substatus: '',
            isCompleted: false,
            isCurrent: false,
            icon: Icons.local_shipping,
          ),
          _buildTimelineItem(
            status: 'تم التسليم',
            substatus: '',
            isCompleted: false,
            isCurrent: false,
            isLast: true,
            icon: Icons.check,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String status,
    required String substatus,
    required IconData icon,
    bool isCompleted = false,
    bool isCurrent = false,
    bool isFirst = false,
    bool isLast = false,
  }) {
    Color circleColor;
    Color textColor;
    Color substatusColor;
    Color iconColor;

    if (isCompleted) {
      circleColor = const Color(0xFF2BA12F);
      textColor = Colors.black;
      substatusColor = const Color(0xFF2BA12F);
      iconColor = Colors.white;
    } else if (isCurrent) {
      circleColor = const Color(0xFFF38C2B);
      textColor = Colors.black;
      substatusColor = const Color(0xFFF38C2B);
      iconColor = Colors.white;
    } else {
      circleColor = const Color(0xFFE0E0E0);
      textColor = const Color(0xFF999999);
      substatusColor = const Color(0xFF999999);
      iconColor = const Color(0xFFBDBDBD);
    }

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: isCurrent
                ? ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF38C2B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'تأكيد',
                      style: GoogleFonts.tajawal(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const SizedBox(width: 70),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  status,
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                  textAlign: TextAlign.right,
                ),
                if (substatus.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    substatus,
                    style: GoogleFonts.tajawal(
                      fontSize: 12,
                      color: substatusColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
                if (!isLast) const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 40,
                  color: isCompleted || isCurrent
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFF3F4F6),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomInfoCard() {
    return Center(
      child: Image.asset(
        'assets/images/Container.png',
        width: 500,
        height: 105,
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
