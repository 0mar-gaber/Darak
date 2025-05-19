import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/constant.dart';
import '../../../core/shared_provider/home_screen_provider.dart';

class ComparisonDetailsScreen extends StatelessWidget {
  const ComparisonDetailsScreen({super.key});

  static const String route = "ComparisonDetailsScreen";

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider homeScreenProvider = Provider.of<HomeScreenProvider>(
      context,
    );
    print("list = ${homeScreenProvider.property.length}");
    var firstProperty = homeScreenProvider.property[0];
    var secProperty = homeScreenProvider.property[1];
    homeScreenProvider.clearProperty();
    return Scaffold(
      body: ListView(
        padding: REdgeInsets.all(20),
        children: [
          SizedBox(height: 40.h),

          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(CupertinoIcons.back, size: 30.sp),
              ),
              SizedBox(width: 20.w),
              Text(
                "Comparison details",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: 30.h),

          Container(
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: REdgeInsets.all(18.0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // First Column
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18.r),
                            child: Image.network(
                              "${Constant.imageBaseUrl}${firstProperty.images[0]}",
                              width: 170.w,
                              height: 125.h,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Flexible(
                            child: Text(
                              firstProperty.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            firstProperty.priceFormatted,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "${firstProperty.bedrooms.toString()} Bedrooms",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "${firstProperty.bathrooms.toString()} Bathrooms",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "${firstProperty.area.toInt()}m",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Vertical Divider
                    VerticalDivider(
                      color: Colors.grey[400],
                      thickness: 1,
                      width: 20.w,
                    ),

                    // Second Column
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18.r),
                            child: Image.network(
                              "${Constant.imageBaseUrl}${secProperty.images[0]}",
                              width: 170.w,
                              height: 125.h,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Flexible(
                            child: Text(
                              secProperty.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            secProperty.priceFormatted,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "${secProperty.bedrooms.toString()} Bedrooms",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "${secProperty.bathrooms.toString()} Bathrooms",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "${secProperty.area.toInt()}m",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          SizedBox(height: 35.h),

          Text("Amenities",style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: REdgeInsets.all(18.0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // First Column
                    Expanded(
                      child: Column(
                        children: firstProperty.amenities.map((item) => Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: Text(
                            item
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '')
                                .trim(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                        )).toList(),
                      ),
                    ),

                    // Vertical Divider
                    VerticalDivider(
                      color: Colors.grey[400],
                      thickness: 1,
                      width: 20.w,
                    ),

                    Expanded(
                      child: Column(
                        children: secProperty.amenities.map((item) => Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: Text(
                            item
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '')
                                .trim(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                        )).toList(),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),


          SizedBox(height: 35.h),

          Text("Location",style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: REdgeInsets.all(18.0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // First Column
                    Expanded(
                      child: Center(
                        child: Text(
                          firstProperty.locationShort,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff605F5F),
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),

                    // Vertical Divider
                    VerticalDivider(
                      color: Colors.grey[400],
                      thickness: 1,
                      width: 20.w,
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          secProperty.locationShort,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff605F5F),
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
