import 'package:get/get.dart';
import '../../screens/auths/login.dart';
import '../../screens/home/home_screen.dart';
import '../firebase_controller/auth_controller.dart';


class IntroController extends GetxController{
final authController=Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();
    checkUser();
  }

    checkUser()async {
      Future.delayed(Duration(seconds: 3), () {
        if(authController.auth.currentUser!=null){
          Get.offAll(()=>HomeScreen());
        }else{
          Get.offAll(()=>Login());
        }
      });
    }



}