import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahtage_eh/core/networking/dio_helper.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/auth/auth_cubit.dart';
import 'package:mahtage_eh/features/auth/auth_Repo.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/requester_cubit.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_cubit.dart';
import 'package:mahtage_eh/core/routing/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (_) => AuthCubit(AuthRepository())),
            BlocProvider<RequesterCubit>(create: (_) => RequesterCubit()),
            BlocProvider<DonorCubit>(create: (_) => DonorCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mehtag Eh',
            theme: ThemeData(
              fontFamily: 'Tajawal',
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF1B5E20),
              ),
            ),
            onGenerateRoute: AppRouter.generateRoute,

            initialRoute: AppRoutes.splashScreenTwo,
          ),
        );
      },
    );
  }
}
