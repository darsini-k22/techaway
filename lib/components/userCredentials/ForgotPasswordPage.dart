import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool errorFlag = false;
  bool successFlag = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                  context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(10), child: Text("Enter Your Email",style:TextStyle(fontSize: 17,fontWeight: FontWeight.w900,color:Colors.black)
                )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _emailController,
                    decoration:  InputDecoration(filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                    decoration:BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(style:ButtonStyle(shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),backgroundColor: MaterialStateProperty.all<Color>(Colors.green),),
                        child: const Text('Send',style:TextStyle(fontWeight: FontWeight.w700)),
                        onPressed: () {

                          FirebaseAuth.instance
                              .sendPasswordResetEmail(
                              email: _emailController.text.trim())
                              .then((value) {
                            setState(() {
                              successFlag = true;
                              errorFlag=false;
                            });
                          }).onError((error, stackTrace) {
                            setState(() {
                              errorFlag = true;
                              successFlag=false;
                            });
                          });_emailController.clear();
                        })),
                Visibility(
                  visible: errorFlag,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text("Error While Sending Email 😶. Try Again!",
                          style:TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color:Colors.red)),
                    ),
                  ),
                ),
                Visibility(
                  visible: successFlag,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "Email Sent Successfully 😄! Kindly Check You Email.",
                          style:TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color:Colors.green)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
