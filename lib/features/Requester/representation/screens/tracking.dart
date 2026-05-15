// import 'package:flutter/material.dart';
// import 'package:flutter_lucide/flutter_lucide.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
//
// class OrderTrackingScreen extends StatelessWidget {
//   final OrderModel order;
//
//   const OrderTrackingScreen({super.key, required this.order});
//
//   // ── Image per request type ─────────────────────────────────────────────────
//   String get _image {
//     switch (order.requestType) {
//       case 'دواء':
//         return 'assets/images/firstaid.png';
//       case 'ملابس':
//         return 'assets/images/cl2.png';
//       case 'طعام':
//       default:
//         return 'assets/images/food.png';
//     }
//   }
//
//   // ── Icon color per request type ────────────────────────────────────────────
//   // Color get _iconBgColor {
//   //   switch (order.requestType) {
//   //     case 'دواء':
//   //       return const Color(0xFFE53935);
//   //     case 'ملابس':
//   //       return const Color(0xFF1565C0);
//   //     case 'طعام':
//   //     default:
//   //       return const Color(0xFF2BA12F);
//   //   }
//   // }
//
//   // ── Pipeline step helpers ──────────────────────────────────────────────────
//   bool _isCompleted(String? field) => field == 'completed';
//   bool _isInProgress(String? field) => field == 'in_progress';
//
//   // ── Format createdAt date ──────────────────────────────────────────────────
//   String get _formattedDate {
//     if (order.createdAt == null) return '—';
//     try {
//       final dt = DateTime.parse(order.createdAt!).toLocal();
//       const months = [
//         '',
//         'يناير',
//         'فبراير',
//         'مارس',
//         'إبريل',
//         'مايو',
//         'يونيو',
//         'يوليو',
//         'أغسطس',
//         'سبتمبر',
//         'أكتوبر',
//         'نوفمبر',
//         'ديسمبر',
//       ];
//       return '${dt.day} ${months[dt.month]}، ${dt.year}';
//     } catch (_) {
//       return '—';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           'تتبع الطلب',
//           style: GoogleFonts.tajawal(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             _buildOrderDetailsCard(),
//             const SizedBox(height: 24),
//             _buildOrderStatusCard(),
//             const SizedBox(height: 24),
//             _buildBottomInfoCard(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOrderDetailsCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           // Header: request type + image
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // No "عاجل" badge — can be added later if API sends urgency flag
//               const SizedBox.shrink(),
//               Row(
//                 children: [
//                   Text(
//                     order.requestType,
//                     style: GoogleFonts.tajawal(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       // color: _iconBgColor,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Image.asset(_image, width: 28, height: 28),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//
//           _buildDetailRow(
//             icon: LucideIcons.box,
//             label: 'الوصف',
//             value: order.description,
//           ),
//           const SizedBox(height: 16),
//           _buildDetailRow(
//             icon: Icons.calendar_today_outlined,
//             label: 'تاريخ الطلب',
//             value: _formattedDate,
//           ),
//           const SizedBox(height: 16),
//           _buildDetailRow(
//             icon: Icons.people_outline,
//             label: 'عدد أفراد الأسرة',
//             value: order.isFamily ? '${order.familyMembers} أشخاص' : 'فرد واحد',
//           ),
//           const SizedBox(height: 16),
//           _buildDetailRow(
//             icon: Icons.location_on_outlined,
//             label: 'مكان التوصيل',
//             value: order.village.isNotEmpty
//                 ? '${order.village}، ${order.city}'
//                 : order.city,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDetailRow({
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 label,
//                 style: GoogleFonts.tajawal(
//                   fontSize: 12,
//                   color: const Color(0xFF999999),
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 value,
//                 style: GoogleFonts.tajawal(
//                   fontSize: 14,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 textAlign: TextAlign.right,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 12),
//         Icon(icon, size: 20, color: const Color(0xFF666666)),
//       ],
//     );
//   }
//
//   Widget _buildOrderStatusCard() {
//     // Determine each step's state from pipeline fields
//     final submittedDone = _isCompleted(order.requestSubmitted);
//     final reviewDone = _isCompleted(order.underReview);
//     final reviewCurrent = _isInProgress(order.underReview);
//     final matchDone = _isCompleted(order.matchingWithDonor);
//     final matchCurrent = _isInProgress(order.matchingWithDonor);
//     final onWayDone = _isCompleted(order.onTheWay);
//     final onWayCurrent = _isInProgress(order.onTheWay);
//     final deliveredDone = _isCompleted(order.deliveryCompleted);
//
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             'حالة الطلب',
//             style: GoogleFonts.tajawal(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 24),
//
//           _buildTimelineItem(
//             status: 'تم تقديم الطلب',
//             substatus: submittedDone ? '✓ مكتمل' : 'في الانتظار',
//             isCompleted: submittedDone,
//             isCurrent: !submittedDone,
//             isFirst: true,
//           ),
//           _buildTimelineItem(
//             status: 'قيد المراجعة',
//             substatus: reviewDone
//                 ? '✓ مكتمل'
//                 : reviewCurrent
//                 ? 'جاري التنفيذ'
//                 : '',
//             isCompleted: reviewDone,
//             isCurrent: reviewCurrent,
//           ),
//           _buildTimelineItem(
//             status: 'جاري المطابقة مع المتبرع',
//             substatus: matchDone
//                 ? '✓ مكتمل'
//                 : matchCurrent
//                 ? 'جاري التنفيذ'
//                 : '',
//             isCompleted: matchDone,
//             isCurrent: matchCurrent,
//           ),
//           _buildTimelineItem(
//             status: 'في الطريق',
//             substatus: onWayDone
//                 ? '✓ مكتمل'
//                 : onWayCurrent
//                 ? 'جاري التوصيل'
//                 : '',
//             isCompleted: onWayDone,
//             isCurrent: onWayCurrent,
//             isDelivery: true,
//           ),
//           _buildTimelineItem(
//             status: 'تم التسليم',
//             substatus: deliveredDone ? '✓ مكتمل' : '',
//             isCompleted: deliveredDone,
//             isLast: true,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTimelineItem({
//     required String status,
//     required String substatus,
//     bool isCompleted = false,
//     bool isCurrent = false,
//     bool isFirst = false,
//     bool isLast = false,
//     bool isDelivery = false,
//   }) {
//     Color circleColor;
//     Color textColor;
//     Color substatusColor;
//
//     if (isCompleted) {
//       circleColor = const Color(0xFF2BA12F);
//       textColor = Colors.black;
//       substatusColor = const Color(0xFF2BA12F);
//     } else if (isCurrent) {
//       circleColor = const Color(0xFFF38C2B);
//       textColor = Colors.black;
//       substatusColor = const Color(0xFFF38C2B);
//     } else {
//       circleColor = const Color(0xFFE0E0E0);
//       textColor = const Color(0xFF999999);
//       substatusColor = const Color(0xFF999999);
//     }
//
//     return IntrinsicHeight(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   status,
//                   style: GoogleFonts.tajawal(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: textColor,
//                   ),
//                   textAlign: TextAlign.right,
//                 ),
//                 if (substatus.isNotEmpty) ...[
//                   const SizedBox(height: 4),
//                   Text(
//                     substatus,
//                     style: GoogleFonts.tajawal(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: substatusColor,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ],
//                 if (!isLast) const SizedBox(height: 24),
//               ],
//             ),
//           ),
//           const SizedBox(width: 16),
//
//           Column(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: circleColor,
//                   shape: BoxShape.circle,
//                 ),
//                 child: isCompleted
//                     ? const Icon(Icons.check, color: Colors.white, size: 20)
//                     : isCurrent
//                     ? Icon(
//                         isDelivery ? Icons.local_shipping : Icons.favorite,
//                         color: Colors.white,
//                         size: 20,
//                       )
//                     : isDelivery
//                     ? const Icon(
//                         Icons.local_shipping,
//                         color: Color(0xFFBDBDBD),
//                         size: 20,
//                       )
//                     : null,
//               ),
//               if (!isLast)
//                 Container(
//                   width: 2,
//                   height: 40,
//                   color: isCompleted || isCurrent
//                       ? const Color(0xFF4CAF50)
//                       : const Color(0xFFF3F4F6),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomInfoCard() {
//     return Center(
//       child: Image.asset(
//         'assets/images/Container.png',
//         width: 500,
//         height: 105,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_lucide/flutter_lucide.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
// import 'package:mahtage_eh/widgets/detail_row.dart';

