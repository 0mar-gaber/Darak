import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_their/core/reusable_components/dialog.dart';


import '../../../core/DI/di.dart';
import '../../../core/constant.dart';
import '../../../core/local_storage/shared_pref.dart';
import '../../../core/reusable_components/text_field.dart';
import '../../view_models/auth_view_model/auth_view_model.dart';
import '../home/home_screen.dart';
import 'reset_password_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String route = "SignInScreen";

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();

}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKay = GlobalKey();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<AuthViewModel>(),
        child: ListView(
          children:[ Padding(
            padding: REdgeInsets.only(
                top: 99,
                left: 35,
                right: 34
            ),
            child: Form(
              key: formKay,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: double.infinity),
                  Row(
                    children: [
                      SizedBox(width: 96.w,),
                      Image(image: AssetImage("assets/png/LOGO2.png")),
                    ],
                  ),
        
                  
                  SizedBox(height: 50.h,),
        
        
                  Text("Let’s Sign In You In", style: TextStyle(color: Theme
                      .of(context)
                      .colorScheme
                      .primary, fontSize: 22.sp, fontWeight: FontWeight.bold),),
                  SizedBox(height: 7.h,),
                  Text("Welcome Back You’ve Been Missed", style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),),
        
        
                  SizedBox(height: 30.h,),
        
        
        
        
                  Text("Email ID", style: TextStyle(color: Color(0xff888888),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600),),
                  SizedBox(height: 10.h,),
                  EditText(
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      formKay: formKay,
                      controller: emailController,
                    validate: (value) {
                      if (!RegExp(Constant.emailRegex).hasMatch(value!)) {
                        return "Enter valid email";
                      }
                      if (value.isEmpty) {
                        return 'Email should\'t be empty ';
                      }
                      return null;
                    },
                    iconButton: IconButton(
                        onPressed: (){},
                        icon: SvgPicture.asset("assets/svg/email_icon.svg",height: 17.h,width: 25.w,)
                    ),
                  ),
        
        
        
                  SizedBox(height: 20.h,),
        
        
        
                  Text("Password", style: TextStyle(color: Color(0xff888888),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600)),
                  SizedBox(height: 10.h,),
                  EditText(
                    iconButton: IconButton(onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    }, icon: showPassword == true
                        ? Icon(CupertinoIcons.eye,weight: 22.3.w,color: Theme.of(context).colorScheme.primary,)
                        : Icon(CupertinoIcons.eye_slash,weight: 22.3.w,color: Theme.of(context).colorScheme.primary,))
                    ,
                    obscureText: !showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    formKay: formKay,
                    controller: passwordController,
                    validate: (value) {
                      if(value == null){
                        return "password Couldn't be empty";
                      }
                      if(value.length < 6 ){
                        return "password Couldn't be less than 6 character";
        
                      }
                      return null;
                    },
        
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, ResetPasswordScreen.route),
                        child: Text("Forgot Password ?", style: TextStyle(color: Color(0xff888888),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h,),

                  BlocConsumer<AuthViewModel,AuthViewModelState>(
                      builder: (context, state) {
                        if(state is LoginViewModelLoadingState){
                          return OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(double.maxFinite, 68.h),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: CircularProgressIndicator( color: Colors.white,),
                          );
                        }

                        return OutlinedButton(
                          onPressed: () {
                            if (formKay.currentState!.validate()) {
                              AuthViewModel.get(context).login(emailController.text, passwordController.text);

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
                                "Sign In",
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
                        );
                      },
                      listener: (context, state) {
                        if (state is LoginViewModelErrorState) {
                         DialogUtil.showMessageDialog(context: context, message: "wrong in email or password ");
                        }
                        if (state is LoginViewModelSuccessState) {
                          Fluttertoast.showToast(
                              msg: "log in done successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0.sp
                          );
                          PrefsHelper.setToken(state.userEntity!.token);
                          PrefsHelper.setUserId(state.userEntity!.userId);
                          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.route, (route) => false);

                        }
                      },
                  ),
                  SizedBox(height: 70.h,),
        
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, SignUpScreen.route);
                    },
                    child: Center(
                      child: Text("Don’t Have an Account? Sign Up", style: TextStyle(color: Theme.of(context).colorScheme.primary,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800)),
                    ),
                  ),
        
        
        
        
        
                ],
              ),
            ),
          ),
             ] ),
      ),
    );
  }
}
