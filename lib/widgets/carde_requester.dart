// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mahtage_eh/widgets/button_app.dart';
// import '../features/Requester/data/model/order_model.dart'; // Ensure path is correct

// class CardsRequester extends StatelessWidget {
//   final OrderModel model;
//   final String imagepath;
//   final String textbutton;
//   final Color color;
//   final Color colorbutton;
//   final VoidCallback onTap;

//   const CardsRequester({
//     super.key,
//     required this.model,
//     required this.imagepath,
//     required this.textbutton,
//     required this.color,
//     required this.colorbutton,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 24),
//       padding: const EdgeInsets.only(
//         top: 20.76,
//         bottom: 0.78,
//         left: 20.76,
//         right: 20.76,
//       ),
//       height: 230,
//       width: 340,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(color: const Color(0xFFBEF9C4), width: 0.78),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         textDirection: TextDirection.rtl,
//         children: [
//           ListTile(
//             contentPadding: EdgeInsets.zero,
//             trailing: Image.asset(imagepath, width: 48, height: 48),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Status Badge
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         minimumSize: const Size(66, 25),
//                         side: BorderSide(color: colorbutton, width: 0.78),
//                         backgroundColor: colorbutton,
//                         elevation: 0,
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         model.status ?? 'قيد الانتظار',
//                         style: GoogleFonts.tajawal(
//                           color: color,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     // Title from Model
//                     Flexible(
//                       child: Text(
//                         model.title,
//                         style: GoogleFonts.tajawal(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         textAlign: TextAlign.right,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 // Description from Model
//                 Text(
//                   model.description,
//                   style: GoogleFonts.tajawal(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   textAlign: TextAlign.right,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//           AppButton(
//             text: textbutton,
//             onTap: onTap,
//             size: const Size(285.47, 43),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/widgets/button_app.dart';
import '../features/Requester/data/model/order_model.dart';

class CardsRequester extends StatelessWidget {
  final OrderModel model;
  final String imagepath;
  final String textbutton;
  final Color color;
  final Color colorbutton;
  final VoidCallback onTap;

  const CardsRequester({
    super.key,
    required this.model,
    required this.imagepath,
    required this.textbutton,
    required this.color,
    required this.colorbutton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.only(
        top: 20.76,
        bottom: 0.78,
        left: 20.76,
        right: 20.76,
      ),
      height: 230,
      width: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFBEF9C4), width: 0.78),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            trailing: Image.asset(imagepath, width: 48, height: 48),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Status Badge
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        minimumSize: const Size(66, 25),
                        side: BorderSide(color: colorbutton, width: 0.78),
                        backgroundColor: colorbutton,
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: Text(
                        model.statusLabel,
                        style: GoogleFonts.tajawal(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Title from Model
                    Flexible(
                      child: Text(
                        model.title,
                        style: GoogleFonts.tajawal(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Description from Model
                Text(
                  model.description,
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppButton(
            text: textbutton,
            onTap: onTap,
            size: const Size(285.47, 43),
          ),
        ],
      ),
    );
  }
}
