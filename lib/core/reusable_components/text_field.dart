import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnTap = void Function()?;
typedef Validate = String? Function(String?)?;

class EditText extends StatelessWidget {
  final String lapel;
  final bool obscureText ;
  final bool decorate;
  final OnTap? onTap;
  final IconButton? iconButton;
  final IconButton? prefixIconButton;
  final TextInputType ? keyboardType;
  final GlobalKey<FormState>? formKay;
  final Validate validate;
  final TextEditingController ? controller;
  final int? maxLength;
  final bool enabled ;

  const EditText({
    super.key,
    this.enabled = false,
    this.lapel = "",
    this.onTap,
    this.obscureText= false,
    this.decorate = true,
    this.iconButton,
    this.keyboardType,
    this.formKay,
    this.validate,
    this.prefixIconButton,
    this.controller,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorate
          ? BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                // Inner shadow effect
                BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  offset: const Offset(-1, 3),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            )
          : BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Color(0XFFDEEAFD))),
      child: TextFormField(
        controller: controller,
        validator: validate,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: maxLength,
        onTap: onTap,
        enabled: !enabled,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.primary,
        ),
        cursorColor: Theme.of(context).colorScheme.primary,
        cursorErrorColor: Colors.red,
        decoration: InputDecoration(
          counterText: "",
          fillColor: Colors.transparent,
          filled: true,
          errorStyle: const TextStyle(color: Colors.red),
          contentPadding: REdgeInsets.only(
            left: 25,
            top: 19,
            bottom: 22,
          ),
          suffixIcon: iconButton,
          prefixIcon: prefixIconButton,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: Text(lapel),
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 15.sp,fontWeight: FontWeight.w600),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(12.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(12.r),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide:
                BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