// class OrderTrackingScreen extends StatelessWidget {
//   final OrderModel order;
//   const OrderTrackingScreen({super.key, required this.order});

//   String get _image {
//     switch (order.requestType) {
//       case 'دواء':
//         return 'assets/images/firstaid.png';
//       case 'ملابس':
//         return 'assets/images/cl2.png';
//       case 'طعام':
//       default:
//         return 'assets/images/food.png';
//     }
//   }

//   Color get _iconBgColor {
//     switch (order.requestType) {
//       case 'دواء':
//         return const Color(0xFFE53935);
//       case 'ملابس':
//         return const Color(0xFF1565C0);
//       case 'طعام':
//       default:
//         return const Color(0xFF2BA12F);
//     }
//   }

//   bool _isDone(String? v) => v == 'completed';
//   bool _isProgress(String? v) => v == 'in_progress';

//   String get _formattedDate {
//     if (order.createdAt == null) return '—';
//     try {
//       final dt = DateTime.parse(order.createdAt!).toLocal();
//       const months = [
//         '',
//         'يناير',
//         'فبراير',
//         'مارس',
//         'إبريل',
//         'مايو',
//         'يونيو',
//         'يوليو',
//         'أغسطس',
//         'سبتمبر',
//         'أكتوبر',
//         'نوفمبر',
//         'ديسمبر',
//       ];
//       return '${dt.day} ${months[dt.month]}، ${dt.year}';
//     } catch (_) {
//       return '—';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           'تتبع الطلب',
//           style: GoogleFonts.tajawal(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             _buildOrderDetailsCard(),
//             const SizedBox(height: 24),
//             _buildOrderStatusCard(),
//             const SizedBox(height: 24),

