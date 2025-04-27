import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../home/home_screen.dart';

class VerificationStatusScreen extends StatelessWidget {
  const VerificationStatusScreen({super.key});

  static const String route = "VerificationStatusScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: REdgeInsets.only(top: 90, left: 34, right: 34),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                height: 35.h,
              ),
                  Text(
                "Verification Successful",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
                  SizedBox(height: 74.h,),
                  Center(child: SvgPicture.asset("assets/svg/success_icon.svg")),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Text(
                      "Congratulations",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Center(child: Text("Your Account is Ready to Use. You will be Redirected to the Home Page in a Few Seconds.",style: TextStyle(color: Colors.black,fontSize: 15.sp,fontWeight:FontWeight.w600 ),textAlign: TextAlign.center,)),
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding: REdgeInsets.only(left: 20,right: 20),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, HomeScreen.route);
                      },
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(double.maxFinite, 68.h),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Home Page",
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .background,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(CupertinoIcons.arrow_right,color: Theme.of(context).colorScheme.background,size: 25.sp)
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          )
        ],
      ),
    );
  }
}
