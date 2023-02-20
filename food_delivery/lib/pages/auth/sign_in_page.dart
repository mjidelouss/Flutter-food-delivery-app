import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class signInPage extends StatelessWidget {
  const signInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController) {

      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBar("Type in your phone", title: "Phone");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters", title: "Password");
      }else{
        authController.login(phone, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController){
          return !authController.isLoading?SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.screenHeight*0.05,),
                // app Logo
                Container(
                  height: Dimensions.screenHeight*0.25,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      backgroundImage: AssetImage(
                          "assets/images/logo-sign.png"
                      ),
                    ),
                  ),
                ),
                //Welcome
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                            fontSize: Dimensions.font20*3+Dimensions.font20/2,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Sign into your account",
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          //fontWeight: FontWeight.bold
                          color: Colors.grey[500],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                // Your Email
                AppTextField(
                    textController: phoneController,
                    hintText: "Phone",
                    icon: Icons.email),
                SizedBox(height: Dimensions.height20,),
                // Your Password
                AppTextField(
                    textController: passwordController,
                    hintText: "Password",
                    icon: Icons.password_sharp, isObscure:true),
                SizedBox(height: Dimensions.height20,),
                // Tag Line
                Center(
                  child: Container(
                    child: BigText(
                        text: "Sign into your account",
                        color: Colors.grey[500],
                        size: Dimensions.font20
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                // Sign In
                GestureDetector(
                  onTap: (){
                  _login(authController);
                },
                  child: Center(
                    child: Container(
                      width: Dimensions.screenWidth/2,
                      height: Dimensions.screenHeight/13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.mainColor,
                      ),
                      child: Center(
                        child: BigText(
                          text: "Sign in",
                          size: Dimensions.font20+Dimensions.font20/2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                // Sign up options
                Center(
                  child: RichText(
                      text: TextSpan(
                          text: "Don\'t have an account?",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20
                          ),
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.fade),
                                text: " Create",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.mainBlackColor,
                                    fontSize: Dimensions.font20
                                ))
                          ]
                      )
                  ),
                ),
              ],
            ),
          ):CustomLoader();
        })
    );
  }
}