//             Image.asset('assets/images/Container.png', width: 289, height: 105),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOrderDetailsCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const SizedBox.shrink(),
//               Row(
//                 children: [
//                   Text(
//                     order.requestType,
//                     style: GoogleFonts.tajawal(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: _iconBgColor,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Image.asset(_image, width: 28, height: 28),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           DetailRow(
//             icon: LucideIcons.box,
//             label: 'الوصف',
//             value: order.description,
//           ),
//           const SizedBox(height: 16),
//           DetailRow(
//             icon: Icons.calendar_today_outlined,
//             label: 'تاريخ الطلب',
//             value: _formattedDate,
//           ),
//           const SizedBox(height: 16),
//           DetailRow(
//             icon: Icons.people_outline,
//             label: 'عدد أفراد الأسرة',
//             value: order.isFamily ? '${order.familyMembers} أشخاص' : 'فرد واحد',
//           ),
//           const SizedBox(height: 16),
//           DetailRow(
//             icon: Icons.location_on_outlined,
//             label: 'مكان التوصيل',
//             value: order.village.isNotEmpty
//                 ? '${order.village}، ${order.city}'
//                 : order.city,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOrderStatusCard() {
//     final submittedDone = _isDone(order.requestSubmitted);
//     final reviewDone = _isDone(order.underReview);
//     final reviewCurrent = _isProgress(order.underReview);
//     final matchDone = _isDone(order.matchingWithDonor);
//     final matchCurrent = _isProgress(order.matchingWithDonor);
//     final onWayDone = _isDone(order.onTheWay);
//     final onWayCurrent = _isProgress(order.onTheWay);
//     final deliveredDone = _isDone(order.deliveryCompleted);

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             'حالة الطلب',
//             style: GoogleFonts.tajawal(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 24),
//           _buildTimelineItem(
//             status: 'تم تقديم الطلب',
//             substatus: submittedDone ? '✓ مكتمل' : 'في الانتظار',
//             isCompleted: submittedDone,
//             isCurrent: !submittedDone,
//             isFirst: true,
//           ),
//           _buildTimelineItem(
//             status: 'قيد المراجعة',
//             substatus: reviewDone
//                 ? '✓ مكتمل'
//                 : reviewCurrent
//                 ? 'جاري التنفيذ'
//                 : '',
//             isCompleted: reviewDone,
//             isCurrent: reviewCurrent,
//           ),
//           _buildTimelineItem(
//             status: 'جاري المطابقة مع المتبرع',
//             substatus: matchDone
//                 ? '✓ مكتمل'
//                 : matchCurrent
//                 ? 'جاري التنفيذ'
//                 : '',
//             isCompleted: matchDone,
//             isCurrent: matchCurrent,
//           ),
//           _buildTimelineItem(
//             status: 'في الطريق',
//             substatus: onWayDone
//                 ? '✓ مكتمل'
//                 : onWayCurrent
//                 ? 'جاري التوصيل'
//                 : '',
//             isCompleted: onWayDone,
//             isCurrent: onWayCurrent,
//             isDelivery: true,
//           ),
//           _buildTimelineItem(
//             status: 'تم التسليم',
//             substatus: deliveredDone ? '✓ مكتمل' : '',
//             isCompleted: deliveredDone,
//             isLast: true,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimelineItem({
//     required String status,
//     required String substatus,
//     bool isCompleted = false,
//     bool isCurrent = false,
//     bool isFirst = false,
//     bool isLast = false,
//     bool isDelivery = false,
//   }) {
//     final Color circleColor = isCompleted
//         ? const Color(0xFF2BA12F)
//         : isCurrent
//         ? const Color(0xFFF38C2B)
//         : const Color(0xFFE0E0E0);
//     final Color textColor = (isCompleted || isCurrent)
//         ? Colors.black
//         : const Color(0xFF999999);
//     final Color subColor = isCompleted
//         ? const Color(0xFF2BA12F)
//         : isCurrent
//         ? const Color(0xFFF38C2B)
//         : const Color(0xFF999999);

