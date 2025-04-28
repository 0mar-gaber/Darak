
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/reusable_components/recommend_for_you_widget.dart';
import '../../../../../core/reusable_components/tabs_filter.dart';

class WishlistTab extends StatefulWidget {
  const WishlistTab({super.key});

  @override
  State<WishlistTab> createState() => _WishlistTabState();
}

class _WishlistTabState extends State<WishlistTab> {
  int selectedIndex = 0;

  List<String> tabs = [
    "All",
    "Home",
    "Trending",
    "Popular",
    "New",
    "Favorites",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 50.h,)),
        SliverToBoxAdapter(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 35),
            child: Text("Favorites",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 22.sp,fontWeight: FontWeight.w700),),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 25.h,)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 65.h,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: REdgeInsets.only(top: 15, left: 34, right: 34),
                itemBuilder: (context, index) => TabsFilter(
                  text: tabs[index],
                  index: index,
                  selectedIndex: selectedIndex,
                  onTap: (newIndex) {
                    setState(() {
                      selectedIndex = newIndex;
                    });
                  },
                ),
                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                itemCount: tabs.length),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 25.h,)),
        SliverToBoxAdapter(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 35),
            child: Text("25 Favorites",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 16.sp,fontWeight: FontWeight.w700),),
          ),
        ),
        SliverPadding(
          padding: REdgeInsets.only(
              top: 21.h, left: 34.w, right: 34.w, bottom: 20.h),
          sliver: SliverGrid.builder(
              itemBuilder: (context, index) => RecommendForYouWidget(id: index, imageUrl: '', title: '', location: '', priceFormatted: '',area: '',),
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 18.w,
              )),
        )




      ],
    );
  }
}
