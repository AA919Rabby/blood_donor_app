import 'package:blood_app/app/controllers/firebase_controller/auth_controller.dart';
import 'package:blood_app/app/widgets/custom_Auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


class BloodrequestScreen extends StatelessWidget {
  BloodrequestScreen({super.key});
  final authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if(authController.bloodRequestKey.currentState!.validate()){
                authController.uploadBloodRequest();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 20),
              child: Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    'Send',
                    style: GoogleFonts.numans(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:55,left: 25,right:25),
          child: Form(
            key: authController.bloodRequestKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 10,),
                Text("Rokto Bondhon",style: GoogleFonts.numans(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),),
                const SizedBox(height: 40,),
                CustomAuth(
                  controller: authController.uploadBlood,
                    validator: (value) {
                      String blood = value!.trim().toUpperCase();
                      // valid blood types
                      List<String> validGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
                      if (blood.isEmpty) {
                        return 'Enter your blood group';
                      }
                      if (!validGroups.contains(blood)) {
                        return 'Use format like A+ or O-';
                      }
                      return null;
                    },
                    labelText: 'Blood group',
                    prefixIcon: Icon(Icons.bloodtype_outlined,color: Colors.black,),
                    hintText:'Enter receiver blood group'),
                const SizedBox(height: 20,),
                CustomAuth(
                    controller: authController.uploadLocation,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your location';
                      }
                      return null;
                    },
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.location_on_outlined,color: Colors.black,),
                    hintText: 'Enter your location'),
                const SizedBox(height: 20,),
                CustomAuth(
                    controller: authController.uploadNumber,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your phone number';
                      }
                      return null;
                    },
                    labelText: 'Phone number',
                    prefixIcon: Icon(Icons.phone,color: Colors.black,),
                    hintText: '0140XXXXXXX'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
