import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png"
    ];
    void _registration(AuthController authController){

      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Type in your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number", title: "Phone Number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email adress", title: "Email adress");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email adress", title: "Valid email adress");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters", title: "Password");
      }else{
        SignUpBody signUpBody = SignUpBody(name: name,
            phone: phone,
            email: email,
            password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registration");
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
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
              // Your Email
              AppTextField(
                  textController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              // Your Password
              AppTextField(
                  textController: passwordController,
                  hintText: "Password",
                  icon: Icons.password_sharp, isObscure:true),
              SizedBox(height: Dimensions.height20,),
              // Your Name
              AppTextField(
                  textController: nameController,
                  hintText: "Name",
                  icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              // Your Phone
              AppTextField(
                  textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone),
              SizedBox(height: Dimensions.height20+Dimensions.height20,),
              // Sign Up Button
              GestureDetector(
                onTap: (){
                  _registration(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign up",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              // Tag Line
              RichText(text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Already have an account?",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20
                  )
              )
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              // Sign up options
              RichText(text: TextSpan(
                  text: "Sign up using one of the following methods",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16
                  )
              )
              ),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/images/"+signUpImages[index]
                    ),
                  ),
                )),
              )
            ],
          ),
        ):CustomLoader();
      })
    );

  }
}
