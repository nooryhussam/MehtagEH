import 'package:flutter/material.dart';
import 'package:mahtage_eh/core/presentation/choose_user.dart';
import 'package:mahtage_eh/core/presentation/loginin.dart';
import 'package:mahtage_eh/core/presentation/on_boarding.dart';
import 'package:mahtage_eh/core/presentation/splash_screen.dart';
import 'package:mahtage_eh/features/Donor/data/model/recommendation_model.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/donor_order.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/help_screen.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/home_donor.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/profile_screen.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/reqt_info.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/service_screen.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/signup_donor.dart';
import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/home_details_requester.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/home_requester.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/order_decription.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/profile_requester.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/request_order.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/requester_details.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/requester_service.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/signup_req.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/tracking.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/tracking_donor.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/matching_screeen.dart';

import 'routes.dart';

MaterialPageRoute _orderNotFound() => MaterialPageRoute(
  builder: (_) => const Scaffold(body: Center(child: Text('الطلب غير موجود'))),
);

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoarding());

      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.chooseUser:
        return MaterialPageRoute(builder: (_) => const ChooseUser());

      case AppRoutes.loginScreen:
        return MaterialPageRoute(builder: (_) => const Login());

      /// Donor Screens
      case AppRoutes.homeScreenDonor:
        return MaterialPageRoute(builder: (_) => const HomeDonor());

      case AppRoutes.signUpDonor:
        return MaterialPageRoute(builder: (_) => const SignUpDonor());

      case AppRoutes.matchingScreen:
        final recommendations =
            ((settings.arguments as List?)
                ?.whereType<RecommendedRequest>()
                .toList()) ??
            [];
        return MaterialPageRoute(
          builder: (_) => MatchingScreeen(recommendations: recommendations),
        );

      case AppRoutes.donorOrder:
        return MaterialPageRoute(builder: (_) => const DonorOrder());

      case AppRoutes.homeDonor:
        return MaterialPageRoute(builder: (_) => const HomeDonor());

      case AppRoutes.reqtInfoScreen:
        final request = settings.arguments as RecommendedRequest?;
        if (request == null) return _orderNotFound();
        return MaterialPageRoute(builder: (_) => ReqInfo(request: request));

      case AppRoutes.profileDonor:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case AppRoutes.serviceScreenDonor:
        return MaterialPageRoute(builder: (_) => const ServicesScreen());

      case AppRoutes.trackOrderScreenDonor:
        final request = settings.arguments as RecommendedRequest?;
        if (request == null) return _orderNotFound();
        return MaterialPageRoute(
          builder: (_) => OrderTrackingDonorScreen(request: request),
        );
      // case AppRoutes.trackOrderScreenDonor:
      //   final request = settings.arguments as RecommendedRequest?;
      //   if (request == null) return _orderNotFound();
      //   return MaterialPageRoute(
      //     builder: (_) => OrderTrackingDonorScreen(request: request),
      //   );

      // case AppRoutes.trackOrderScreenDonor:
      //   final requestId = settings.arguments as String?;
      //   if (requestId == null || requestId.isEmpty) return _orderNotFound();
      //   return MaterialPageRoute(
      //     builder: (_) => OrderTrackingDonorScreen(requestId: requestId),
      //   );
      // case AppRoutes.trackOrderScreenDonor:
      //   final request = settings.arguments as RecommendedRequest;
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         OrderTrackingDonorScreen(request: request, requestId: ''),
      //   );

      /// Requester Screens
      case AppRoutes.signUpReq:
        return MaterialPageRoute(builder: (_) => const SignUpReq());

      case AppRoutes.homeScreenRequester:
        return MaterialPageRoute(builder: (_) => const HomeRequester());

      case AppRoutes.homeDetails:
        return MaterialPageRoute(builder: (_) => HomeDetailsRequester());

      case AppRoutes.profileRequester:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreenRequester(),
        );

      case AppRoutes.requesterDetails:
        return MaterialPageRoute(
          builder: (_) => const RegisterDetailsScreen(requestType: ''),
        );

      case AppRoutes.helpScreen:
        return MaterialPageRoute(builder: (_) => const HelpScreen());

      case AppRoutes.orderDescription:
        return MaterialPageRoute(
          builder: (_) => const OrderDescription(
            requestType: '',
            age: 0,
            workStatus: '',
            isFamily: false,
            familyMembers: 0,
            city: '',
            village: '',
            hasDisability: false,
          ),
        );

      case AppRoutes.orderTracking:
        final order = settings.arguments as OrderModel?;
        if (order == null) return _orderNotFound();
        return MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(order: order),
        );

      case AppRoutes.requestOrder:
        return MaterialPageRoute(builder: (_) => const RegisterOrderScreen());

      case AppRoutes.requesterService:
        return MaterialPageRoute(builder: (_) => const RequesterService());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
