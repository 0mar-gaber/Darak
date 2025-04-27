import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_their/core/DI/di.dart';
import 'package:real_their/presentation/view_models/profile_view_model/profile_view_model.dart';

import '../../../../../core/reusable_components/profile_widget.dart';
import '../../../edit_profile/edit_profile_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileViewModel>()..getUserDetails(),
      child: BlocBuilder<ProfileViewModel,ProfileState>(
        builder: (context, state) {
          if(state is SuccessState){
            print(state.userDetailsEntity.profilePictureUrl);
            return Padding(
              padding: REdgeInsets.all(35),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profiles",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            EditProfileScreen.route,
                            arguments: state.userDetailsEntity,
                          ),
                          child: SvgPicture.asset(
                            "assets/svg/edit_profil_icon.svg",
                            height: 20.h,
                            width: 20.w,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  ProfileWidget(
                    email: state.userDetailsEntity.email,
                    name: state.userDetailsEntity.bio,
                    image: "https://10.0.2.2:7030${state.userDetailsEntity.profilePictureUrl}", // <-- HTTP
                  ),
                  SizedBox(
                    height: 43.h,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      EditProfileScreen.route,
                      arguments: state.userDetailsEntity,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.navigate_next_sharp,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Booking",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.navigate_next_sharp,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Options",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.navigate_next_sharp,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Text(
                    "Preferences",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Padding(
                    padding: REdgeInsets.only(left: 24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Social",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.navigate_next_sharp,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Languages",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.navigate_next_sharp,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Notification",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.navigate_next_sharp,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Privacy Policy",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.navigate_next_sharp,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "FAQs",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.navigate_next_sharp,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Terms of Use",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.navigate_next_sharp,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                ],
              ),
            ) ;
          }
          if(state is ErrorState){
            return Center(
              child: IconButton(
                  onPressed: () => ProfileViewModel.get(context),
                  icon: Icon(Icons.error_outline)
              ),
            );
          }
          if(state is InitState){
            return Container(color: Colors.black,);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
