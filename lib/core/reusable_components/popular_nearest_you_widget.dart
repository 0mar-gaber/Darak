import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../presentation/screens/Property_details/property_screen.dart';
import '../../presentation/view_models/favourite_view_model/favourite_view_model.dart';
import '../constant.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';

class PopularNearestYouWidget extends StatelessWidget {
  final String id;
  final String price;
  final String title;
  final String city;
  final String governorate;
  final String imageUrl;

  const PopularNearestYouWidget({
    super.key,
    required this.id,
    required this.governorate,
    required this.city,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final userId = PrefsHelper.getUserId();

    return BlocBuilder<FavouriteViewModel, FavouriteState>(
      builder: (context, state) {
        final viewModel = FavouriteViewModel.get(context);

        final isLoved = viewModel.favourites.any((fav) => fav.propertyId == id.toString());

        final isLoading = state is FavouriteLoading &&
            (state).loadingPropertyId == id.toString();

        return InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            PropertyScreen.route,
            arguments: id,
          ),
          child: Container(
            width: 300.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  imageUrl != ""
                      ? "${Constant.imageBaseUrl}$imageUrl"
                      : "https://st.hzcdn.com/simgs/acb1c8fb00ad9374_9-4194/home-design.jpg",
                ),
              ),
            ),
            child: Padding(
              padding: REdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (userId != null)
                        InkWell(
                          onTap: () {
                            if (!isLoading) {
                              if (isLoved) {
                                viewModel.removeFromFavourite(userId, id.toString());
                              } else {
                                viewModel.addToFavourite(userId, id.toString());
                              }
                            }
                          },
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
                            height: 36.sp,
                            isLoved
                                ? "assets/svg/selected_heart_icon.svg"
                                : "assets/svg/heart_icon.svg",
                          ),
                        )
                      else
                      // لو مش مسجل دخول، ممكن تعرض القلب بشكل ثابت أو تعطي أكشن تسجيل الدخول
                        SvgPicture.asset("assets/svg/heart_icon.svg"),
                    ],
                  ),
                  Text(
                    "$title\n$city, $governorate\n$price",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
