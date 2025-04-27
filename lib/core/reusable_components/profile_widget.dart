import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileWidget extends StatelessWidget {
  final String image ;
  final String name ;
  final String email ;
  const ProfileWidget({super.key,required this.image,required this.email,required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black,
          backgroundImage: NetworkImage(image),
          radius: 80.r,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          name,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 19.sp,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          email,
          style: TextStyle(
              color: Colors.grey,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
