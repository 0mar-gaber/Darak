import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';
import 'package:real_their/presentation/view_models/favourite_view_model/favourite_view_model.dart';

import '../../presentation/screens/Property_details/property_screen.dart';
import '../constant.dart';

class RecommendForYouWidget extends StatefulWidget {
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
  State<RecommendForYouWidget> createState() => _RecommendForYouWidgetState();
}

class _RecommendForYouWidgetState extends State<RecommendForYouWidget> {
  @override
  Widget build(BuildContext context) {
    return PrefsHelper.getUserId() != null
        ? BlocListener<FavouriteViewModel, FavouriteState>(
      listener: (BuildContext context, FavouriteState state) {
        // تحديث الـ isLoved مباشرة عند التغيير في الـ state
        if (state is FavouriteGetSuccess ||
            state is FavouriteAddSuccess ||
            state is FavouriteRemoveSuccess) {
          setState(() {});
        }
      },
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, PropertyScreen.route,
            arguments: widget.id),
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
                          "${Constant.imageBaseUrl}${widget.imageUrl}"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: REdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      final isLoved = FavouriteViewModel.get(context)
                          .favourites
                          .any((fav) => fav.propertyId == widget.id);
                      if (isLoved) {
                        FavouriteViewModel.get(context)
                            .removeFromFavourite(
                            PrefsHelper.getUserId(), widget.id);
                      } else {
                        FavouriteViewModel.get(context)
                            .addToFavourite(
                            PrefsHelper.getUserId(), widget.id);
                      }
                    },
                    child: SvgPicture.asset(
                      FavouriteViewModel.get(context)
                          .favourites
                          .any((fav) => fav.propertyId == widget.id)
                          ? "assets/svg/selected_heart_icon.svg"
                          : "assets/svg/heart_icon.svg",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              widget.title,
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
              widget.location,
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
                  widget.priceFormatted,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.area,
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
      ),
    )
        : InkWell(
      onTap: () {
        // عندما يحاول المستخدم الضغط على القلب بدون تسجيل الدخول
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
                        "${Constant.imageBaseUrl}${widget.imageUrl}"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: REdgeInsets.all(10),
                child: SvgPicture.asset(
                  "assets/svg/heart_icon.svg", // يظهر القلب الأبيض
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            widget.title,
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
            widget.location,
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
                widget.priceFormatted,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.area,
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

  // دالة لعرض رسالة تطلب من المستخدم تسجيل الدخول
  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login Required"),
        content: const Text("Please log in first to enable this feature."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Here you can navigate the user to the login screen
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

}
