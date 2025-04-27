import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/reusable_components/property_details_widget.dart'
    show PropertyDetailsWidget;
import '../../../core/reusable_components/seller_details_widget.dart'
    show SellerDetailsWidget;
import '../../../core/reusable_components/tabs_filter.dart';
import '../../../core/shared_provider/home_screen_provider.dart';
import '../comparison_details/comparison_details_screen.dart';

class PropertyScreen extends StatefulWidget {
  const PropertyScreen({super.key});

  static const String route = "PropertyScreen";

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  bool isLoved = false;

  List<String> filters = [
    "Car Parking",
    "GYM & Fitness ",
    "Wi-fi",
    "Restaurant",
    "Laundry",
    "Camera",
    "Garden",
    "Sport Center ",
    "Garden",
  ];

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute
        .of(context)
        ?.settings
        .arguments as int?;

    HomeScreenProvider homeScreenProvider =
    Provider.of<HomeScreenProvider>(context);

    // التحقق إذا كانت قائمة property تحتوي على 2 أو أكثر
    if (homeScreenProvider.property.length == 2) {
      // الانتقال إلى شاشة المقارنة مباشرة بعد تحديث الطول
      Future.delayed(Duration.zero, () {
        Navigator.pushNamed(context, ComparisonDetailsScreen.route);
        homeScreenProvider.clearProperty();
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Stack(children: [
                        Container(
                          height: 420.h,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.r),
                                bottomRight: Radius.circular(30.r)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.r),
                                bottomRight: Radius.circular(30.r)),
                            child: Image(
                              image: NetworkImage(
                                  "https://th.bing.com/th/id/R.890d7b92838da508c266af885097b288?rik=pssDQZU%2bchcRHA&pid=ImgRaw&r=0"),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Padding(
                          padding: REdgeInsets.only(right: 34, top: 26),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    CupertinoIcons.back,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .primary,
                                    size: 40.sp,
                                  )),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isLoved = !isLoved;
                                  });
                                },
                                child: !isLoved
                                    ? SvgPicture.asset(
                                  "assets/svg/heart_icon.svg",
                                  width: 34.w,
                                  height: 34.h,
                                )
                                    : SvgPicture.asset(
                                  "assets/svg/selected_heart_icon.svg",
                                  width: 34.w,
                                  height: 34.h,
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                      PropertyDetailsWidget(),
                      SellerDetailsWidget(),
                      Container(
                        margin: REdgeInsets.only(left: 34, right: 34, top: 20),
                        child: Text(
                          "Overview",
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 19.sp),
                        ),
                      ),
                      Container(
                        margin: REdgeInsets.only(left: 34, right: 34, top: 20),
                        child: Text(
                          "The customer is very important, the customer will be followed by the customer. And these seven were named not by their own, but by the vote of all the people. The lust of Claudius, who was then in command.",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp),
                        ),
                      ),
                      Container(
                        margin: REdgeInsets.only(left: 34, right: 34, top: 20),
                        child: Text(
                          "Facilities",
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 19.sp),
                        ),
                      ),
                      Container(
                        margin: REdgeInsets.only(left: 34, top: 16, right: 20),
                        child: StaggeredGrid.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 8.w,
                            children: List.generate(
                              filters.length,
                                  (index) =>
                                  TabsFilter(
                                    text: filters[index],
                                    index: index,
                                    selectedIndex: 99999,
                                    onTap: (p0) {},
                                  ),
                            )),
                      ),
                      Container(
                        margin: REdgeInsets.only(left: 34, right: 34, top: 20),
                        child: Text(
                          "Gallery",
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 19.sp),
                        ),
                      ),
                      Container(
                        margin: REdgeInsets.only(left: 34, top: 16, right: 20),
                        child: StaggeredGrid.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12.h,
                          crossAxisSpacing: 8.w,
                          children: List.generate(
                            6,
                                (index) =>
                                Container(
                                  width: 108.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.r),
                                      color: Colors.black),
                                ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
                Container(
                  height: 128.h,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                  child: Center(
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 60.h,
                                decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Center(
                                    child: Text(
                                      "Estimate After 1 Year",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  homeScreenProvider.addToCompare(id!);
                                  print(homeScreenProvider.property.length);
                                },
                                child: Container(
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .primary,
                                        width: 1.w),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Compare",
                                        style: TextStyle(
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SvgPicture.asset(
                                        "assets/svg/compare.svg",
                                        width: 24.w,
                                        height: 24.h,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
          // زر المقارنة العائم
          Padding(
            padding: REdgeInsets.only(top: 100.h, left: 80.w, right: 80.w),
            child: InkWell(
              onTap: () {
                homeScreenProvider.clearProperty();
              },
              child: Visibility(
                visible: homeScreenProvider.visibility,
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      "Compare ( ${homeScreenProvider.property
                          .length} of 2 selected )",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

