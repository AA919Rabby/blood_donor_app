import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/screencontroller/selection_controller.dart';



class DarkmodeScreen extends StatelessWidget {
  DarkmodeScreen({super.key});
  final selectionController=Get.put(SelectionController());
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
        padding: const EdgeInsets.only(top:0,left: 10,right:10),
        child: Column(
          children: [
            ListTile(
              title: Text('Darkmode',style: GoogleFonts.numans(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                //color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),),
              trailing: Switch(
                activeColor: Colors.red,
                inactiveThumbColor: Colors.grey,
                value: selectionController.isDarkMode.value,
                  onChanged: (value){
                  selectionController.toggleTheme(value);
                  },
              ),
            ),
            const SizedBox(height: 7,),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Text("Enabling dark mode reduces eye strain and saves battery life, especially on OLED screens.Dark Mode is easier on your eyes, especially at night. It also helps conserve battery power on OLED and AMOLED screens, making your device last longer throughout the day.",style: GoogleFonts.numans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
