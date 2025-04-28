import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_their/core/DI/di.dart';

import '../../../../../core/reusable_components/recommend_for_you_widget.dart';
import '../../../../../core/reusable_components/text_field.dart';
import '../../../search_screen/search_screen.dart';
import '../../../../view_models/home_tab_view_model/home_tab_view_model.dart';

class DiscoverTab extends StatelessWidget {
  const DiscoverTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetPropertiesViewModel>()..getProperties(),
      child: CustomScrollView(
        slivers: [
          // ------- Space from top --------
          SliverToBoxAdapter(child: SizedBox(height: 70.h)),

          // ------- Search Field -------
          SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 34.w),
            sliver: SliverToBoxAdapter(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, SearchScreen.route),
                child: Row(
                  children: [
                    Expanded(
                      child: EditText(
                        lapel: "Search for...",
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
                        border: Border.all(color: const Color(0xffDEEAFD)),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: SvgPicture.asset("assets/svg/filter_icon.svg"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 25.h)),

          // ------- Discover Title -------
          SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 34.w),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Discover Properties",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 21.h)),

          // ------- Properties Grid -------
          BlocBuilder<GetPropertiesViewModel, GetPropertiesState>(
            builder: (context, state) {
              if (state is LoadingGetPropertiesState) {
                return SliverToBoxAdapter(
                  child: SizedBox.shrink(child: Center(child: CircularProgressIndicator())),
                );
              } else if (state is SuccessGetPropertiesState) {
                var properties = state.propertyResponseEntity.recommendedProperties;

                return SliverPadding(
                  padding: REdgeInsets.symmetric(horizontal: 34.w),
                  sliver: SliverGrid.builder(
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      var property = properties[index];

                      return RecommendForYouWidget(
                        id: index,
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
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      state.error,
                      style: TextStyle(color: Colors.red, fontSize: 16.sp),
                    ),
                  ),
                );
              } else {
                return SliverToBoxAdapter(child: SizedBox.shrink());
              }
            },
          ),
        ],
      ),
    );
  }
}
