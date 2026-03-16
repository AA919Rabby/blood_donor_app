import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/firebase_controller/auth_controller.dart';
import '../../controllers/screencontroller/selection_controller.dart';
import '../../widgets/custom_Auth.dart';


class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final authController = Get.put(AuthController());
  final selectionController = Get.put(SelectionController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  if (authController.editImageKey.currentState!.validate()) {
                    authController.editProfile();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20),
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        'Save',
                        style: GoogleFonts.numans(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Form(
                  key: authController.editImageKey,
                  child: Column(
                    children: [
                      //add image section
                      InkWell(
                        onTap: () =>
                            authController.pickImage(ImageSource.gallery),
                        child: Obx(() {
                          //Check for local selected image first, then network image
                          ImageProvider? displayImage;
                          if (authController.selectedImage.value.isNotEmpty) {
                            displayImage = FileImage(File(authController.selectedImage.value));
                          } else if (authController.userData['profileImage'] != null && authController.userData['profileImage'] != "") {
                            displayImage = NetworkImage(authController.userData['profileImage']);
                          }

                          return Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              image: displayImage != null
                                  ? DecorationImage(
                                  image: displayImage,
                                  fit: BoxFit.cover)
                                  : null,
                              border: Border.all(
                                  color: Colors.red[800]!, width: 2),
                            ),
                            child: displayImage == null
                                ? Center(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                        Icons.add_to_photos_rounded,
                                        color: Colors.white,
                                        size: 60),
                                    Text('Add image',
                                        style: GoogleFonts.numans(
                                            color: Colors.white)),
                                  ],
                                ))
                                : null,
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomAuth(
                          controller: authController.editLocation,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your location';
                            }
                            return null;
                          },
                          labelText: 'Location',
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                          ),
                          hintText: 'Enter your location'),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomAuth(
                          controller: authController.editPhoneNumber,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your phone number';
                            }
                            if (value.length < 11) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                          labelText: 'Phone number',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          hintText: '+8801XXXXXXXXX'),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomAuth(
                              controller: authController.editWeight,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your weight';
                                }
                                if (int.parse(value) < 40) {
                                  return 'Enter a valid weight';
                                }
                                return null;
                              },
                              labelText: 'Weight',
                              prefixIcon: Icon(
                                  Icons.monitor_weight_outlined,
                                  color: Colors.black),
                              hintText: 'kg',
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomAuth(
                              controller: authController.editAge,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your age';
                                }
                                if (int.parse(value) < 16) {
                                  return 'Enter a valid age';
                                }
                                return null;
                              },
                              labelText: 'Age',
                              prefixIcon: Icon(Icons.calendar_month,
                                  color: Colors.black),
                              hintText: '11/11/2000',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Pick your blood ',
                          style: GoogleFonts.numans(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: selectionController.bloodGroup.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 2,
                          ),
                          itemBuilder: (context, index) {
                            return Obx(() {
                              bool isSelected = selectionController
                                  .selectedBloodGroup.value ==
                                  selectionController.bloodGroup[index];
                              return InkWell(
                                onTap: () {
                                  selectionController.selectedGroup(
                                      selectionController.bloodGroup[index]);
                                },
                                child: AnimatedContainer(
                                  duration:
                                  const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.red
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.white,
                                        width: 1),
                                    boxShadow: isSelected
                                        ? [
                                      BoxShadow(
                                          color: Colors.red
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4))
                                    ]
                                        : [],
                                  ),
                                  child: Center(
                                    child: Text(
                                      selectionController.bloodGroup[index],
                                      style: GoogleFonts.numans(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // Loading Overlay
        if (authController.isLoading.value)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.red),
            ),
          ),
      ],
    ));
  }
}