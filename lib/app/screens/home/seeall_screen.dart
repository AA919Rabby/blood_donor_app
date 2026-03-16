import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/firebase_controller/auth_controller.dart';
import '../../controllers/screencontroller/urllaunch_controller.dart';



class SeeallScreen extends StatelessWidget {
   SeeallScreen({super.key});
  final authController=Get.find<AuthController>();
  final  urlController=Get.put(UrllaunchController());
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
            child: Hero(
              tag: '',
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
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10,left: 25,right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Emergency request',style: GoogleFonts.numans(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),),
                const SizedBox(width: 10,),
                Icon(Icons.warning_amber,color: Colors.red,size: 25,),
              ],
            ),
            const SizedBox(height:20,),
           Expanded(
             child: StreamBuilder<QuerySnapshot>(
                 stream: FirebaseFirestore.instance
                     .collection('blood_requests')
                     .where('type', isEqualTo: 'emergency_request')
                     .orderBy('createdAt', descending: true)
                     .snapshots(),
                 builder: (context,snapshot){
                   if(snapshot.connectionState==ConnectionState.waiting){
                     return Center(
                       child: CircularProgressIndicator(color: Colors.red,),
                     );
                   }
                   if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                     return Center(
                       child: Text('No request found !',style: GoogleFonts.numans(
                         color: Colors.black,
                         fontSize: 18,
                         fontWeight: FontWeight.w600,
                       ),),
                     );
                   }
                   var docs=snapshot.data!.docs;
                   return ListView.builder(
                     physics: const BouncingScrollPhysics(),
                       itemCount: docs.length,
                       itemBuilder: (context,index){
                         var data = docs[index].data() as Map<String, dynamic>;
                         String requestId = data['requestId'] ?? '';
                         String postedBy = data['requestedBy'] ?? '';
                         return Slidable(
                           key: ValueKey(requestId),
                           startActionPane: ActionPane(motion: const StretchMotion(),
                             children: [
                               SlidableAction(
                                 onPressed: (context){
                                   deleteDonorRequest(requestId, postedBy);
                                 },
                                 borderRadius: BorderRadius.circular(10),
                                 backgroundColor: Colors.red,
                                 foregroundColor: Colors.white,
                                 icon: Icons.delete,
                                 label: 'Delete',

                               ),
                             ],
                           ),
                           child: Container(
                             height: 70,
                             margin: EdgeInsets.only(bottom: 10),
                             width: double.infinity,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Colors.grey.shade300,
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.grey.withOpacity(0.1),
                                   blurRadius: 10,
                                   offset: Offset(0, 4),
                                   spreadRadius: 1,
                                 ),
                               ],
                             ),
                             child: Container(
                               margin: EdgeInsets.only(bottom: 10),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.grey.shade300,
                               ),
                               child: ListTile(
                                 leading: CircleAvatar(
                                   radius: 25,
                                   backgroundImage: data['profileImage'] != null
                                       ? NetworkImage(data['profileImage'])
                                       : null,
                                   child: data['profileImage'] == null ? Icon(Icons.person) : null,
                                 ),
                                 title: Text(data['username'] ?? 'User',
                                   overflow: TextOverflow.ellipsis,
                                   maxLines: 1,
                                   style: GoogleFonts.numans(
                                       fontSize: 14,
                                       fontWeight: FontWeight.w600,
                                       color: Colors.black
                                   ),),
                                 subtitle:Text('Blood group: ${data['bloodGroup']}',
                                   overflow: TextOverflow.ellipsis,
                                   maxLines: 1,
                                   style: GoogleFonts.numans(
                                       fontSize: 11,
                                       fontWeight: FontWeight.w500,
                                       color: Colors.black
                                   ),),
                                 trailing: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     GestureDetector(
                                       onTap: () {
                                         if (data['phoneNumber'] != null && data['phoneNumber'].isNotEmpty) {
                                           urlController.makeCall(data['phoneNumber']);
                                         } else {
                                           Get.snackbar('Error', 'No phone number available',
                                               backgroundColor: Colors.red, colorText: Colors.white);
                                         }
                                       },
                                       child: Container(
                                           height: 28,
                                           width: 55,
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(8),
                                             color: Colors.green,
                                             boxShadow: [
                                               BoxShadow(
                                                 color: Colors.black.withOpacity(0.1),
                                                 blurRadius: 5,
                                                 offset: const Offset(0, 2),
                                               ),
                                             ],
                                           ),
                                           child: const Center(
                                               child: Icon(Icons.call, color: Colors.white, size: 18))),
                                     ),
                                     const SizedBox(height: 5,),
                                     Text(data['location'] ?? 'Not found',
                                       overflow: TextOverflow.ellipsis,
                                       maxLines: 1,
                                       style: GoogleFonts.numans(
                                           fontSize: 10,
                                           fontWeight: FontWeight.bold,
                                           color: Colors.black
                                       ),),
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         );
                       });
                 }),
           ),
          ],
        ),
      ),
    );
  }
  //helper widget
   deleteDonorRequest(String requestId,String postedBy){
     Get.dialog(
         barrierDismissible: false,
         AlertDialog(
           title: Center(child: Text('Delete received request ?',style: GoogleFonts.numans(
             color: Colors.black,
             fontSize: 15,
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
                   onTap: ()=>authController.deleteBloodRequest(requestId,postedBy),
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
