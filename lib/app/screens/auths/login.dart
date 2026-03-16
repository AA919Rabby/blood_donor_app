import 'package:blood_app/app/screens/auths/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/firebase_controller/auth_controller.dart';
import '../../widgets/custom_Auth.dart';
import '../../widgets/custom_button.dart';


class Login extends StatelessWidget {
   Login({super.key});
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
                      top: 120,
                      left:0,
                      right: 0,
                      child: Center(
                        child:Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Form(
                            key: authController.loginKey,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 130,
                                  width: 130,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 40),
                                 CustomAuth(
                                     controller: authController.loginEmail,
                                     validator: (value){
                                       if(value!.isEmpty){
                                         return 'Enter your email';
                                       }
                                     return null;
                                     },
                                     labelText: 'Email',
                                     prefixIcon: Icon(Icons.alternate_email_outlined,color: Colors.black,),
                                     hintText:'example@gmail.com'),
                                const SizedBox(height: 20,),
                                CustomAuth(
                                    controller: authController.loginPassword,
                                     validator: (value){
                                       if(value!.isEmpty){
                                         return 'Enter your password';
                                       }
                                     return null;
                                     },
                                    labelText: 'Password',
                                    obscureText: true,
                                    prefixIcon: Icon(Icons.key,color: Colors.black,),
                                    hintText:'Enter your password'),
                                const SizedBox(height: 15,),
                                //forget pass
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Forget password ?',style: GoogleFonts.numans(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                              Obx(()=> authController.isLoading.value?Center(
                                child: CircularProgressIndicator(color: Colors.white,),
                              ):CustomButton(
                                  onTap: (){
                                    if(authController.loginKey.currentState!.validate()){
                                      authController.login();
                                    }
                                  },
                                  color: Colors.red[900]!,labelColor: Colors.white,
                                  label: 'Login'),),
                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don't have an account ?",style: GoogleFonts.numans(
                                      color: Colors.grey.shade400,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    const SizedBox(width: 10,),
                                      InkWell(
                                        onTap: ()=>Get.to(()=>Register(),duration: Duration(milliseconds: 700),
                                          transition: Transition.circularReveal,
                                        ),
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
                                                child: Text("Register >",style: GoogleFonts.numans(
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
