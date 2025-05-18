import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleToggleButtons extends StatefulWidget {
  const CircleToggleButtons({
    super.key,
    required this.numberOfIndex,
    required this.onSelected,
  });

  final int numberOfIndex;
  final ValueChanged<int> onSelected; // Callback to return the selected index

  @override
  State<CircleToggleButtons> createState() => _CircleToggleButtonsState();
}

class _CircleToggleButtonsState extends State<CircleToggleButtons> {
  int selectedIndex = -1; // Tracks the selected button index

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.numberOfIndex, (index) {
        bool isSelected = index == selectedIndex;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            // Pass the actual displayed value (index + 1) to the callback
            widget.onSelected(index + 1);
          },
          child: Container(
            margin: REdgeInsets.symmetric(horizontal: 8),
            width: 45.w,
            height: 45.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.sp,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}+',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
                color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      }),
    );
  }
}
