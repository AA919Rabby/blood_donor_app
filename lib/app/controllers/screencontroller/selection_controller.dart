import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SelectionController extends GetxController{

  var isDarkMode=false.obs;
  var selectedBloodGroup=''.obs;
  final List<String> bloodGroup=['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  //for animations
  var fabState='normal'.obs;

//for select blood
  void selectedGroup(String group){
    selectedBloodGroup.value=group;
  }


  //animation functions
void onDonateClicked()async{
    fabState.value='loading';
    await Future.delayed(Duration(seconds: 2));
    fabState.value='success';
    await Future.delayed(Duration(seconds: 2));
    fabState.value='normal';
}


//save the dark mode
toggleTheme(bool value)async{
    isDarkMode.value=value;
    Get.changeThemeMode(value?ThemeMode.dark:ThemeMode.light);
    final prefs=await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode',value);
}
//load the save when app starts
loadTheme()async{
    final prefs=await SharedPreferences.getInstance();
    bool savedTheme=prefs.getBool('isDarkMode')??false;
    isDarkMode.value=savedTheme;
    Get.changeThemeMode(savedTheme?ThemeMode.dark:ThemeMode.light);
}






}