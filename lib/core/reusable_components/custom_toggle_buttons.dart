import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomToggleButtons extends StatefulWidget {
  const CustomToggleButtons({
    super.key,
    required this.numberOfIndex,
    required this.listOfTitle,
    required this.onSelect,  // Callback function to return selected value
  });

  final int numberOfIndex;
  final List<String> listOfTitle;
  final Function(String selectedValue) onSelect; // Function to send selected value

  @override
  State<CustomToggleButtons> createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 3,
      mainAxisSpacing: 15.h,
      children: List.generate(widget.numberOfIndex, (index) {
        bool isSelected = index == selectedIndex;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            // Send the selected value to the parent widget
            widget.onSelect(widget.listOfTitle[selectedIndex]);
          },
          child: Container(
            margin: REdgeInsets.symmetric(horizontal: 8.w), // Use .w for proper scaling
            height: 45.h,
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.sp,
              ),
              borderRadius: BorderRadius.circular(100.r),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: REdgeInsets.symmetric(
                horizontal: 15.w, // Use .w for proper scaling
                vertical: 8.h,   // Use .h for proper scaling
              ),
              child: Text(
                widget.listOfTitle[index],
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
