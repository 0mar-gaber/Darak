import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/reusable_components/recommend_for_you_widget.dart';
import '../../../../../core/reusable_components/tabs_filter.dart';
import '../../../../../core/reusable_components/text_field.dart';
import '../../../search_screen/search_screen.dart';

class DiscoverTab extends StatefulWidget {
  const DiscoverTab({super.key});

  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> {
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
        SliverToBoxAdapter(child: SizedBox(height: 70.h)),
        SliverPadding(
          padding: REdgeInsets.symmetric(horizontal: 34.w),
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
                          icon: SvgPicture.asset("assets/svg/search_icon.svg")),
                      decorate: false,
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    child: Container(
                      width: 60.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        border: Border.all(color: const Color(0xffDEEAFD)),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                          child: SvgPicture.asset("assets/svg/filter_icon.svg")),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        // قائمة Tabs
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
                      selectedIndex = newIndex; // تحديث المؤشر عند الضغط
                    });
                  },
                ),
                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                itemCount: tabs.length),
          ),
        ),
        SliverPadding(
          padding: REdgeInsets.only(
              top: 21.h, left: 34.w, right: 34.w, bottom: 20.h),
          sliver: SliverGrid.builder(
              itemBuilder: (context, index) => RecommendForYouWidget(id: index,),
              itemCount: 6,
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
