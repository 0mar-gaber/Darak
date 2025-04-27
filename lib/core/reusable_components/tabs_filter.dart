import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabsFilter extends StatelessWidget {
  final String text;
  final int index;
  final int selectedIndex;
  final Function(int) onTap; // تمرير دالة لتحديث المؤشر

  const TabsFilter({
    super.key,
    required this.text,
    required this.index,
    required this.selectedIndex,
    required this.onTap, // استقبال الدالة
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(index); // تحديث المؤشر عند الضغط
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: index == selectedIndex
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xffDEEAFD), width: 1.4.w),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: index == selectedIndex ? Colors.white : Theme.of(context).colorScheme.primary,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
