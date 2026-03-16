import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as p;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../screens/auths/login.dart';
import '../../screens/home/home_screen.dart';
import '../screencontroller/selection_controller.dart';
import 'package:http/http.dart'as http;


class AuthController extends GetxController{

  final selectionController=Get.put(SelectionController());

  //register
  final registerEmail=TextEditingController();
  final registerPassword=TextEditingController();
  final registerConfirmPassword=TextEditingController();
  final registerUsername=TextEditingController();
  final registerKey=GlobalKey<FormState>();

  //login
  final loginEmail=TextEditingController();
  final loginPassword=TextEditingController();
  final loginKey=GlobalKey<FormState>();

  //image and blood selection section as registration time
  final location=TextEditingController();
  final phoneNumber=TextEditingController();
  final weight=TextEditingController();
  final age=TextEditingController();
  final bloodGroup=TextEditingController();
  final imageKey=GlobalKey<FormState>();
  //edit profile
  final editLocation=TextEditingController();
  final editPhoneNumber=TextEditingController();
  final editWeight=TextEditingController();
  final editAge=TextEditingController();
  final editBloodGroup=TextEditingController();
  final editImageKey=GlobalKey<FormState>();

//upload blood request
  final uploadBlood=TextEditingController();
  final uploadLocation=TextEditingController();
  final uploadNumber=TextEditingController();
  final bloodRequestKey=GlobalKey<FormState>();
//search by blood and location
  final mySearch=TextEditingController();


  var isLoading=false.obs;
  final auth=FirebaseAuth.instance;
  final database=FirebaseFirestore.instance;
  var selectedImage=''.obs;
  var userData={}.obs;
  var searchQuery=''.obs;



  @override
  void onInit() {
  if(auth.currentUser!=null){
    getUserData();
  }
    super.onInit();
  }





  //search filter
  onSearchChanged(String value)async{
    searchQuery.value=value.trim().toLowerCase();
  }



//donate blood request
  donateNowRequest() async {
    try {
      isLoading(true);
      String uid = auth.currentUser!.uid;
      if (userData.isEmpty || userData['isProfileComplete'] != true) {
        Get.snackbar('Profile Incomplete', 'Please complete your profile first');
        return;
      }

      String requestId = database.collection('blood_requests').doc().id;

      await database.collection('blood_requests').doc(requestId).set({
        'requestId': requestId,
        'requestedBy': uid,
        'username': userData['username'],
        'profileImage': userData['profileImage'],
        'phoneNumber': userData['phoneNumber'],
        'bloodGroup': userData['bloodGroup'],
        'location': userData['location'],
        'type': 'donor_volunteer',
        'createdAt': Timestamp.now(),
      });

      Get.snackbar(
        'Success',
        'You are now listed as a donor!',
      );
    } catch (e) {
      Get.snackbar('Error', "$e");
    } finally {
      isLoading(false);
    }
  }



  //upload blood request
  uploadBloodRequest() async {
    try {
      isLoading(true);
      String uid = auth.currentUser!.uid;

      if(userData.isEmpty){
        Get.snackbar('Error','User data not loaded');
        return ;
      }

      String requestId = database.collection('blood_requests').doc().id;

      await database.collection('blood_requests').doc(requestId).set({
        'requestId': requestId,
        'requestedBy': uid,
        'profileImage': userData['profileImage'],
        'username': userData['username'],
        'phoneNumber': uploadNumber.text.trim(),
        'bloodGroup': uploadBlood.text.trim().toUpperCase(),
        'location': uploadLocation.text.trim(),
        'status': 'pending',
        'type': 'emergency_request',
        'createdAt': FieldValue.serverTimestamp(),
      });

      uploadBlood.clear();
      uploadLocation.clear();
      uploadNumber.clear();

      Get.off(()=>HomeScreen());
      Get.snackbar('Success','Blood upload request success');
    } catch (e) {
      Get.snackbar('Error', "$e");
    } finally {
      isLoading(false);
    }
  }


