import 'package:blood_app/app/screens/home/bloodrequest_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../controllers/firebase_controller/auth_controller.dart';
import 'contact_us.dart';
import 'darkmode_screen.dart';
import 'edit_profile.dart';
import 'home_screen.dart';
import 'notification_screen.dart';



class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //user profile section
           Obx((){
             String name=authController.userData['username']??'No name';
             String blood=authController.userData['bloodGroup']??'No blood';
             String image=authController.userData['profileImage']??'No image';
             return  Container(
               width: double.infinity,
               height: 260,
               decoration: BoxDecoration(
                 color: Colors.red,
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   const SizedBox(height: 50,),
                   CircleAvatar(
                     radius: 60,
                     backgroundImage: image.isNotEmpty?
                     NetworkImage(image):
                     null,child: image.isEmpty?
                     Icon(Icons.person,color: Colors.white,size: 60,):null,
                   ),
                   const SizedBox(height: 10,),
                   Text(name,
                     overflow: TextOverflow.ellipsis,
                     maxLines: 1,
                     style: GoogleFonts.numans(
                       color: Colors.white,
                       fontSize: 18,
                       fontWeight: FontWeight.w600,
                     ),),
                   const SizedBox(height: 5),
                   Text('Blood group: $blood',
                     overflow: TextOverflow.ellipsis,
                     style: GoogleFonts.numans(
                       color: Colors.white,
                       fontSize: 14,
                       fontWeight: FontWeight.w500,
                     ),),
                 ],
               ),
             );
           }),
            const SizedBox(height: 16),
            ListTile(
              title: Text('My dashboard',style: GoogleFonts.numans(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),),
            ),
            ListTile(
              onTap: (){
                Get.to(()=>HomeScreen());
              },
              leading: Icon(Icons.home,color: Colors.black,size: 20,),
              title: Text('Home',style: GoogleFonts.numans(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
              trailing: Container(
                  height: 40, width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                  ),
                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)),
            ),
            ListTile(
              onTap: (){
                authController.setInitialData();
                 Get.to(()=>EditProfile());
              },
              leading: Icon(Icons.person,color: Colors.black,size: 20,),
              title: Text('Edit profile',style: GoogleFonts.numans(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
              trailing: Container(
                  height: 40, width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)),
            ),
            ListTile(
              onTap: (){
                authController.setInitialData();
                Get.to(()=>BloodrequestScreen());
              },
              leading: Icon(Icons.bloodtype_outlined,color: Colors.black,size: 20,),
              title: Text('Request blood',style: GoogleFonts.numans(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
              trailing: Container(
                  height: 40, width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)),
            ),
            ListTile(
               title: Text('Settings',style: GoogleFonts.numans(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),),
             ),
            // ListTile(
            //   onTap: (){
            //     authController.setInitialData();
            //     Get.to(()=>NotificationScreen());
            //   },
            //   leading: Icon(Icons.notifications,color: Colors.black,size: 20,),
            //   title: Text('Notifications',style: GoogleFonts.numans(
            //     color: Colors.black,
            //     fontSize: 15,
            //     fontWeight: FontWeight.w500,
            //   ),),
            //   trailing: Container(
            //       height: 40, width: 40,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: Colors.red,
            //       ),
            //       child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)),
            // ),
            ListTile(
              onTap: (){
                Get.to(()=>DarkmodeScreen());
              },
              leading: Icon(Icons.dark_mode,color: Colors.black,size: 20,),
              title: Text('Darkmode',style: GoogleFonts.numans(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
              trailing: Container(
                  height: 40, width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                  ),
                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)),
            ),
            ListTile(
              onTap: (){
               Get.to(()=>ContactUs());
              },
              leading: Icon(Icons.support_agent,color: Colors.black,size: 20,),
              title: Text('Contact us',style: GoogleFonts.numans(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
              trailing: Container(
                  height: 40, width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                  ),
                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)),
            ),
            ListTile(
              onTap: (){
                logoutDialog();
              },
              leading: Icon(Icons.logout,color: Colors.red,size: 20,),
              title: Text('Logout',style: GoogleFonts.numans(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
              trailing: Container(
                  height: 40, width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red
                  ),
                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)),
            ),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
  //helper widget
logoutDialog(){
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        title: Center(child: Text('Logout ?',style: GoogleFonts.numans(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),)),
        content: Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: ()=>Get.back(),
                child: Text('No',style: GoogleFonts.numans(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),),
              ),
              InkWell(
                onTap: ()=>authController.logout(),
                child: Text('Yes',style: GoogleFonts.numans(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),),
              ),
            ],
          ),
        ),
      )
    );
}

}
