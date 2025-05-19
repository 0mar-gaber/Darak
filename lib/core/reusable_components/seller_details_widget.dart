import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_their/domain/entitys/property_entity.dart';

class SellerDetailsWidget extends StatelessWidget {
  final PropertyEntity propertyEntity;
  const SellerDetailsWidget({super.key, required this.propertyEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(left: 30, right: 30, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Padding(
        padding: REdgeInsets.only( left: 21, right: 21,top: 18,bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Listing Agent",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text(
                  propertyEntity.ownerName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 5,),
                Text(
                  propertyEntity.isOwner
                      ? "(Owner)"
                      : "(Partner)",
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis)),
                Spacer(),
                Text(
                  propertyEntity.contactInfo,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 10.w,),
                SvgPicture.asset("assets/svg/call.svg",width: 21.w,height: 18.h,),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
