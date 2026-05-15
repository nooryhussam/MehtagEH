import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/home.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/profile_screen.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/service_screen.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/help_screen.dart';

class HomeDonor extends StatefulWidget {
  const HomeDonor({super.key});

  @override
  State<HomeDonor> createState() => _HomeDonorState();
}

class _HomeDonorState extends State<HomeDonor> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    Home(),
    ServicesScreen(),
    HelpScreen(),
    ProfileScreen(),
  ];

  void _changeItem(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.r)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: _changeItem,
            selectedItemColor: const Color(0xFF2BA12F),
            unselectedItemColor: const Color(0xFF666666),
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(fontSize: 11.sp),
            unselectedLabelStyle: TextStyle(fontSize: 11.sp),
            iconSize: 22.r,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.house),
                label: "الرئيسية",
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.hand_heart),
                label: "خدمات",
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.box),
                label: "تتبع الطلب",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconaMoon.profile),
                label: "الشخصية",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
