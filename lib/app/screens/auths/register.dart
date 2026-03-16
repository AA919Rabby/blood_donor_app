import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/firebase_controller/auth_controller.dart';
import '../../widgets/custom_Auth.dart';
import '../../widgets/custom_button.dart';
import 'package:get/get.dart';

import 'image_screen.dart';
import 'login.dart';



class Register extends StatelessWidget {
  Register({super.key});
  final authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(300),
                ),
                color:  Color(0xFFFF5252),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      top: 70,
                      left:0,
                      right: 0,
                      child: Center(
                        child:Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Form(
                            key: authController.registerKey,
                            child: Column(
                              children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Image.asset(
                                     'assets/images/logo.png',
                                     height: 100,
                                     width: 100,
                                     fit: BoxFit.cover,
                                   ),
                                 ],
                               ),
                                const SizedBox(height: 40),
                                CustomAuth(
                                    controller: authController.registerUsername,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Enter your username';
                                      }
                                      return null;
                                    },
                                    labelText: 'Username',
                                    prefixIcon: Icon(Icons.person,color: Colors.black,),
                                    hintText:'Enter your username'),
                                const SizedBox(height: 20,),
                                CustomAuth(
                                    controller: authController.registerEmail,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Enter your email';
                                      }
                                      if(!GetUtils.isEmail(value)){
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.alternate_email_outlined,color: Colors.black,),
                                    hintText:'example@gmail.com'),
                                const SizedBox(height: 20,),
                                CustomAuth(
                                    obscureText: true,
                                    controller: authController.registerPassword,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Enter your password';
                                      }
                                      if(value.length<8){
                                        return 'Password must be at least 8 characters';
                                      }return null;
                                    },
                                    labelText: 'Password',
                                    prefixIcon: Icon(Icons.key,color: Colors.black,),
                                    hintText:'Enter your password'),
                                const SizedBox(height: 20,),
                                CustomAuth(
                                    obscureText: true,
                                    controller: authController.registerConfirmPassword,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Enter your confirm password';
                                      }
                                     if(value!=authController.registerPassword.text){
                                        return 'Password does not match';
                                      }
                                       return null;
                                    },
                                    labelText: 'Confirm password',
                                    prefixIcon: Icon(Icons.key,color: Colors.black,),
                                    hintText:'Enter your confirm password'),
                                const SizedBox(height: 25,),
                              Obx(()=> authController.isLoading.value?Center(
                                child: CircularProgressIndicator(color: Colors.white,),
                              ):CustomButton(
                                  onTap: (){
                                    if(authController.registerKey.currentState!.validate()){
                                      Get.to(()=>ImageScreen());
                                    }
                                  },
                                  color: Colors.red[900]!,labelColor: Colors.white ,
                                  label: 'Next'),),
                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already have an account ?",style: GoogleFonts.numans(
                                      color: Colors.grey.shade400,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    const SizedBox(width: 10,),
                                    InkWell(
                                      onTap:() {
                                        Get.to(()=>Login(),duration: Duration(milliseconds: 700),
                                        transition: Transition.circularReveal,
                                        );
                                      },
                                      child: Hero(
                                        tag: '',
                                        child: Container(
                                          height: 28,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            child: FittedBox(
                                              child: Text("login >",style: GoogleFonts.numans(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
