import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/requester_cubit.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/requester_state.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/tracking.dart';
import 'package:mahtage_eh/features/auth/auth_cubit.dart';
import 'package:mahtage_eh/features/auth/auth_state.dart';
import 'package:mahtage_eh/widgets/helpcard.dart';
import 'package:mahtage_eh/widgets/carde_requester.dart'; // ← import الـ card
import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';

class HomeDetailsRequester extends StatefulWidget {
  const HomeDetailsRequester({super.key});

  @override
  State<HomeDetailsRequester> createState() => _HomeDetailsRequesterState();
}

class _HomeDetailsRequesterState extends State<HomeDetailsRequester> {
  @override
  void initState() {
    super.initState();
    context.read<RequesterCubit>().getRequests();
  }

  final List<String> images = [
    'assets/images/p1.png',
    'assets/images/p2.png',
    'assets/images/p3.png',
  ];

  Color _getStatusTextColor(OrderModel order) {
    switch (order.computedStatus) {
      case 'delivery_completed':
        return const Color(0xFF1B7F2E); // أخضر غامق
      case 'on_the_way':
        return const Color(0xFF1A56DB); // أزرق
      case 'matching_with_donor':
      case 'under_review':
        return const Color(0xFFC1630B); // برتقالي
      default:
        return const Color(0xFF6B7280); // رمادي
    }
  }

  Color _getStatusBgColor(OrderModel order) {
    switch (order.computedStatus) {
      case 'delivery_completed':
        return const Color(0xFFBEF9C4); // أخضر فاتح
      case 'on_the_way':
        return const Color(0xFFDBEAFE); // أزرق فاتح
      case 'matching_with_donor':
      case 'under_review':
        return const Color(0xFFFFEDD5); // برتقالي فاتح
      default:
        return const Color(0xFFF3F4F6); // رمادي فاتح
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: Image.asset('assets/icons/notification.png'),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: Colors.white,
        actions: [
          BlocBuilder<RequesterCubit, RequesterState>(
            builder: (context, requesterState) {
              final cubit = context.read<RequesterCubit>();
              final name = (cubit.currentUser?.name.isNotEmpty ?? false)
                  ? cubit.currentUser!.name
                  : "مستخدم";

              return Row(
                children: [
                  Text(
                    'أهلا بك\n$name',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.tajawal(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  // ClipOval(
                  //   child: Image.asset(
                  //     'assets/images/profile.jpg',
                  //     width: 40,
                  //     height: 40,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Icon(Icons.person),
                ],
              );
            },
          ),
        ],
        centerTitle: false,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<RequesterCubit, RequesterState>(
            listener: (context, state) {
              if (state is RequesterError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedOut) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.loginScreen,
                  (route) => false,
                );
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              children: [
                HelpCard(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.requestOrder),
                  text1: 'محتاج مساعدة ؟',
                  text2: 'قدم طلب الآن',
                  textButton: 'طلب',
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      'طلبات سابقة',
                      style: GoogleFonts.tajawal(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.requesterService,
                      ),
                      child: const Text(
                        'رؤية المزيد',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFC1630B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                BlocBuilder<RequesterCubit, RequesterState>(
                  builder: (context, state) {
                    if (state is RequesterLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(
                            color: Color(0xFFC1630B),
                          ),
                        ),
                      );
                    }

                    if (state is GetRequestsSuccess &&
                        state.requests.isNotEmpty) {
                      final lastOrder = state.requests.first;

                      return CardsRequester(
                        model: lastOrder,
                        imagepath: lastOrder.resolvedImage,
                        textbutton: 'تتبع الطلب',
                        color: _getStatusTextColor(lastOrder),
                        colorbutton: _getStatusBgColor(lastOrder),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                OrderTrackingScreen(order: lastOrder),
                          ),
                        ),
                      );
                    }

                    return _buildEmptyState();
                  },
                ),

                const SizedBox(height: 24),
                _buildServicesSection(screenWidth, context),
                const SizedBox(height: 24),
                _buildBannersSection(screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(
            'لا توجد طلبات سابقة',
            style: GoogleFonts.tajawal(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(double screenWidth, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              'خدمات',
              style: GoogleFonts.tajawal(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.requesterService),
              child: const Text(
                'رؤية المزيد',
                style: TextStyle(fontSize: 12, color: Color(0xFFC1630B)),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildServiceIcon(
              context,
              'assets/images/Frame 2187.png',
              screenWidth,
            ),
            _buildServiceIcon(
              context,
              'assets/images/Frame 2608602.png',
              screenWidth,
            ),
            _buildServiceIcon(
              context,
              'assets/images/Frame 2608603.png',
              screenWidth,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBannersSection(double screenWidth) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        itemCount: images.length,
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              images[index],
              width: screenWidth * 0.85,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceIcon(
    BuildContext context,
    String asset,
    double screenWidth,
  ) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.requestOrder),
      child: Image.asset(
        asset,
        width: screenWidth * 0.28,
        height: screenWidth * 0.28,
        fit: BoxFit.contain,
      ),
    );
  }
}
