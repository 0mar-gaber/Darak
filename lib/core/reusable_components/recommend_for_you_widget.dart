import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';
import 'package:real_their/presentation/view_models/favourite_view_model/favourite_view_model.dart';

import '../constant.dart';

class RecommendForYouWidget extends StatelessWidget {
  final String id;
  final String title;
  final String location;
  final String priceFormatted;
  final String imageUrl;
  final String area;

  const RecommendForYouWidget({
    super.key,
    required this.id,
    required this.title,
    required this.location,
    required this.priceFormatted,
    required this.imageUrl,
    required this.area,
  });

  @override
  Widget build(BuildContext context) {
    final userId = PrefsHelper.getUserId();

    if (userId == null) {
      // حالة عدم تسجيل الدخول
      return _buildNotLoggedInWidget(context);
    }

    return BlocBuilder<FavouriteViewModel, FavouriteState>(
      builder: (context, state) {
        final viewModel = FavouriteViewModel.get(context);

        final isLoved = viewModel.favourites.any((fav) => fav.propertyId == id);

        final isLoading = state is FavouriteLoading &&
            (state).loadingPropertyId == id;

        return InkWell(
          onTap: () {
            if (!isLoading) {
              if (isLoved) {
                viewModel.removeFromFavourite(userId, id);
              } else {
                viewModel.addToFavourite(userId, id);
              }
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    width: 171.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(
                          "${Constant.imageBaseUrl}$imageUrl",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.all(10),
                    child: isLoading
                        ? CircleAvatar(
                      backgroundColor: isLoved
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                      radius: 18.r,
                      child: Padding(
                        padding: REdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: !isLoved
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                        ),
                      ),
                    )
                        : SvgPicture.asset(
                      isLoved
                          ? "assets/svg/selected_heart_icon.svg"
                          : "assets/svg/heart_icon.svg",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 19.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                location,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    priceFormatted,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    area,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotLoggedInWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        _showLoginDialog(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                width: 171.w,
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage(
                      "${Constant.imageBaseUrl}$imageUrl",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: REdgeInsets.all(10),
                child: SvgPicture.asset("assets/svg/heart_icon.svg"),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 19.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            location,
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                priceFormatted,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                area,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) =>
          AlertDialog(
            title: const Text("Login Required"),
            content: const Text("Please log in first to enable this feature."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }
}