//     return IntrinsicHeight(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   status,
//                   style: GoogleFonts.tajawal(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: textColor,
//                   ),
//                   textAlign: TextAlign.right,
//                 ),
//                 if (substatus.isNotEmpty) ...[
//                   const SizedBox(height: 4),
//                   Text(
//                     substatus,
//                     style: GoogleFonts.tajawal(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: subColor,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ],
//                 if (!isLast) const SizedBox(height: 24),
//               ],
//             ),
//           ),
//           const SizedBox(width: 16),
//           Column(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: circleColor,
//                   shape: BoxShape.circle,
//                 ),
//                 child: isCompleted
//                     ? const Icon(Icons.check, color: Colors.white, size: 20)
//                     : isCurrent
//                     ? Icon(
//                         isDelivery ? Icons.local_shipping : Icons.favorite,
//                         color: Colors.white,
//                         size: 20,
//                       )
//                     : isDelivery
//                     ? const Icon(
//                         Icons.local_shipping,
//                         color: Color(0xFFBDBDBD),
//                         size: 20,
//                       )
//                     : null,
//               ),
//               if (!isLast)
//                 Container(
//                   width: 2,
//                   height: 40,
//                   color: isCompleted || isCurrent
//                       ? const Color(0xFF4CAF50)
//                       : const Color(0xFFF3F4F6),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
import 'package:mahtage_eh/widgets/detail_row.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderModel order;
  const OrderTrackingScreen({super.key, required this.order});

  String get _image {
    switch (order.requestType) {
      case 'علاج':
        return 'assets/images/firstaid.png';
      case 'ملابس':
        return 'assets/images/cl2.png';
      case 'طعام':
        return 'assets/images/food.png';
      default:
        return 'Nothing';
    }
  }

  bool _isDone(String? v) => v == 'completed';
  bool _isProgress(String? v) => v == 'in_progress';

  String get _formattedDate {
    if (order.createdAt == null) return '—';
    try {
      final dt = DateTime.parse(order.createdAt!).toLocal();
      const months = [
        '',
        'يناير',
        'فبراير',
        'مارس',
        'إبريل',
        'مايو',
        'يونيو',
        'يوليو',
        'أغسطس',
        'سبتمبر',
        'أكتوبر',
        'نوفمبر',
        'ديسمبر',
      ];

      return '\u200F${dt.day} ${months[dt.month]}، ${dt.year}'; // return '${dt.day} ${months[dt.month]}، ${dt.year}';
    } catch (_) {
      return '—';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'تتبع الطلب',
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward, color: Colors.black, size: 22),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildOrderDetailsCard(),
            const SizedBox(height: 24),
            _buildOrderStatusCard(),
            const SizedBox(height: 24),
            Image.asset('assets/images/Container.png', width: 289, height: 105),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailsCard() {
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
              const SizedBox.shrink(),
              Row(
                children: [
                  Text(
                    order.requestType,
                    style: GoogleFonts.tajawal(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 63.985939025878906,
                    width: 63.985939025878906,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF2BA12F),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Image.asset(_image, width: 36, height: 36),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          DetailRow(
            icon: LucideIcons.box,
            label: 'الوصف',
            value: order.description,
          ),
          const SizedBox(height: 16),
          DetailRow(
            icon: Icons.calendar_today_outlined,
            label: 'تاريخ الطلب',
            value: _formattedDate,
          ),
          const SizedBox(height: 16),
          DetailRow(
            icon: Icons.people_outline,
            label: 'عدد أفراد الأسرة',
            value: order.isFamily ? '${order.familyMembers} أشخاص' : 'فرد واحد',
          ),
          const SizedBox(height: 16),
          DetailRow(
            icon: Icons.location_on_outlined,
            label: 'مكان التوصيل',
            value: order.village.isNotEmpty
                ? '${order.city}، ${order.village}'
                : order.city,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusCard() {
    final submittedDone = _isDone(order.requestSubmitted);
    final reviewDone = _isDone(order.underReview);
    final reviewCurrent = _isProgress(order.underReview);
    final matchDone = _isDone(order.matchingWithDonor);
    final matchCurrent = _isProgress(order.matchingWithDonor);
    final onWayDone = _isDone(order.onTheWay);
    final onWayCurrent = _isProgress(order.onTheWay);
    final deliveredDone = _isDone(order.deliveryCompleted);

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
            status: 'تم تقديم الطلب',
            substatus: submittedDone ? '✓ مكتمل' : 'في الانتظار',
            isCompleted: submittedDone,
            isCurrent: !submittedDone,
            isFirst: true,
          ),
          _buildTimelineItem(
            status: 'قيد المراجعة',
            substatus: reviewDone
                ? '✓ مكتمل'
                : reviewCurrent
                ? 'جاري التنفيذ'
                : '',
            isCompleted: true,
            isCurrent: false,
          ),
          _buildTimelineItem(
            status: 'جاري المطابقة مع المتبرع',
            substatus: matchDone
                ? '✓ مكتمل'
                : matchCurrent
                ? 'جاري التنفيذ'
                : '',
            isCompleted: false,
            isCurrent: true,
          ),
          _buildTimelineItem(
            status: 'في الطريق',
            substatus: onWayDone
                ? '✓ مكتمل'
                : onWayCurrent
                ? 'جاري التوصيل'
                : '',
            isCompleted: onWayDone,
            isCurrent: onWayCurrent,
            isDelivery: true,
          ),
          _buildTimelineItem(
            status: 'تم التسليم',
            substatus: deliveredDone ? '✓ مكتمل' : '',
            isCompleted: deliveredDone,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String status,
    required String substatus,
    bool isCompleted = false,
    bool isCurrent = false,
    bool isFirst = false,
    bool isLast = false,
    bool isDelivery = false,
  }) {
    final Color circleColor = isCompleted
        ? const Color(0xFF2BA12F)
        : isCurrent
        ? const Color(0xFFF38C2B)
        : const Color(0xFFE0E0E0);

    final Color textColor = (isCompleted || isCurrent)
        ? Colors.black
        : const Color(0xFF999999);

    final Color subColor = isCompleted
        ? const Color(0xFF2BA12F)
        : isCurrent
        ? const Color(0xFFF38C2B)
        : const Color(0xFF999999);

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        substatus,
                        style: GoogleFonts.tajawal(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: subColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      if (isCurrent && !isCompleted) ...[
                        const SizedBox(width: 4),
                        Icon(Icons.access_time, size: 13, color: subColor),
                      ],
                    ],
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
                child: isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : isCurrent
                    ? Icon(
                        isDelivery
                            ? Icons.local_shipping_outlined
                            : Icons.favorite_border_outlined,
                        color: Colors.white,
                        size: 20,
                      )
                    : Icon(
                        isDelivery
                            ? Icons.local_shipping_outlined
                            : isLast
                            ? Icons.check
                            : Icons.favorite_border_outlined,
                        color: const Color(0xFFBDBDBD),
                        size: 20,
                      ),
              ),
              if (!isLast)
                Container(
                  width: 1.5,
                  height: 40,
                  color: isCompleted || isCurrent
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFE0E0E0),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
