import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'circle_toggle_buttons.dart';
import 'custom_toggle_buttons.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  const FilterBottomSheetWidget({super.key});

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  RangeValues selectedValue = RangeValues(50000, 1000000);
  RangeValues selectedArea = RangeValues(20, 1000);
  final NumberFormat formatter = NumberFormat.decimalPattern();
  bool light = true;
  List<String> listOfAvailability = [
    'immediate',
    'Shortly',
    'Whatever',
  ];
  List<String> listOfFurnished = [
    'Yes',
    'No',
    'Whatever',
  ];



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 45.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 72.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Padding(
              padding: REdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "Filter",
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        "assets/svg/close_circle_icon.svg",
                        width: 26.w,
                        height: 26.h,
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: REdgeInsets.all(30),
              children: [
                Text(
                  "Value",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Min",style: TextStyle(fontSize:  14.sp, fontWeight: FontWeight.w400),),
                        Container(
                          width: 160.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CupertinoColors.inactiveGray,
                              width: 1.sp,
                            ),
                            borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Padding(
                            padding: REdgeInsets.all(10),
                            child: Text("${formatter.format(selectedValue.start.toInt())} EGP",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp,color: CupertinoColors.inactiveGray),),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Max",style: TextStyle(fontSize:  14.sp, fontWeight: FontWeight.w400),),
                        Container(
                          width: 160.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CupertinoColors.inactiveGray,
                              width: 1.sp,
                            ),
                            borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Padding(
                            padding: REdgeInsets.all(10),
                            child: Text("${formatter.format(selectedValue.end.toInt())} EGP",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp,color: CupertinoColors.inactiveGray),),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                RangeSlider(
                  values: selectedValue,
                  min: 50000,
                  max: 1000000,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
                SizedBox(height: 20.h),
                Divider(height: 1.h,),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rooms",style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp
                    ),),
                    CircleToggleButtons(numberOfIndex: 4,),

                  ],
                ),
                SizedBox(height: 20.h),
                Divider(height: 1.h,),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bathroom",style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp
                    ),),
                    CircleToggleButtons(numberOfIndex: 4,),

                  ],
                ),
                SizedBox(height: 20.h),
                Divider(height: 1.h,),
                SizedBox(height: 20.h),

                Text("Type of property",style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp
                ),),
                SizedBox(height: 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.88,
                          child: Switch(

                            value: light,
                            activeColor: Colors.white,
                            activeTrackColor: Theme.of(context).colorScheme.primary,
                            onChanged: (bool value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                light = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8.w,),
                        Text("Apartment",style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.88,
                          child: Switch(

                            value: light,
                            activeColor: Colors.white,
                            activeTrackColor: Theme.of(context).colorScheme.primary,
                            onChanged: (bool value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                light = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8.w,),
                        Text("Apartment",style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp
                        ),),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 20.h),

                Row(
                  children: [
                    Transform.scale(
                      scale: 0.88,
                      child: Switch(

                        value: light,
                        activeColor: Colors.white,
                        activeTrackColor: Theme.of(context).colorScheme.primary,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            light = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    Text("Apartment",style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp
                    ),),
                  ],
                ),
                SizedBox(height: 20.h),
                Divider(height: 1.h,),
                SizedBox(height: 20.h),

                Text("Availability",style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp
                ),),
                SizedBox(height: 20.h),


                CustomToggleButtons(numberOfIndex: 3,listOfTitle: listOfAvailability),
                SizedBox(height: 20.h),
                Divider(height: 1.h,),
                SizedBox(height: 20.h),

                Text(
                  "Area",
                  style:
                  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Min",style: TextStyle(fontSize:  14.sp, fontWeight: FontWeight.w400),),
                        Container(
                          width: 160.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: CupertinoColors.inactiveGray,
                                width: 1.sp,
                              ),
                              borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Padding(
                            padding: REdgeInsets.all(10),
                            child: Text("${formatter.format(selectedArea.start.toInt())} m²",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp,color: CupertinoColors.inactiveGray),),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Max",style: TextStyle(fontSize:  14.sp, fontWeight: FontWeight.w400),),
                        Container(
                          width: 160.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: CupertinoColors.inactiveGray,
                                width: 1.sp,
                              ),
                              borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Padding(
                            padding: REdgeInsets.all(10),
                            child: Text("${formatter.format(selectedArea.end.toInt())} m²",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp,color: CupertinoColors.inactiveGray),),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                RangeSlider(
                  values: selectedArea,
                  min: 20,
                  max: 1000,
                  onChanged: (value) {
                    setState(() {
                      selectedArea = value;
                    });
                  },
                ),
                SizedBox(height: 20.h),
                Divider(height: 1.h,),
                SizedBox(height: 20.h),

                Text("Furnished",style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp
                ),),
                SizedBox(height: 20.h),


                CustomToggleButtons(numberOfIndex: 3,listOfTitle: listOfFurnished),
                SizedBox(height: 20.h),
                Divider(height: 1.h,),
                SizedBox(height: 20.h),
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 100),
                  child: Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Center(
                        child: Text(
                          "Apply Filter",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
                SizedBox(height: 20.h),



              ],
            ),
          )
        ],
      ),
    );
  }
}
