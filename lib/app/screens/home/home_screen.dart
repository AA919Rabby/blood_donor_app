import 'package:blood_app/app/screens/home/seeall_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import '../../controllers/firebase_controller/auth_controller.dart';
import '../../controllers/screencontroller/urllaunch_controller.dart';
import 'drawer_screen.dart';
import 'floatingbutton_screen.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final authController=Get.find<AuthController>();
  final urlController=Get.put(UrllaunchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
         title: Text('Serve humanity. Donate blood',style: GoogleFonts.numans(
           color: Colors.white,
           fontWeight: FontWeight.w600,
           fontSize: 18,
         ),),
         centerTitle:false,
         leading: Builder(
           builder: (context) => IconButton(
             icon: Container(
                 height: 40,
                 width: 40,
                 decoration: BoxDecoration(
                   color: Colors.redAccent,
                   shape: BoxShape.circle,
                 ),
                 child: Icon(Icons.menu,size: 25,color: Colors.white,)),
             tooltip: "Menu",
             onPressed: () {
               Scaffold.of(context).openDrawer();
             },
           ),
         ),
         scrolledUnderElevation: 0,
         elevation: 0,
         backgroundColor: Colors.red,
       ),
       drawer: DrawerScreen(),
        floatingActionButton:FloatingbuttonScreen(),
       body:SizedBox(
         height: double.infinity,
         width: double.infinity,
         child: Stack(
           clipBehavior: Clip.none,
           children: [
             const SizedBox(
               height: 300,
              width: double.infinity,
             ),
             Container(
               width: double.infinity,
               height: 50,
               decoration: BoxDecoration(
                 boxShadow: [
                 BoxShadow(
                   color: Colors.red.withOpacity(0.3),
                   blurRadius: 10,
                   offset: Offset(0, 4),
                   spreadRadius: 1,
                 ),
               ],
                 color: Colors.red,
                 borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(100),
                   bottomRight: Radius.circular(100),
                 ),
               ),
             ),
             Positioned(
               top: 0,
               left: 20,
               right: 20,
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(top:15,left: 20,right: 20),
                     child: Container(
                       height: 50,
                       width: double.infinity,
                       decoration: BoxDecoration(
                         color: Colors.white,
                         border: Border.all(color: Colors.red[900]!,width: 2),
                         borderRadius: BorderRadius.circular(40),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.white.withOpacity(0.3),
                             blurRadius: 10,
                             offset: Offset(0, 4),
                               spreadRadius: 1,
                           ),
                         ]
                       ),
                       child: TextField(
                         controller: authController.mySearch,
                         onChanged: (value)=>authController.onSearchChanged(value),
                         style: GoogleFonts.numans(
                           color: Colors.black,
                           fontSize: 16,
                           fontWeight: FontWeight.w500,
                         ),
                         decoration: InputDecoration(
                           contentPadding: EdgeInsets.only(top: 9),
                           border: InputBorder.none,
                            prefixIcon: Icon(Icons.bloodtype_outlined,color: Colors.red,),
                           hintText: 'Search blood group or location...',
                           hintStyle: GoogleFonts.numans(
                             color: Colors.black,
                             fontSize: 12,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
             Positioned(
               top: 80,
               left: 20,
               right: 20,
               child: Padding(
                 padding: const EdgeInsets.only(left: 7,right: 7),
                 child: Container(
                   height: 100,
                   width: double.infinity,
                   decoration: BoxDecoration(
                     color: Colors.grey.shade200,
                     borderRadius: BorderRadius.circular(10),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.red.withOpacity(0.08),
                         blurRadius: 10,
                         offset: Offset(0, 4),
                         spreadRadius: 1,
                       ),
                     ],
                   ),
                   child: Padding(
                     padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Row(
                          children: [
                            Text('Emergency request',style: GoogleFonts.numans(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),),
                            const SizedBox(width: 10,),
                            Icon(Icons.warning_amber,color: Colors.red,size: 20,),
                            const Spacer(),
                            GestureDetector(
                              onTap: ()=>Get.to(()=>SeeallScreen(),duration: Duration(milliseconds: 700)),
                              child: Hero(
                                tag: '',
                                child: Container(
                                  height: 26,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Center(
                                    child: Text('SEE ALL',style: GoogleFonts.numans(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                         //live right to left heading
                         const SizedBox(height: 8),
                         Expanded(
                           child: Marquee(
                             text: '** 🚨 Every day we receive over 100 blood requests. We hope to deliver life-saving blood to everyone in need. Be a hero, donate today ! **',
                             style: GoogleFonts.numans(
                               color: Colors.red.shade700,
                               fontSize: 13,
                               fontWeight: FontWeight.w600,
                             ),
                             scrollAxis: Axis.horizontal,
                             blankSpace: 50.0,
                             velocity: 45.0,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
             Positioned(
               top: 200,
               left: 26,
               right: 26,
                 bottom: 0,
                 child:Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('Recent blood donor',style: GoogleFonts.numans(
                       color: Colors.black,
                       fontSize: 15,
                       fontWeight: FontWeight.w600,

                     ),),
                     const SizedBox(height: 10,),
                     Expanded(
                       child: Obx((){
                         String currentQuery = authController.searchQuery.value;
                         return StreamBuilder<QuerySnapshot>(
                           stream: FirebaseFirestore.instance
                               .collection('blood_requests')
                               .where('type', isEqualTo: 'donor_volunteer')
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
                                 child: Text('No donor found !',style: GoogleFonts.numans(
                                   color: Colors.black,
                                   fontSize: 18,
                                   fontWeight: FontWeight.w600,
                                 ),),
                               );
                             }

                             var allDocs = snapshot.data!.docs;
                             var filteredDocs = allDocs.where((doc) {
                               var data = doc.data() as Map<String, dynamic>;
                               String blood = (data['bloodGroup'] ?? '').toString().toLowerCase();
                               String loc = (data['location'] ?? '').toString().toLowerCase();
                               String query = authController.searchQuery.value;

                               return blood.contains(query) || loc.contains(query);
                             }).toList();
                             if (filteredDocs.isEmpty) {
                               return Center(
                                 child: Text(
                                   'Not found for "$currentQuery"',
                                   style: GoogleFonts.numans(
                                     color: Colors.black,
                                     fontSize: 18,
                                     fontWeight: FontWeight.w600,
                                   ),),
                               );
                             }

                             //var requests = snapshot.data!.docs;
                             return  ListView.builder(
                                 physics: const BouncingScrollPhysics(),
                                 scrollDirection: Axis.vertical,
                                 itemCount: filteredDocs.length,
                                 itemBuilder: (context,index){
                                   var data = filteredDocs[index].data() as Map<String, dynamic>;
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
                                       child: Center(
                                         child: ListTile(
                                           leading:Container(
                                             height: 50, width: 50,
                                             decoration: BoxDecoration(
                                               shape: BoxShape.circle,
                                               image: data['profileImage'] != null
                                                   ? DecorationImage(
                                                   image: NetworkImage(data['profileImage']),
                                                   fit: BoxFit.cover)
                                                   : null,
                                             ),
                                             child: data['profileImage'] == null
                                                 ? const Icon(Icons.account_circle, size: 50,
                                                 color: Colors.grey)
                                                 : null,
                                           ),
                                           title: Text(data['username'] ?? 'Anonymous',
                                             overflow: TextOverflow.ellipsis,
                                             maxLines: 1,
                                             style: GoogleFonts.numans(
                                                 fontSize: 14,
                                                 fontWeight: FontWeight.w600,
                                                 color: Colors.black
                                             ),),
                                           subtitle:Text('Blood group: ${data['bloodGroup'] ?? 'N/A'}',
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
                                                   if (data['phoneNumber'] != null) {
                                                     urlController.makeCall(data['phoneNumber']);
                                                   } else {
                                                     Get.snackbar('Error', 'Phone number not provided');
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
                                               Text(data['location'] ?? 'Unknown',
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
                           },
                         );
                       }),
                     ),
                   ],
                 ),
             ),
           ],
         ),
       )
    );
  }
  //helper widget
  deleteDonorRequest(String requestId,String postedBy){
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          title: Center(child: Text('Delete donor request ?',style: GoogleFonts.numans(
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
