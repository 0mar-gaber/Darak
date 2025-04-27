import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/reusable_components/filter_bottom_sheet_widget.dart';
import '../../../core/reusable_components/text_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const String route= "SearchScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            SizedBox(height: 50.h,),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    } ,
                    icon: Icon(
                      CupertinoIcons.back,
                      size: 30.sp,
                      color: Theme.of(context).colorScheme.primary,
                    )
                ),
                SizedBox( width:  20.w),
                Text("Search",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 22.sp,fontWeight: FontWeight.w700),),
              ],
            ),
            SizedBox(height: 30.h,),
            Row(
              children: [
                Expanded(
                  child: EditText(
                    lapel: "Search for. .",
                    obscureText: false,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    formKay: GlobalKey(),
                    controller: SearchController(),
                    iconButton: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/svg/search_icon.svg")),
                    decorate: false,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => FilterBottomSheetWidget(),
                  ),
                  child: Container(
                    width: 60.w,
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      border: Border.all(color: const Color(0xffDEEAFD)),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(child: SvgPicture.asset("assets/svg/filter_icon.svg")),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
