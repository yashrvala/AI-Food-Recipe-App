import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungry/views/screens/page_switcher.dart';
import 'package:hungry/views/utils/AppColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungry/views/widgets/custom_text_field.dart';
import 'package:hungry/views/widgets/modals/login_modal.dart';

class RegisterModal extends StatelessWidget {

  final TextEditingController _emaillController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _UsernameController = TextEditingController();
  final TextEditingController _RepasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 85 / 100,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            physics: BouncingScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 35 / 100,
                  margin: EdgeInsets.only(bottom: 20),
                  height: 6,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
                ),
              ),
              // header
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Text(
                  'Get Started',
                  style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'inter'),
                ),
              ),
              // Form
              CustomTextField(title: 'Email', hint: 'youremail@email.com',margin: EdgeInsets.zero,controller: _emaillController,),
              CustomTextField(title: 'Full Name', hint: 'Your Full Name', margin: EdgeInsets.only(top: 16),controller: _UsernameController),
              CustomTextField(title: 'Password', hint: '**********', obsecureText: true, margin: EdgeInsets.only(top: 16),controller: _PasswordController),
              CustomTextField(title: 'Retype Password', hint: '**********', obsecureText: true, margin: EdgeInsets.only(top: 16),controller: _RepasswordController),
              // Register Button
              Container(
                margin: EdgeInsets.only(top: 32, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emaillController.text.trim(),
                        password: _PasswordController.text.trim()).then((value) async {


                      await value.user!.updateDisplayName(_UsernameController.text.trim());
                      await value.user!.reload();


                      await FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
                        'email': value.user!.email,
                        'fullName': _UsernameController.text.trim(),
                        'subscription': 'Premium',
                        'createdAt': FieldValue.serverTimestamp(),
                      });


                      print("UserCreated : ");
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => PageSwitcher()),
                      );
                    }).onError((error,stackTrace) {
                      print("Error ${error.toString()} ");
                    }
                    );

                    // Navigator.of(context).pop();
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PageSwitcher()));
                  },
                  child: Text('Register', style: TextStyle(color: AppColor.secondary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'inter')),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    // primary: AppColor.primarySoft,
                    backgroundColor: AppColor.primarySoft,
                  ),
                ),
              ),
              // Login textbutton
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    isScrollControlled: true,
                    builder: (context) {
                      return LoginModal();
                    },
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  // primary: Colors.white,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Have an account? ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter',
                          ),
                          text: 'Log in')
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
