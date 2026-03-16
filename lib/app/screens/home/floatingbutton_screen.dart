import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../controllers/firebase_controller/auth_controller.dart';
import '../../controllers/screencontroller/selection_controller.dart';


class FloatingbuttonScreen extends StatelessWidget {
  FloatingbuttonScreen({super.key});
  final authController=Get.find<AuthController>();
  final selectionController=Get.put(SelectionController());
  @override
  Widget build(BuildContext context) {
    return Obx((){
      String state=selectionController.fabState.value;
      return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child,Animation<double>animation){
         return ScaleTransition(scale:animation,child: child,);
        },
        child: fabState(state),
      );
    });
  }

 //helper widget
fabState(String state){
 if(state=='loading'){
   return FloatingActionButton(
     key: const ValueKey('loading'),
     onPressed: (){},
   backgroundColor: Colors.white,
     child: const CircularProgressIndicator(
       color: Colors.red,
     ),
   );
 }else if(state=='success'){
   return FloatingActionButton(
       key:const ValueKey('success'),
       onPressed: (){
       },
   backgroundColor: Colors.white,
     child: TweenAnimationBuilder(tween: Tween(begin: 0.0,end: 1.0),
         duration:const Duration(milliseconds: 200),
       curve: Curves.elasticOut,
       builder: (context,scale,child){
       return Transform.scale(
         scale: scale,
         child: Container(
           height: 40,
           width: 40,
           decoration: BoxDecoration(
             color: Colors.green,
             shape: BoxShape.circle,
           ),
           child: const Icon(Icons.check,color: Colors.white,size: 28,),
         ),
       );
       },
     ),
   );
 }else{
   return FloatingActionButton.extended(
     key: ValueKey('normal'),
       onPressed: (){
       //simple animation
       selectionController.onDonateClicked();
       //upload donor blood route
       Future.delayed(Duration(seconds: 3),(){
         authController.donateNowRequest();
       });
       },
     label: Text(
       'Donate now',style: GoogleFonts.numans(
       color: Colors.white,
       fontSize: 16,
       fontWeight: FontWeight.w500,
     ),
     ),
     backgroundColor: Colors.red,
     isExtended: true,
     icon:const Icon(Icons.add, color: Colors.white, size: 20),
   );
 }
}


}
