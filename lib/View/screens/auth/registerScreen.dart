// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/View/screens/auth/loginScreen.dart';
import 'package:tiktok_flutter/View/widgets/main_text_field.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/controllers/authController.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tiktok Clone",
                    style: TextStyle(
                      fontSize: 30,
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  controller.file != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(authcontroller.file!),
                          backgroundColor: Colors.transparent,
                          radius: 64,
                        )
                      : Stack(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                              backgroundColor: Colors.black,
                              radius: 64,
                            ),
                            Positioned(
                              bottom: 2,
                              left: 9,
                              child: IconButton(
                                onPressed: () {
                                  authcontroller.pickImage();
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MainTextField(
                      controller: username,
                      lable: "User Name",
                      icon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MainTextField(
                      controller: email,
                      lable: "Email",
                      icon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MainTextField(
                      controller: password,
                      lable: "Password",
                      icon: const Icon(Icons.lock),
                      isObscure: true,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      authcontroller.register(
                        username.text,
                        email.text,
                        password.text,
                        authcontroller.file,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      child: const Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already Have Account ? ",
                        style: TextStyle(fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //     builder: (context) => LoginScreen(),
                          //   ),
                          // );
                        Get.off(()=>LoginScreen());
                          
                        },
                        child: Text(
                          " Login",
                          style: TextStyle(
                            fontSize: 20,
                            color: buttonColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
