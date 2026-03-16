import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../controllers/screencontroller/intro_controller.dart';


class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});
  final introController=Get.put(IntroController());
  @override
  Widget build(BuildContext context) {
    introController.checkUser();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.8,
                colors: [
                  Color(0xFFFF5252),
                  Color(0xFF8B0000),
                  Color(0xFF4A0000),
                ],
              ),
            ),
          ),

          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/images/logo.png',
              repeat: ImageRepeat.repeat,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 180,
                  ),
                ),
                const SizedBox(height: 24),
                   Text(
                  "Rokto Bondhon",
                  style: GoogleFonts.numans(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(8.0, 5.0),
                      ),
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.black.withOpacity(0.3),

                        offset: const Offset(15.0, 8.0),
                      ),
                    ],
                  ),
                ),
                 Text(
                  "Every drop counts",
                  style: GoogleFonts.numans(
                    color: Colors.white70,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
              right: 0,
              left: 0,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.redAccent,
                  trackGap: 2.0,
                ),
              ),
          ),
        ],
      ),
    );
  }
}
