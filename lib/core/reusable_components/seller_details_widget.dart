import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellerDetailsWidget extends StatelessWidget {
  const SellerDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(left: 34, right: 34, top: 20),
      height: 130.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Padding(
        padding: REdgeInsets.only(top: 18, left: 21, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Listing Agent",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10.h,
            ),

            Row(
              children: [
                CircleAvatar(
                  radius: 33.r,
                  backgroundImage: NetworkImage("https://img.freepik.com/free-photo/lifestyle-people-emotions-casual-concept-confident-nice-smiling-asian-woman-cross-arms-chest-confident-ready-help-listening-coworkers-taking-part-conversation_1258-59335.jpg?t=st=1739499048~exp=1739502648~hmac=9edcca72d8d8ce5ab84994fb36d49d35e281be91962cbc6d5df0d9054c36148a&w=996"),
                  backgroundColor: Colors.black,
                ),
                SizedBox(width: 8.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "William T. Fontana",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                        "Partner",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            overflow: TextOverflow.ellipsis)),


                  ],
                ),
                Spacer(),
                SvgPicture.asset("assets/svg/chat.svg",width: 21.w,height: 18.h,),
                SizedBox(width: 14.w,),
                SvgPicture.asset("assets/svg/call.svg",width: 21.w,height: 18.h,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
