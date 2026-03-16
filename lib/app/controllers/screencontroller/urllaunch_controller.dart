import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';


class UrllaunchController extends GetxController{

 //handle the uri parsing
    launch(Uri url)async{
    try{
      if(!await launchUrl(url,mode:LaunchMode.externalApplication )){
        Get.snackbar('Error', 'Could not launch $url');
      }
    }catch(e){
      Get.snackbar('Error', "$e");
    }
  }

//phone call
makeCall(String phoneNumber)async{
      final Uri launchUri=Uri(
        scheme: 'tel',
        path: phoneNumber
      );
      await launch(launchUri);
}

//email
sendEmail(String email)async{
      final Uri launchUri=Uri(
        scheme: 'mailto',
        path: email,
      );
      await launch(launchUri);
}


}