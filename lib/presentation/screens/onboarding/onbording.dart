import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:real_their/presentation/screens/home/home_screen.dart';

import '../auth/sign_in_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  static const String route = "OnBoarding";

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final introKey = GlobalKey<IntroductionScreenState>();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> listPagesViewModel = [
      PageViewModel(
        decoration: PageDecoration(
          bodyAlignment: Alignment.bottomCenter,
          titleTextStyle:
          TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold , color: Theme.of(context).colorScheme.primary),
          bodyTextStyle: TextStyle(fontSize: 17.sp , color: Colors.grey),
          pageMargin: REdgeInsets.all(20),
        ),
        titleWidget: Column(
          children: [
            SvgPicture.asset("assets/svg/House searching-rafiki 1.svg"),
            Text(
              "Find The Perfect Place",
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold , color: Theme.of(context).colorScheme.primary),
            )
          ],
        ),
        body: "Find the Ideal place according to your needs and Expectations",
      ),

      PageViewModel(
        decoration: PageDecoration(
          bodyAlignment: Alignment.bottomCenter,
          titleTextStyle:
              TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold , color: Theme.of(context).colorScheme.primary),
          bodyTextStyle: TextStyle(fontSize: 17.sp , color: Colors.grey),
          pageMargin: REdgeInsets.all(20),
        ),
        titleWidget: Column(
          children: [
            SvgPicture.asset("assets/svg/Select house-cuate 1.svg"),
            Text(
              "Buy a Place Easily",
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold , color: Theme.of(context).colorScheme.primary),
            )
          ],
        ),
        body: "Buy a Real Estate Quickly and Easily with One Click",
      ),
      PageViewModel(
        decoration: PageDecoration(
          bodyAlignment: Alignment.bottomCenter,
          titleTextStyle:
          TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold , color: Theme.of(context).colorScheme.primary),
          bodyTextStyle: TextStyle(fontSize: 17.sp , color: Colors.grey),
          pageMargin: REdgeInsets.all(20),
        ),
        titleWidget: Column(
          children: [
            SvgPicture.asset("assets/svg/Moving-bro 1.svg"),
            Text(
              "Start Living in your Dream Home",
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold , color: Theme.of(context).colorScheme.primary),
            )
          ],
        ),
        body: "Start Searching and Quickly find the Home you were Looking for",
      ),

    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: IntroductionScreen(
              pages: listPagesViewModel,
              key: introKey,
              animationDuration: 1,
              showNextButton: false,
              showSkipButton: false,
              showDoneButton: false,
              onChange: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              controlsPosition: Position(
                top: 20.h,
                bottom: 0,
                left: 0,
                right: 290.w
              ),
              dotsFlex: 0,
              dotsDecorator: DotsDecorator(
                color: Colors.grey,
                size: Size(10.w, 10.h),
                activeSize: Size(36.w, 12.h),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
          ),
          Padding(
            padding: REdgeInsets.only(bottom: 82, left: 32, right: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentPage == 0
                    ? Spacer()
                    : GestureDetector(
                  child: Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(16.sp))),
                    child:  Center(
                      child: Icon(
                        Icons.arrow_back_sharp,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                  onTap: () {
                    if (currentPage > 0) {
                      introKey.currentState?.previous();
                      setState(() {
                        currentPage--;
                      });
                    }
                  },
                ),
                currentPage != 2
                    ? GestureDetector(
                        child: Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.r))),
                          child:  Center(
                            child: Icon(
                              Icons.arrow_forward_sharp,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                          ),
                        ),
                        onTap: () {
                          introKey.currentState?.next();
                          setState(() {
                            currentPage++;
                          });
                        },
                      )
                    : GestureDetector(
                        child: Container(
                          height: 60.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.r))),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Get Started",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  fontSize: 18.sp
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_sharp,
                                color: Colors.white,
                                size: 30.sp,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, HomeScreen.route);
                        },
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
