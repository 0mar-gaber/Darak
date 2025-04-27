import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../core/DI/di.dart';
import '../../../core/local_storage/shared_pref.dart';
import '../../../core/reusable_components/text_field.dart';
import '../../view_models/auth_view_model/auth_view_model.dart';
import 'otp_screen.dart';
import 'sign_in_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  static const String route = "ResetPasswordScreen" ;
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKay = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<AuthViewModel>(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: REdgeInsets.only(
                  left: 15,
                  top: 49
              ),
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(CupertinoIcons.back,color: Theme.of(context).colorScheme.primary,size: 35.sp,)),
            ),
            Padding(
              padding: REdgeInsets.only(
                  left: 34,
                right: 34
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start   ,
                children: [
                  SizedBox(height: 35.h,),
                  Text("Reset Password", style: TextStyle(color: Theme
                      .of(context)
                      .colorScheme
                      .primary, fontSize: 22.sp, fontWeight: FontWeight.bold),),
                  SizedBox(height: 7.h,),
                  Text("Please Enter Your Phone Number to Request a Password Reset.", style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),),
                  SizedBox(height: 78.h,),
                  Text("Phone Number*", style: TextStyle(color: Color(0xff888888),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600)),
                  SizedBox(height: 10.h,),
                  Form(
                    key: formKay,
                      child: EditText(
                        maxLength: 11,
                        iconButton: IconButton(onPressed: () {}, icon: Icon(Icons.call,size: 31.sp,)),
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        formKay: formKay,
                        controller: phoneNumberController,
                        validate: (value) {
                          if(value == null){
                            return "phone number Couldn't be empty";
                          }
                          if(value.length !=11 ){
                            return "please inter valid number";

                          }
                          return null;
                        },

                      )
                  ),
                  SizedBox(height: 40.h,),
                  BlocConsumer<AuthViewModel, AuthViewModelState>(
                    builder: (context, state) {
                      if(state is ForgotPasswordViewModelLoadingState){
                        return OutlinedButton(
                          onPressed: () {
                            if (formKay.currentState!.validate()) {}
                          },
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(double.maxFinite, 68.h),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: CircularProgressIndicator(color: Colors.white,),
                        ) ;
                      }
                      return OutlinedButton(
                        onPressed: () {
                          if (formKay.currentState!.validate()) {
                            AuthViewModel.get(context).forgotPassword(phoneNumberController.text);
                          }
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
                              "Request OTP",
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
                      ) ;
                    },
                    listener: (context, state) {
                      if (state is ForgotPasswordViewModelErrorState) {
                        print(state.errorMessage);
                        Fluttertoast.showToast(
                            toastLength: Toast.LENGTH_SHORT,
                            msg: "undefined number",
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0.sp
                        );
                      }
                      if (state is ForgotPasswordViewModelSuccessState) {
                        PrefsHelper.setPhoneNumber(phoneNumberController.text.toString());

                        Navigator.pushNamed(context, OtpScreen.route,arguments:  {
                          'phone number':phoneNumberController.text.toString() ,
                          'from': "reset password",
                        },);
                      }

                    },
                  ),

                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: REdgeInsets.only(bottom: 50),
              child: InkWell(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(context, SignInScreen.route, (route) => false);
                },
                child: Center(
                  child: Text("Already Have an Account? Sign In", style: TextStyle(color: Theme.of(context).colorScheme.primary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800)),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
