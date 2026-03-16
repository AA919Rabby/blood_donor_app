import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
        padding: const EdgeInsets.only(top:10,left: 25,right:25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notifications older than 30 days are not available.",style: GoogleFonts.numans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),),
            const SizedBox(height: 15,),
            //Notifications
            Expanded(child: ListView.builder(
              itemCount: 20,
                itemBuilder: (context,index){
               return Padding(
                 padding: const EdgeInsets.only(left: 0,right: 0,bottom: 5),
                 child: ListTile(
                   title:Text("Your blood donation request was approved.",style: GoogleFonts.numans(
                     fontSize: 15,
                     fontWeight: FontWeight.w500,
                     color: Colors.black,
                   ),),
                   subtitle: Text("Your blood received request was approved.",style: GoogleFonts.numans(
                     fontSize: 15,
                     fontWeight: FontWeight.w500,
                     color: Colors.black,
                   ),),
                   trailing: Column(
                     children: [
                       Text("2 March, 2025",style: GoogleFonts.numans(
                         fontSize: 10,
                         fontWeight: FontWeight.w500,
                         color: Colors.black,
                       ),),
                       const SizedBox(height: 5,),
                       Container(
                         height: 25,
                         width: 100,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(8),
                           color: Colors.green,
                         ),
                         child: Center(
                           child: Text("APPROVED",style: GoogleFonts.numans(
                             fontSize: 12,
                             fontWeight: FontWeight.w500,
                             color: Colors.white,
                           ),),
                         ),
                       ),
                     ],
                   ),
                 ),
               );
            })),
          ],
        ),
      ),
    );
  }
}
