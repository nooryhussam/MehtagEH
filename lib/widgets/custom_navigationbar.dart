// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_lucide/flutter_lucide.dart';
// import 'package:iconamoon/iconamoon.dart';

// class CustomNavigation extends StatefulWidget {
//   const CustomNavigation({super.key, required this.text1, required this.text2, required this.text3, required this.text4});

//   final String text1;
//   final String text2;
//   final String text3;
//   final String text4;

//   @override
//   State<CustomNavigation> createState() => _CustomNavigationState();
// }

// class _CustomNavigationState extends State<CustomNavigation> {
//   int _currentIndex = 0;
//   void _changeItem(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: Colors.white,
//       currentIndex: _currentIndex,
//       onTap: _changeItem,
//       selectedItemColor: Color(0xFF2BA12F),
//       unselectedItemColor: Color(0xFF666666),
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(LucideIcons.house),
//           label: "الرئيسية",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(LucideIcons.hand_heart),
//           label: "خدمات",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(LucideIcons.box),
//           label: "تتبع الطلب",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(IconaMoon.profile),
//           label: widget.text4,
//         ),
//       ],
//     );
//     // return ConvexAppBar(
//     //   height: 57,
//     //   curveSize: 26,
//     //   items: [
//     //     TabItem(icon: Icon(IconaMoon.home), title: 'الرئيسية'),
//     //     TabItem(icon: Icon(LucideIcons.hand_heart), title: 'الخدمات'),
//     //     TabItem(icon: Icon(Icons.shop), title: 'تتبع الطلب'),
//     //     TabItem(icon: Icon(Icons.person), title: 'الشخصية'),
//     //   ],
//     //   initialActiveIndex: _currentIndex,
//     //   onTap: _changeItem,

//     //   activeColor: Color(0xFF2BA12F),
//     //   color: Color(0xFF666666),
//     //   backgroundColor: Colors.white,
//     // );
//   }
// }

import 'package:flutter/material.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
  });

  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  int _currentIndex = 0;

  void _changeItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
    //  Directionality(
    //   textDirection: TextDirection.rtl,
    //   child:
    BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: _currentIndex,
      onTap: _changeItem,
      selectedItemColor: const Color(0xFF2BA12F),
      unselectedItemColor: const Color(0xFF666666),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            widget.image1,
            width: 20,
            height: 22,
            color: Color(0XFF666666),
          ),
          label: widget.text1,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(widget.image2, width: 20, height: 22),
          label: widget.text2,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(widget.image3, width: 20, height: 22),
          label: widget.text3,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(widget.image4, width: 20, height: 22),
          label: widget.text4,
        ),
      ],
    );
  }
}
