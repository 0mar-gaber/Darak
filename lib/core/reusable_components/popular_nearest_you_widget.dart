import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../presentation/screens/Property_details/property_screen.dart';


class PopularNearestYouWidget extends StatefulWidget {
  final int id ;
  const PopularNearestYouWidget({super.key,required this.id});

  @override
  State<PopularNearestYouWidget> createState() => _PopularNearestYouWidgetState();
}

class _PopularNearestYouWidgetState extends State<PopularNearestYouWidget> {
  bool isLoved = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, PropertyScreen.route,arguments: widget.id),
      child: Container(
        width: 300.w,
        height: 230.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://st.hzcdn.com/simgs/acb1c8fb00ad9374_9-4194/home-design.jpg"))),
        child: Padding(
          padding: REdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset("assets/svg/star_icon.svg"),
                        Text(
                          "2.4",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isLoved = !isLoved;

                      });
                    },
                    child: !isLoved
                    ? SvgPicture.asset("assets/svg/heart_icon.svg")
                    : SvgPicture.asset("assets/svg/selected_heart_icon.svg"),
                  ),
                ],
              ),
              Text(
                "Modern ica Apartment\nNew York, US\n\$200000",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
