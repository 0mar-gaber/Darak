import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AddListing2Screen extends StatelessWidget {
  const AddListing2Screen({super.key});

  static const String route = "AddListing2Screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: REdgeInsets.all(28.0),
          children: [
            Row(
              children: [
                const Spacer(),
                CircularPercentIndicator(
                  radius: 28.0,
                  lineWidth: 9.0,
                  percent: 1,
                  center: Text(
                    "2/2",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  progressColor: Theme.of(context).colorScheme.primary,
                  reverse: true,
                ),
              ],
            ),
            SizedBox(height: 0.h),

            // Ad title
            Text(
              "Add title *",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(width: 2.5.w, color: Colors.black),
                ),
                hintText: "Enter title",
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // Description
            Text(
              "Description *",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              minLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(width: 2.5.w, color: Colors.black),
                ),
                hintText: "Describe the property you are selling",
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // Location
            Text(
              "Location *",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () {
                // Navigate to location picker
              },
              child: Container(
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5.w, color: Colors.black),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Choose location",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16.sp),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // Price
            Text(
              "Price *",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter price",
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(width: 2.5.w, color: Colors.black),
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // Name
            Text(
              "Your name *",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter your name",
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(width: 2.5.w, color: Colors.black),
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // Phone
            Text(
              "mobile phone *",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Enter your Phone number",
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(width: 2.5.w, color: Colors.black),
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: REdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Colors.black, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text("Previous", style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700)),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Submit form
                    },
                    style: ElevatedButton.styleFrom(
                      padding: REdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text("Post Now", style: TextStyle(fontSize: 20.sp,color: Colors.white,fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
