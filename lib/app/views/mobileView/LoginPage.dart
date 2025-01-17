import 'package:ecommerce_app/app/controllers/RegisterLoginController.dart';
import 'package:ecommerce_app/app/views/mobileView/RegistrationPage.dart';
import 'package:entry/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthenticationController authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Center(
              child: Text('Login', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Image.asset('assets/icons/login.gif', height:MediaQuery.of(context).size.height * 0.25,),
            ),
            const SizedBox(height: 20,),
            Entry.all(
              duration: const Duration(seconds: 1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              hintText: 'Username/Email',
                              prefixIcon: Icon(Icons.account_circle_outlined)
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock)
                          ),
                        ),
                        const SizedBox(height: 15,),
                        ElevatedButton(
                          onPressed: (){
                            authenticationController.login(
                                emailController.text,
                                passwordController.text
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: const Size(double.infinity, 50)
                          ),
                            child: const Text('Login', style: TextStyle(fontSize: 21),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: (){},
                    icon:Icon(Icons.facebook,size: 40,),
                ),
                IconButton(
                    onPressed: (){},
                    icon:Icon(Icons.g_mobiledata_outlined,size: 40)
                ),
                IconButton(
                    onPressed: (){},
                    icon:Icon(Icons.android,size: 40)
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Create Account,'),
                TextButton(onPressed: (){
                  Get.to(()=>RegistrationPage());
                },
                    child: const Text('Click here')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
