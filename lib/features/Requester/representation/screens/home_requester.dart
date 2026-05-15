import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/home_details_requester.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/profile_requester.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/request_order.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/requester_service.dart';

class HomeRequester extends StatefulWidget {
  const HomeRequester({super.key});

  @override
  State<HomeRequester> createState() => _HomeRequesterState();
}

class _HomeRequesterState extends State<HomeRequester> {
  int _currentIndex = 0;

  final List<Widget> _widgetOption = [
    HomeDetailsRequester(),
    RegisterOrderScreen(),
    RequesterService(),
    ProfileScreenRequester(),
  ];

  void _changeItem(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOption[_currentIndex],
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
                icon: Icon(Icons.add_circle_outline_rounded),
                label: "طلبات",
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.hand_heart),
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
