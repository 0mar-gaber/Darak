// // استبدل الكود بالكامل باللي تحت
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:real_their/core/shared_provider/home_screen_provider.dart';
//
// import 'custom_toggle_buttons.dart';
//
// class FilterBottomSheetWidget extends StatelessWidget {
//   const FilterBottomSheetWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final filterProvider = Provider.of<HomeScreenProvider>(context);
//     final formatter = NumberFormat.decimalPattern();
//
//     return Container(
//       width: double.infinity,
//       height: MediaQuery.of(context).size.height - 45.h,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
//       ),
//       child: Column(
//         children: [
//           Container(
//             height: 72.h,
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primary,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
//             ),
//             padding: REdgeInsets.all(20),
//             child: Row(
//               children: [
//                 Text(
//                   "Filter",
//                   style: TextStyle(
//                     fontSize: 24.sp,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const Spacer(),
//                 InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: SvgPicture.asset(
//                     "assets/svg/close_circle_icon.svg",
//                     width: 26.w,
//                     height: 26.h,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.only(
//                 left: 24.w,
//                 right: 24.w,
//                 bottom: MediaQuery.of(context).viewInsets.bottom + 30.h,
//                 top: 30.h,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildLabel("Value (EGP)"),
//                   _buildRangeInput(
//                     context,
//                     minLabel: "Min",
//                     maxLabel: "Max",
//                     minValue: filterProvider.filter.priceRange.start,
//                     maxValue: filterProvider.filter.priceRange.end,
//                     minHint: 'Min Price',
//                     maxHint: 'Max Price',
//                     sliderMin: 50000,
//                     sliderMax: 10000000,
//                     onMinSubmit: (val) {
//                       if (val >= 50000 && val <= filterProvider.filter.priceRange.end) {
//                         filterProvider.setPriceRange(
//                           RangeValues(val, filterProvider.filter.priceRange.end),
//                         );
//                       }
//                     },
//                     onMaxSubmit: (val) {
//                       if (val <= 10000000 && val >= filterProvider.filter.priceRange.start) {
//                         filterProvider.setPriceRange(
//                           RangeValues(filterProvider.filter.priceRange.start, val),
//                         );
//                       }
//                     },
//                   ),
//
//                   _buildDivider(),
//
//                   _buildLabel("Rooms"),
//                   _buildSingleNumberInput(
//                     context,
//                     initialValue: filterProvider.filter.rooms,
//                     hint: "Enter number of rooms",
//                     onSubmit: (val) {
//                       if (val > 0) {
//                         filterProvider.setRooms(val);
//                       }
//                     },
//                   ),
//
//                   _buildDivider(),
//
//                   _buildLabel("Bathrooms"),
//                   _buildSingleNumberInput(
//                     context,
//                     initialValue: filterProvider.filter.bathrooms,
//                     hint: "Enter number of bathrooms",
//                     onSubmit: (val) {
//                       if (val > 0) {
//                         filterProvider.setBathrooms(val);
//                       }
//                     },
//                   ),
//
//                   _buildDivider(),
//
//                   _buildLabel("Type of property"),
//                   CustomToggleButtons(
//                     numberOfIndex: 3,
//                     listOfTitle: ['Apartment', 'Villa', 'Commercial'],
//                     onSelect: (value) {
//                       filterProvider.setPropertyTypes(value);
//                     },
//                   ),
//
//                   _buildDivider(),
//
//                   _buildLabel("Furnished"),
//                   CustomToggleButtons(
//                     numberOfIndex: 3,
//                     listOfTitle: ['Yes', 'No', 'Semi'],
//                     onSelect: (value) {
//                       String state = "";
//                       switch (value) {
//                         case 'Yes':
//                           state = "Furnished";
//                           break;
//                         case 'No':
//                           state = "Not-furnished";
//                           break;
//                         case 'Semi':
//                           state = "Semi-furnished";
//                           break;
//                       }
//                       filterProvider.setFurnished(state);
//                     },
//                   ),
//
//                   _buildDivider(),
//
//                   _buildLabel("Area (m²)"),
//                   _buildRangeInput(
//                     context,
//                     minLabel: "Min",
//                     maxLabel: "Max",
//                     minValue: filterProvider.filter.areaRange.start,
//                     maxValue: filterProvider.filter.areaRange.end,
//                     minHint: 'Min Area',
//                     maxHint: 'Max Area',
//                     sliderMin: 20,
//                     sliderMax: 50000,
//                     onMinSubmit: (val) {
//                       if (val >= 20 && val <= filterProvider.filter.areaRange.end) {
//                         filterProvider.setAreaRange(
//                           RangeValues(val, filterProvider.filter.areaRange.end),
//                         );
//                       }
//                     },
//                     onMaxSubmit: (val) {
//                       if (val <= 50000 && val >= filterProvider.filter.areaRange.start) {
//                         filterProvider.setAreaRange(
//                           RangeValues(filterProvider.filter.areaRange.start, val),
//                         );
//                       }
//                     },
//                   ),
//
//                   _buildDivider(),
//
//                   Row(
//                     children: [
//                       _buildPrimaryButton(context, label: "Apply Filter", onTap: () => Navigator.pop(context)),
//                       const Spacer(),
//                       _buildOutlinedButton(
//                         context,
//                         label: "Reset Filter",
//                         onTap: () {
//                           filterProvider.resetFilter();
//                           Navigator.pop(context);
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             builder: (_) => const FilterBottomSheetWidget(),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30.h),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLabel(String text) => Padding(
//     padding: EdgeInsets.only(bottom: 10.h),
//     child: Text(
//       text,
//       style: TextStyle(
//         fontSize: 18.sp,
//         fontWeight: FontWeight.w700,
//       ),
//     ),
//   );
//
//   Widget _buildDivider() => Padding(
//     padding: EdgeInsets.symmetric(vertical: 20.h),
//     child: Divider(height: 1.h, color: Colors.grey.shade300),
//   );
//
//   Widget _buildSingleNumberInput(BuildContext context,
//       {required int? initialValue, required String hint, required Function(int) onSubmit}) {
//     return TextField(
//       keyboardType: TextInputType.number,
//       controller: TextEditingController(
//         text: (initialValue == null || initialValue == 0) ? '' : initialValue.toString(),
//       ),
//       onSubmitted: (value) {
//         int? val = int.tryParse(value);
//         if (val != null) onSubmit(val);
//       },
//       decoration: InputDecoration(
//         hintText: hint,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
//         contentPadding: REdgeInsets.all(10),
//         isDense: true,
//       ),
//     );
//   }
//
//   Widget _buildRangeInput(
//       BuildContext context, {
//         required String minLabel,
//         required String maxLabel,
//         required double minValue,
//         required double maxValue,
//         required String minHint,
//         required String maxHint,
//         required double sliderMin,
//         required double sliderMax,
//         required Function(double) onMinSubmit,
//         required Function(double) onMaxSubmit,
//       }) {
//     final formatter = NumberFormat.decimalPattern();
//     TextEditingController minController = TextEditingController(text: minValue.toInt().toString());
//     TextEditingController maxController = TextEditingController(text: maxValue.toInt().toString());
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(minLabel, style: TextStyle(fontSize: 14.sp)),
//                 SizedBox(
//                   width: 150.w,
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     controller: minController,
//                     onTap: () => minController.clear(),
//                     onSubmitted: (value) {
//                       double? val = double.tryParse(value);
//                       if (val != null) onMinSubmit(val);
//                     },
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
//                       hintText: minHint,
//                       contentPadding: REdgeInsets.all(10),
//                       isDense: true,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(maxLabel, style: TextStyle(fontSize: 14.sp)),
//                 SizedBox(
//                   width: 150.w,
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     controller: maxController,
//                     onTap: () => maxController.clear(),
//                     onSubmitted: (value) {
//                       double? val = double.tryParse(value);
//                       if (val != null) onMaxSubmit(val);
//                     },
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
//                       hintText: maxHint,
//                       contentPadding: REdgeInsets.all(10),
//                       isDense: true,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         Padding(
//           padding: EdgeInsets.only(top: 15.h),
//           child: RangeSlider(
//             values: RangeValues(minValue, maxValue),
//             min: sliderMin,
//             max: sliderMax,
//             divisions: 100,
//             activeColor: Theme.of(context).colorScheme.primary,
//             labels: RangeLabels(
//               formatter.format(minValue.toInt()),
//               formatter.format(maxValue.toInt()),
//             ),
//             onChanged: (values) {
//               onMinSubmit(values.start);
//               onMaxSubmit(values.end);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPrimaryButton(BuildContext context, {required String label, required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 50.h,
//         padding: EdgeInsets.symmetric(horizontal: 30.w),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.primary,
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOutlinedButton(BuildContext context, {required String label, required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 50.h,
//         padding: EdgeInsets.symmetric(horizontal: 30.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.r),
//           border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1.5.w),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16.sp, fontWeight: FontWeight.w500),
//           ),
//         ),
//       ),
//     );
//   }
// }
