import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_their/presentation/screens/add_listing/add_listing_screen.dart';

class AddApartmentSheet extends StatelessWidget {
  const AddApartmentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 65.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Padding(
        padding: REdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(height: 8.h,),
            Container(
              width: 66.w,
              height: 3.5.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                color: CupertinoColors.inactiveGray.withOpacity(.5),

              ),
            ),
            SizedBox(height: 28.h,),
            Row(
              children: [
                Text("What are you offering ? ",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 18.sp),textAlign: TextAlign.start,),
              ],
            ),


            SizedBox(height: 8.h,),
            Divider(),
            SizedBox(height: 18.h,),
            InkWell(
              onTap: () => Navigator.pushNamed(context, AddListingScreen.route,arguments: 1),
              child: Row(
                children: [
                  SvgPicture.asset("assets/svg/apartment.svg"),
                  SizedBox(width: 18.w,),
                  Text("Apartment for sale",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 18.sp),textAlign: TextAlign.start,),
                  Spacer(),
                  Icon(Icons.navigate_next,size: 35.sp,)
                ],
              ),
            ),


            SizedBox(height: 8.h,),
            Divider(),
            SizedBox(height: 12.h,),
            InkWell(
              onTap: () => Navigator.pushNamed(context, AddListingScreen.route,arguments: 2),

              child: Row(
                children: [
                  SvgPicture.asset("assets/svg/Villa.svg"),
                  SizedBox(width: 18.w,),
                  Text("Villa for sale",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 18.sp),textAlign: TextAlign.start,),
                  Spacer(),
                  Icon(Icons.navigate_next,size: 35.sp,)
                ],
              ),
            ),


            SizedBox(height: 8.h,),
            Divider(),
            SizedBox(height: 12.h,),
            InkWell(
              onTap: () => Navigator.pushNamed(context, AddListingScreen.route,arguments: 3),
              child: Row(
                children: [
                  SvgPicture.asset("assets/svg/Commercial.svg"),
                  SizedBox(width: 18.w,),
                  Text("Commercial for sale",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 18.sp),textAlign: TextAlign.start,),
                  Spacer(),
                  Icon(Icons.navigate_next,size: 35.sp,)
                ],
              ),
            ),
            SizedBox(height: 8.h,),
            Divider(),

          ],
        ),
      ),
    );
  }
}
