import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PropertyDetailsWidget extends StatelessWidget {
  const PropertyDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(left: 34, right: 34, top: 20),
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Padding(
        padding: REdgeInsets.only(top: 17, right: 21, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    "Modernistic Apartment",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color:
                        Theme.of(context).colorScheme.primary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Flexible(
                  child: Text(
                    "\$xxxxx",
                    style: TextStyle(
                      color:
                      Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
                child: Text(
                    "94 Happy Hollow Road Clinton, NY 282",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis))),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/svg/Bedroom.svg"),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Bedroom",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp),
                    )
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset("assets/svg/Bathroom.svg"),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Bathroom",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp),
                    )
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset("assets/svg/area.svg"),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "1360 sqft",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
