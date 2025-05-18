import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_their/domain/entitys/favourite_entity.dart';
import 'package:real_their/presentation/view_models/favourite_view_model/favourite_view_model.dart';

import '../../../../../core/local_storage/shared_pref.dart';
import '../../../../../core/reusable_components/recommend_for_you_widget.dart';
import '../../../auth/sign_up_screen.dart';

class WishlistTab extends StatefulWidget {
  const WishlistTab({super.key});

  @override
  State<WishlistTab> createState() => _WishlistTabState();
}

class _WishlistTabState extends State<WishlistTab> {
  @override
  Widget build(BuildContext context) {
    if (PrefsHelper.getToken() == "omar") {
      return Padding(
        padding: REdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Spacer(),

            SvgPicture.asset("assets/svg/user_not_found.svg",width: 140.w,height: 140.h,color: Theme.of(context).colorScheme.primary,),
            Spacer(),

            Text("No user founded try singing up to view",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp
              ),),
            Spacer(),

            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.route);
              },
              style: OutlinedButton.styleFrom(
                fixedSize: Size(double.maxFinite, 68.h),
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "sign up to view your profile",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .background,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.arrow_right,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .background,
                    size: 25.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    List<FavouriteEntity> faves = FavouriteViewModel.get(context).favourites;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 70.h)),
        SliverToBoxAdapter(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 35),
            child: Text(
              "Favorites",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 25.h)),
        SliverToBoxAdapter(child: SizedBox(height: 25.h)),
        SliverToBoxAdapter(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 35),
            child: Text(
              "${faves.length} Favorites",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: REdgeInsets.only(
            top: 21.h,
            left: 34.w,
            right: 34.w,
            bottom: 20.h,
          ),
          sliver: SliverGrid.builder(
            itemBuilder:
                (context, index) => RecommendForYouWidget(
                  id: faves[index].propertyId,
                  imageUrl: faves[index].mainImageUrl,
                  title: faves[index].title,
                  location: faves[index].address,
                  priceFormatted: faves[index].formattedPrice,
                  area: faves[index].area.toInt().toString(),
                ),
            itemCount: faves.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 18.w,
            ),
          ),
        ),
      ],
    );
  }
}
