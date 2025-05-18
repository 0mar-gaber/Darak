import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_their/core/DI/di.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';
import 'package:real_their/presentation/screens/home/home_screen.dart';
import 'package:real_their/presentation/view_models/profile_view_model/edit_profile_view_model.dart';

import '../../../core/constant.dart';
import '../../../core/reusable_components/dialog.dart';
import '../../../core/reusable_components/text_field.dart';
import '../../../domain/entitys/user_details_entity.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String route = "EditProfileScreen";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController governorateController = TextEditingController();
  GlobalKey<FormState> formKay = GlobalKey();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  late UserDetailsEntity userDetails;

  @override
  void initState() {
    super.initState();
    // ماينفعش نجيب الـ arguments في initState مباشرة
    // عشان كده بنستخدم Future.delayed عشان ياخد الوقت اللازم ويشتغل بعد build الأولي
    Future.delayed(Duration.zero, () {
      userDetails = ModalRoute.of(context)!.settings.arguments as UserDetailsEntity;

      userNameController.text = userDetails.userName == "string" ? "" : userDetails.userName;
      cityController.text = userDetails.governorate == "string" ? "" : userDetails.governorate;
      governorateController.text = userDetails.city == "string" ? "" : userDetails.city;

      setState(() {});  // اعمل rebuild علشان تبان القيم اللي اتحطت في الـ controllers
    });
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(20.r),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedImage = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedImage != null) {
                    setState(() {
                      _image = pickedImage;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ما تعيدش تعيين النصوص هنا عشان ماتضيعش بيانات المستخدم

    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<EditProfileViewModel>(),
        child: Form(
          key: formKay,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: ListView(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed:
                          () => Navigator.pushNamed(context, HomeScreen.route),
                      icon: Icon(CupertinoIcons.back, size: 30.sp),
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      "Edit Profiles",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 70.r,
                      backgroundColor: Colors.black,
                      backgroundImage:
                      _image == null
                          ? NetworkImage(
                        "${Constant.imageBaseUrl}${userDetails.profilePictureUrl}",
                      )
                      as ImageProvider
                          : FileImage(File(_image!.path)),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: _pickImage,
                      child: Text(
                        "Change Profile Picture",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Text(
                  "Profile Info",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  "User Name",
                  style: TextStyle(
                    color: Color(0xff888888),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                EditText(
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  formKay: formKay,
                  controller: userNameController,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Email should\'t be empty ';
                    }
                    return null;
                  },
                  iconButton: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "city",
                  style: TextStyle(
                    color: Color(0xff888888),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                EditText(
                  maxLength: 11,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  formKay: formKay,
                  controller: cityController,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return "this failed is required";
                    }
                    return null;
                  },
                  iconButton: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 25.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "governorate",
                  style: TextStyle(
                    color: Color(0xff888888),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                EditText(
                  maxLength: 11,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  formKay: formKay,
                  controller: governorateController,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return "this failed is required";
                    }
                    return null;
                  },
                  iconButton: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_city_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 25.sp,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                BlocConsumer<EditProfileViewModel, EditProfileState>(
                  builder: (context, state) {
                    if (state is EditProfileLoading) {
                      return Padding(
                        padding: REdgeInsets.only(left: 20, right: 20),
                        child: OutlinedButton(
                          onPressed: () {
                            if (formKay.currentState!.validate()) {}
                          },
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(double.maxFinite, 68.h),
                            backgroundColor:
                            Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: REdgeInsets.only(left: 20, right: 20),
                      child: OutlinedButton(
                        onPressed: () {
                          if (formKay.currentState!.validate()) {
                            EditProfileViewModel.get(context).editProfile(
                                userNameController.text,
                                cityController.text,
                                governorateController.text
                            );

                            PrefsHelper.setCity(cityController.text);
                            PrefsHelper.setGovernorate(governorateController.text);

                            if (_image != null) {
                              print(
                                "===============================================================",
                              );
                              EditProfileViewModel.get(
                                context,
                              ).uploadProfileImage(_image!);
                            }
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          fixedSize: Size(double.maxFinite, 68.h),
                          backgroundColor:
                          Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Update",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.background,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              CupertinoIcons.arrow_right,
                              color: Theme.of(context).colorScheme.background,
                              size: 25.sp,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  listener: (context, state) {
                    if (state is UploadImageLoading) {
                      DialogUtil.showLoadingDialog(context: context);
                    }
                    if (state is UploadImageSuccess) {
                      Fluttertoast.showToast(
                        msg: "profile updated successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0.sp,
                      );
                      Navigator.pop(context);
                      Navigator.pushNamed(context, HomeScreen.route);
                    }
                    if (state is EditProfileSuccess) {
                      Fluttertoast.showToast(
                        msg: "profile updated successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0.sp,
                      );
                      Navigator.pop(context);
                      Navigator.pushNamed(context, HomeScreen.route);
                    }

                    if (state is UploadImageSuccess &&
                        state is EditProfileSuccess) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, HomeScreen.route);
                    }
                    if (state is UploadImageError) {
                      print(state.error);
                    }
                    if (state is EditProfileError) {
                      DialogUtil.showMessageDialog(context: context, message: "user name is already taken ");
                    }
                  },
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}