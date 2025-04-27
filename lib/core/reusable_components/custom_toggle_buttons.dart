import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomToggleButtons extends StatefulWidget {
  const CustomToggleButtons({super.key,required this.numberOfIndex, required this.listOfTitle});
  final  int numberOfIndex ;
  final List<String> listOfTitle ;


  @override
  State<CustomToggleButtons> createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  int selectedIndex = 0;

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
          },
          child: Container(
            margin: REdgeInsets.symmetric(horizontal: 8),
            height: 45.h,
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
              border: Border.all(
                color:  Theme.of(context).colorScheme.primary ,
                width: 1.sp,
              ),
              borderRadius: BorderRadius.circular(100.r)
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: REdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8
              ),
              child: Text(
                widget.listOfTitle[index],
                style: TextStyle(
                  fontSize: 15.sp,
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
