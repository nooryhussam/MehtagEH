import 'package:flutter/material.dart';
import 'package:mahtage_eh/widgets/content_onboarding.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            ContentOnboarding(
              image: 'assets/images/pic1.png',
              title: "منصتك الآمنة",
              subTitle:
                  'شارك احتياجك بسهولة وأمان، ودَع من حولك \n يمدّ لك يد العون في الوقت المناسب',
              controller: _controller,
              index: 0,
              totalPages: 3,
            ),
            ContentOnboarding(
              image: 'assets/images/pic2.png',
              title: 'شارك إحتياجاتك',
              subTitle:
                  'اطلب ما تحتاجه من طعام, أو دواء ,أو ملابس...  وسنساعدك لتصل إلى من يساندك بسرعة وسهولة',
              controller: _controller,
              index: 1,
              totalPages: 3,
            ),
            ContentOnboarding(
              image: 'assets/images/pic3.png',
              title: 'تبرع وساعد',
              subTitle:
                  'اختر من تريد مساعدته، وتابع أثر عطائك\nالحقيقي على حياة الآخرين',
              controller: _controller,
              index: 2,
              totalPages: 3,
            ),
          ],
        ),
      ),
    );
  }
}
