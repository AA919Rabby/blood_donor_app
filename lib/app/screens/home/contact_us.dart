import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/screencontroller/urllaunch_controller.dart';



class ContactUs extends StatelessWidget {
  ContactUs({super.key});
  final urllaunchController=Get.put(UrllaunchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10,left: 20),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle
              ),
              child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10,left: 25,right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Support 24/7',style: GoogleFonts.numans(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),),
            const SizedBox(height: 6,),
            Text("Have an urgent need for blood or having trouble finding a donor? Our support team is available around the clock to assist you. Whether it’s a life-critical emergency or a simple question about the donation process, we are here to bridge the gap. Reach out to us via call or message, and let’s work together to ensure that no call for help goes unanswered.",style: GoogleFonts.numans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),),
            //const SizedBox(height: 6,),
            Text('Community & Feedback',style: GoogleFonts.numans(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),),
            const SizedBox(height: 6,),
            Text("Being a blood donor makes you a hero, and every hero deserves support. If you are unsure about your eligibility to donate, or if you need help updating your donor profile, our team is ready to guide you. Contact us for any information regarding donation camps, health requirements, or account assistance. We are committed to making your life-saving journey as smooth as possible.",style: GoogleFonts.numans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),),
           const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                GestureDetector(
                  onTap: (){
                    urllaunchController.sendEmail('rabbi@gmail.com');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.email,color: Colors.black,size: 18,),
                      const SizedBox(width: 3,),
                      Text('rabbi@gmail.com',style: GoogleFonts.numans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),),
                    ],
                  ),
                ),
                  const SizedBox(width: 11,),
                  Text('|',style: GoogleFonts.numans(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),),
                  const SizedBox(width:  11,),
                 GestureDetector(
                   onTap: (){
                     urllaunchController.makeCall('01402977919');
                   },
                   child: Row(
                     children: [
                       Icon(Icons.call,color: Colors.black,size: 17,),
                       const SizedBox(width: 3,),
                       Text('01402977919',style: GoogleFonts.numans(
                         fontSize: 15,
                         fontWeight: FontWeight.w600,
                         color: Colors.black,
                       ),),
                     ],
                   ),
                 )
                ],
              ),
            ),
            const SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}
