import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_their/domain/entitys/property_entity.dart';

class PropertyDetailsWidget extends StatelessWidget {
  final PropertyEntity propertyEntity ;
  const PropertyDetailsWidget({super.key, required this.propertyEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(left: 30, right: 30, top: 20),
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
                    propertyEntity.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color:
                        Theme.of(context).colorScheme.primary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                Text(
                  propertyEntity.priceFormatted,
                  style: TextStyle(
                    color:
                    Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Flexible(
                child: Text(
                  propertyEntity.locationShort,
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
                    Text(
                      propertyEntity.bedrooms.toString(),
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    SvgPicture.asset("assets/svg/Bedroom.svg"),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "Bedrooms",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      propertyEntity.bathrooms.toString(),
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    SvgPicture.asset("assets/svg/Bathroom.svg"),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "Bathrooms",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp),
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
                      "${propertyEntity.area.toInt()} sqft",
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
            ),
            SizedBox(
              height: 6.h,
            ),
          ],
        ),
      ),
    );
  }
}
