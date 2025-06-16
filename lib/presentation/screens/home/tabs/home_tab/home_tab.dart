import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:real_their/core/DI/di.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';
import 'package:real_their/presentation/screens/edit_profile/edit_profile_screen.dart';

import '../../../../../core/reusable_components/popular_nearest_you_widget.dart';
import '../../../../../core/reusable_components/recommend_for_you_widget.dart';
import '../../../../../core/reusable_components/text_field.dart';
import '../../../../../core/shared_provider/home_screen_provider.dart';
import '../../../../view_models/home_tab_view_model/home_tab_view_model.dart';
import '../../../auth/sign_up_screen.dart';
import '../../../search_screen/search_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider homeScreenProvider = Provider.of<HomeScreenProvider>(
      context,
    );

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 35.h)),

          SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 34.w),
            sliver: SliverToBoxAdapter(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 130.h,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                bottomLeft: Radius.circular(20.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 130.h,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffD8D8D8),
                              image:DecorationImage(image: AssetImage("assets/png/3bad3a3a-2e21-4f10-9ef4-f8e84571855f.jpg"),fit: BoxFit.cover) ,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.r),
                                bottomRight: Radius.circular(20.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: REdgeInsets.all(25),
                    child: Text(
                      "Discover\nFind your\nBest Living Places.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          // ------- Search Field -------
          SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 32.w),
            sliver: SliverToBoxAdapter(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, SearchScreen.route),
                child: Row(
                  children: [
                    Expanded(
                      child: EditText(
                        lapel: "Search for. .",
                        obscureText: false,
                        enabled: true,
                        keyboardType: TextInputType.text,
                        formKay: GlobalKey(),
                        controller: SearchController(),
                        iconButton: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset("assets/svg/search_icon.svg"),
                        ),
                        decorate: false,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 60.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        border: Border.all(color: Color(0xffDEEAFD)),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: SvgPicture.asset("assets/svg/filter_icon.svg"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 25.h)),

          // ------- Popular Nearest You Title -------
          SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 34.w),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Nearest You",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      homeScreenProvider.changeTab(1);
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 21.h)),

          // BlocProvider للـ Near Me Properties فقط
          BlocProvider(
            create:
                (context) =>
                    getIt<GetPropertiesViewModel>()..getNearMeProperties(),
            child: Builder(
              builder: (context) {
                final token = PrefsHelper.getToken();
                if (token == "omar") {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 250.h,
                      child: Padding(
                        padding: REdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "No user found, try signing up to view your nearest properties",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  SignUpScreen.route,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                fixedSize: Size(double.maxFinite, 58.h),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.background,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.arrow_right,
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.background,
                                    size: 25.sp,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return BlocBuilder<
                    GetPropertiesViewModel,
                    GetPropertiesState
                  >(
                    builder: (context, state) {
                      if (state is SuccessGetNearMePropertiesState) {
                        var propertiesList = state.propertyResponseEntity;
                        print(propertiesList.length);
                        return propertiesList.isEmpty || propertiesList == []
                            ? SliverToBoxAdapter(
                              child: SizedBox(
                                height: 250.h,
                                child: Center(
                                  child: Padding(
                                    padding: REdgeInsets.all(30),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Unfortunately, there are no nearby properties for sale\n try add or change your city and governorate on your edit profile.',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            homeScreenProvider.changeTab(4);
                                          },
                                          style: OutlinedButton.styleFrom(
                                            fixedSize: Size(
                                              double.maxFinite,
                                              68.h,
                                            ),
                                            backgroundColor:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Edit Profile",
                                                style: TextStyle(
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.background,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Icon(
                                                CupertinoIcons.arrow_right,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.background,
                                                size: 25.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            : SliverToBoxAdapter(
                              child: SizedBox(
                                height: 300.h,
                                child: ListView.separated(
                                  padding: REdgeInsets.symmetric(
                                    horizontal: 34.w,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (
                                        context,
                                        index,
                                      ) => PopularNearestYouWidget(
                                        id: propertiesList[index].id,
                                        city: propertiesList[index].city,
                                        governorate:
                                            propertiesList[index].governorate,
                                        imageUrl:
                                            propertiesList[index].mainImageUrl,
                                        price:
                                            propertiesList[index]
                                                .priceFormatted,
                                        title: propertiesList[index].title,
                                      ),
                                  separatorBuilder:
                                      (context, index) => SizedBox(width: 20.h),
                                  itemCount: propertiesList.length,
                                ),
                              ),
                            );
                      }
                      if (state is ErrorGetNearMePropertiesState) {
                        print(state.error);
                        return SliverToBoxAdapter(
                          child: SizedBox(
                            height: 250.h,
                            child: Center(
                              child: Text(
                                'Some thing went error please try aging later .',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return SliverToBoxAdapter(child: SizedBox(height: 250.h));
                    },
                  );
                }
              },
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 25.h)),

          // ------- Recommend for You Title -------
          SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 34.w),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommend for You",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 21.h)),

          // BlocProvider منفصل لتحميل الـ Recommended Properties
          BlocProvider(
            create:
                (context) => getIt<GetPropertiesViewModel>()..getProperties(),
            child: BlocBuilder<GetPropertiesViewModel, GetPropertiesState>(
              builder: (context, state) {
                if (state is SuccessGetPropertiesState) {
                  return SliverPadding(
                    padding: REdgeInsets.only(
                      top: 0.h,
                      left: 34.w,
                      right: 34.w,
                      bottom: 20.h,
                    ),
                    sliver: SliverGrid.builder(
                      itemCount:
                          state
                              .propertyResponseEntity
                              .recommendedProperties
                              .length,
                      itemBuilder: (context, index) {
                        var property =
                            state
                                .propertyResponseEntity
                                .recommendedProperties[index];
                        return RecommendForYouWidget(
                          id: property.id,
                          title: property.title,
                          location: property.location,
                          priceFormatted: property.priceFormatted,
                          imageUrl: property.imageUrl,
                          area: property.areaFormatted,
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 18.w,
                        mainAxisSpacing: 50.h,
                      ),
                    ),
                  );
                } else if (state is ErrorGetPropertiesState) {
                  return SliverToBoxAdapter(child: SizedBox.shrink());
                }
                return SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ),

          // ... باقي الـ Slivers إن وجدت ...
        ],
      ),
    );
  }
}
