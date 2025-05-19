import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:real_their/presentation/view_models/propety_view_model/property_view_model.dart';

import '../../../core/constant.dart';
import '../../../core/reusable_components/property_details_widget.dart';
import '../../../core/reusable_components/seller_details_widget.dart';
import '../../../core/reusable_components/tabs_filter.dart';
import '../../../core/shared_provider/home_screen_provider.dart';
import '../../../../core/DI/di.dart';
import '../comparison_details/comparison_details_screen.dart';
import '../../view_models/favourite_view_model/favourite_view_model.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';

class PropertyScreen extends StatelessWidget {
  const PropertyScreen({super.key});

  static const String route = "PropertyScreen";

  @override
  Widget build(BuildContext context) {
    final propertyId = ModalRoute.of(context)?.settings.arguments as String?;
    HomeScreenProvider homeScreenProvider = Provider.of<HomeScreenProvider>(
      context,
    );
    final userId = PrefsHelper.getUserId();

    if (homeScreenProvider.property.length == 2) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamed(context, ComparisonDetailsScreen.route);
      });
    }

    return BlocProvider(
      create:
          (context) =>
              getIt<GetPropertyByIdViewModel>()..getPropertyById(propertyId!),
      child: BlocBuilder<GetPropertyByIdViewModel, GetPropertyByIdState>(
        builder: (context, state) {
          if (state is LoadingGetPropertyByIdState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is ErrorGetPropertyByIdState) {
            return Scaffold(body: Center(child: Text(state.error)));
          }
          if (state is SuccessGetPropertyByIdState) {
            final property = state.property;
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              "${Constant.imageBaseUrl}${property.images[0]}",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: REdgeInsets.all(35.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.chevron_back,
                                      color: Colors.white,
                                      size: 30.sp,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  Spacer(),
                                  BlocBuilder<
                                    FavouriteViewModel,
                                    FavouriteState
                                  >(
                                    builder: (context, favState) {
                                      final viewModel = FavouriteViewModel.get(
                                        context,
                                      );
                                      final isLoved = viewModel.favourites.any(
                                        (fav) =>
                                            fav.propertyId ==
                                            propertyId.toString(),
                                      );
                                      final isLoading =
                                          favState is FavouriteLoading &&
                                          favState.loadingPropertyId ==
                                              propertyId.toString();

                                      return InkWell(
                                        onTap: () {
                                          if (!isLoading) {
                                            if (isLoved) {
                                              viewModel.removeFromFavourite(
                                                userId!,
                                                propertyId.toString(),
                                              );
                                            } else {
                                              viewModel.addToFavourite(
                                                userId!,
                                                propertyId.toString(),
                                              );
                                            }
                                          }
                                        },
                                        child:
                                            isLoading
                                                ? CircleAvatar(
                                                  backgroundColor:
                                                      isLoved
                                                          ? Theme.of(
                                                            context,
                                                          ).colorScheme.primary
                                                          : Colors.white,
                                                  radius: 18.r,
                                                  child: Padding(
                                                    padding: REdgeInsets.all(
                                                      8.0,
                                                    ),
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color:
                                                              !isLoved
                                                                  ? Theme.of(
                                                                        context,
                                                                      )
                                                                      .colorScheme
                                                                      .primary
                                                                  : Colors
                                                                      .white,
                                                        ),
                                                  ),
                                                )
                                                : SvgPicture.asset(
                                                  isLoved
                                                      ? "assets/svg/selected_heart_icon.svg"
                                                      : "assets/svg/heart_icon.svg",
                                                ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        PropertyDetailsWidget(propertyEntity: property),
                        SellerDetailsWidget(propertyEntity: property),
                        _buildSectionTitle("Overview", context),
                        Padding(
                          padding: REdgeInsets.all(8.0),
                          child: _buildSectionText(property.description),
                        ),

                        _buildSectionTitle("Facilities", context),
                        Padding(
                          padding: REdgeInsets.only(
                            left: 34,
                            top: 16,
                            right: 20,
                          ),
                          child: StaggeredGrid.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 8.w,
                            children:
                                property.amenities
                                    .map(
                                      (facility) => TabsFilter(
                                        text:
                                            facility
                                                .toString()
                                                .replaceAll('[', '')
                                                .replaceAll(']', '')
                                                .trim(),
                                        index: 0,
                                        selectedIndex: 999,
                                        onTap: (_) {},
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),

                        _buildSectionTitle("Gallery", context),
                        Padding(
                          padding: REdgeInsets.only(
                            left: 34,
                            top: 16,
                            right: 20,
                          ),
                          child: StaggeredGrid.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 8.w,
                            children:
                                property.images
                                    .map(
                                      (img) => Container(
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            18.r,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "${Constant.imageBaseUrl}$img",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          height: 128.h,
                          color: Theme.of(context).colorScheme.secondary,
                          child: Center(
                            child: Padding(
                              padding: REdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                        borderRadius: BorderRadius.circular(
                                          5.r,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Estimate After 1 Year",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        homeScreenProvider.addToCompare(
                                          property,
                                        );

                                      },
                                      child: Container(
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                          border: Border.all(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                            width: 1.w,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Compare",
                                              style: TextStyle(
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SvgPicture.asset(
                                              "assets/svg/compare.svg",
                                              width: 24.w,
                                              height: 24.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 40.h,
                      left: 80.w,
                      right: 80.w,
                      child: Visibility(
                        visible: context.watch<HomeScreenProvider>().visibility,
                        child: InkWell(
                          onTap:
                              () =>
                                  context
                                      .read<HomeScreenProvider>()
                                      .clearProperty(),
                          child: Container(
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.35),
                                  // Light shadow
                                  blurRadius: 8,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Compare (${context.watch<HomeScreenProvider>().property.length} of 2 selected)",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,

                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Scaffold();
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Container(
      margin: REdgeInsets.only(left: 34, right: 34, top: 20),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700,
          fontSize: 19.sp,
        ),
      ),
    );
  }

  Widget _buildSectionText(String text) {
    return Container(
      margin: REdgeInsets.only(left: 34, right: 34, top: 20),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
