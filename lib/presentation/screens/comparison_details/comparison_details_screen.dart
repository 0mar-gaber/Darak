import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/home_screen.dart';

class ComparisonDetailsScreen extends StatelessWidget {
  const ComparisonDetailsScreen({super.key});

  static const String route = "ComparisonDetailsScreen";

  @override
  Widget build(BuildContext context) {
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
                              "https://images.ctfassets.net/pg6xj64qk0kh/2r4QaBLvhQFH1mPGljSdR9/39b737d93854060282f6b4a9b9893202/camden-paces-apartments-buckhead-ga-terraces-living-room-with-den_1.jpg?fm=webp&w=1920",
                              width: 170.w,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "Monroe Kogarah",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "2,200,0000 L.E",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "3 Bedrooms",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "2 Bathrooms",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "150m",
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
                              "https://images.ctfassets.net/pg6xj64qk0kh/2r4QaBLvhQFH1mPGljSdR9/39b737d93854060282f6b4a9b9893202/camden-paces-apartments-buckhead-ga-terraces-living-room-with-den_1.jpg?fm=webp&w=1920",
                              width: 170.w,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "Monroe Kogarah",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "2,200,0000 L.E",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "3 Bedrooms",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "2 Bathrooms",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "150m",
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
                        children: [
                          Text(
                            "parking",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "Garden",
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

                    Expanded(
                      child: Column(
                        children: [

                          Text(
                            "parking",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "Gym",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "Swimming Pool",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),                  ],
                ),
              ),
            ),
          ),


          SizedBox(height: 35.h),

          Text("Nearby Facilities",style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
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
                        children: [
                          Text(
                            "parking",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "Garden",
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

                    Expanded(
                      child: Column(
                        children: [

                          Text(
                            "parking",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "Gym",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "Swimming Pool",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff605F5F),
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