  //prefill the edit
  setInitialData()async{
    editLocation.text = userData['location'] ?? '';
    editPhoneNumber.text = userData['phoneNumber'] ?? '';
    editWeight.text = userData['weight'] ?? '';
    editAge.text = userData['age'] ?? '';
    selectionController.selectedBloodGroup.value = userData['bloodGroup'] ?? '';
  }


//edit profile
  editProfile()async{
    try{
      isLoading(true);
      String uid=auth.currentUser!.uid;
      String? imageUrl;
       if(selectedImage.value.isNotEmpty && !selectedImage.value.startsWith('http')){
         imageUrl=await uploadToCloudinary();
       }else{
         imageUrl=userData['profileImage'];
       } await database.collection('users').doc(uid).update({
        'location': editLocation.text.trim(),
        'phoneNumber': editPhoneNumber.text.trim(),
        'weight': editWeight.text.trim(),
        'age': editAge.text.trim(),
        'bloodGroup': selectionController.selectedBloodGroup.value,
        'profileImage': imageUrl,
      });
       location.clear();
       phoneNumber.clear();
       weight.clear();
       age.clear();
       selectedImage.value='';
       selectionController.selectedBloodGroup.value='';
       Get.off(()=>HomeScreen());
      ScaffoldMessenger.of(Get.context!).showSnackBar(
         SnackBar(
          content: Text('Profile updated successfully',style: GoogleFonts.numans(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      editLocation.clear();
      editPhoneNumber.clear();
      editWeight.clear();
      editAge.clear();
      selectedImage.value='';
      selectionController.selectedBloodGroup.value='';
     }catch(e){
      Get.snackbar('Error', "$e");
    }finally{
      isLoading(false);
    }
  }


  //fetch user profile
  getUserData()async{
   String uid=auth.currentUser!.uid;
   database.collection('users').doc(uid).snapshots().listen((event){
     if(event.exists){
       userData.value=event.data()!;
     }
   });
  }


  //upload image to cloudinary
  uploadToCloudinary()async{
    if(selectedImage.value.isEmpty){
      return null;
    }
    try{
      isLoading(true);
      //cloudinary url for image upload
      var uri=Uri.parse("https://api.cloudinary.com/v1_1/da9rpdeij/image/upload");
      //multipartrequest for both image and data
      var request=http.MultipartRequest('POST',uri);
      //add the file
      var file=await http.MultipartFile.fromPath('file',selectedImage.value,
      filename: p.basename(selectedImage.value));
      request.files.add(file);
      request.fields['upload_preset']='blood_donor';
      request.fields['cloud_name']='da9rpdeij';
      var response=await request.send();
      var responseData=await response.stream.toBytes();
      var responseString=String.fromCharCodes(responseData);
      var jsonRes=jsonDecode(responseString);
      if(response.statusCode==200){
        //image url link
        return jsonRes['secure_url'];
      }else{
       Get.snackbar('Error', jsonRes['error']['message']);
      }
    }catch(e){
      Get.snackbar('Error', "$e");
    }finally{
      isLoading(false);
    }
  }



  //pick image
  pickImage(ImageSource source)async{
    final picker=await ImagePicker().pickImage(source: source,imageQuality: 50);
    if(picker!=null){
      selectedImage.value=picker.path;
    }
  }




  //image screen section details send to firebase
  imageScreen()async{
    if(selectionController.selectedBloodGroup.value.isEmpty){
      Get.snackbar('Error','You must pick your blood group');
    }if(selectedImage.value.isEmpty){
      Get.snackbar('Error', 'You must pick an image');
    }
    try{
      isLoading(true);
      String? imageUrl=await uploadToCloudinary();
      if(imageUrl!=null){
        String uid=auth.currentUser!.uid;
        await database.collection('users').doc(uid).update({
          'location':location.text.trim(),
          'phoneNumber':phoneNumber.text.trim(),
          'weight':weight.text.trim(),
          'age':age.text.trim(),
          'bloodGroup':selectionController.selectedBloodGroup.value,
          'profileImage':imageUrl,
          'createdAt':Timestamp.now(),
          'isProfileComplete':true,
        });
      }
    }catch(e){
      Get.snackbar('Error', "$e");
    }finally{
      isLoading(false);
    }
  }






  //register with firebase
  register()async{
    try{
      isLoading(true);
      final credential=await auth.createUserWithEmailAndPassword(email:registerEmail.text.trim(),
          password: registerPassword.text.trim());
      //saving details to firebase
      if(credential.user!=null){
        await database.collection('users').doc(credential.user!.uid).set({
          'uid':credential.user!.uid,
          'username':registerUsername.text.trim(),
          'email':registerEmail.text.trim(),
          'password':registerPassword.text.trim(),
           'searchKey':registerUsername.text.trim().toLowerCase(),
          'createdAt':Timestamp.now(),
        });
      }
      await getUserData();
     Get.offAll(()=>HomeScreen());
    }on FirebaseAuthException catch(e){
      if(e.code=='email-already-in-use'){
        Get.snackbar('Error', 'This email already taken');
      }else{
        Get.snackbar('Error', e.message!);
      }
    }finally{
      isLoading(false);
    }
  }



 //login with firebase
login()async{
   try{
     isLoading(true);
     final credential=await auth.signInWithEmailAndPassword(email: loginEmail.text.trim(),
         password:loginPassword.text.trim());
     await getUserData();
     Get.offAll(()=>HomeScreen());
     Get.snackbar('Holo !','Login as ${loginEmail.text.trim()}');
   }catch(e){
     Get.snackbar('Error', "$e");
   }finally{
     isLoading(false);
   }
}

//delete blood request for both
  deleteBloodRequest(String requestId, String requestedBy) async {
    try {
      String currentUid = auth.currentUser!.uid;
      if (currentUid == requestedBy) {
        await database.collection('blood_requests').doc(requestId).delete();
        Get.back();
        Get.snackbar(
          'Success',
          'Request deleted successfully',
        );
      }
      else {
        Get.snackbar(
          'Permission Denied',
          'You can only delete your own requests',
        );
      }
      Get.back();
    } catch (e) {
      Get.snackbar('Error', '$e');
    }finally{
      isLoading(false);
    }
  }




//logout
logout()async{
    await auth.signOut();
    Get.offAll(()=>Login());
    Get.snackbar('Success', 'Logged out successfully');
}





}