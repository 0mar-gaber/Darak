import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileWidget extends StatelessWidget {
  final String image ;
  final String name ;
  final String email ;
  const ProfileWidget({super.key,required this.image,required this.email,required this.name});

  @override
  Widget build(BuildContext context) {
    print("======================================================");
    print(image);
    print("======================================================");
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 80.r,
          child: ClipOval(
            child: Image.network(
              image != "" ? image : "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg?semt=ais_hybrid&w=740",
              width: 160.r,
              height: 160.r,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // لو فيه مشكلة في تحميل الصورة، هنا نعرض الصورة البديلة
                return Image.network(
                  "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg?semt=ais_hybrid&w=740",
                  width: 160.r,
                  height: 160.r,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
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
