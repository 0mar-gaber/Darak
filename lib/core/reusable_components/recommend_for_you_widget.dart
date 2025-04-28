import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../presentation/screens/Property_details/property_screen.dart';

class RecommendForYouWidget extends StatefulWidget {
  final int id;
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
  bool isLoved = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, PropertyScreen.route, arguments: widget.id),
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
                    image: NetworkImage("https://10.0.2.2:7030${widget.imageUrl}"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: REdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isLoved = !isLoved;
                    });
                  },
                  child: SvgPicture.asset(
                    isLoved
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
    );
  }
}
