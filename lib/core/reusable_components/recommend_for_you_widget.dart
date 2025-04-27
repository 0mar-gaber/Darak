import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../presentation/screens/Property_details/property_screen.dart';

class RecommendForYouWidget extends StatefulWidget {
  final int id ;
  const RecommendForYouWidget({super.key,required this.id});

  @override
  State<RecommendForYouWidget> createState() => _RecommendForYouWidgetState();
}

class _RecommendForYouWidgetState extends State<RecommendForYouWidget> {
  bool isLoved = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, PropertyScreen.route,arguments: widget.id),
      child: Column(
        children: [
          Stack(alignment: AlignmentDirectional.topEnd, children: [
            Container(
              width: 171.w,
              height: 100.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.black,
                image: DecorationImage(
                    image: NetworkImage("https://st.hzcdn.com/simgs/acb1c8fb00ad9374_9-4194/home-design.jpg"),
                  fit: BoxFit.fill
                )

              ),

            ),

            Padding(
              padding: REdgeInsets.all(14),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      isLoved = !isLoved;
                    });
                  },
                  child: !isLoved
                      ? SvgPicture.asset("assets/svg/heart_icon.svg")
                      : SvgPicture.asset(
                      "assets/svg/selected_heart_icon.svg")),
            )
          ]),
          SizedBox(
            height: 10.h,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Monroe Kangaroo\n', // نص مميز
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 19.sp
                  ),
                ),
                TextSpan(
                    text: '8 Stone pot Road, NY 070\n',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500

                    )
                ),
                TextSpan(
                    text: '\$20000',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500

                    )
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
