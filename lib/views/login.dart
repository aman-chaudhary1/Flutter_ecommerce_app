
import 'package:ecommerce_app/controllers/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key:  formKey,
          child: Column(children: [
             const SizedBox(
                  height: 120,
                ),
                  SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                      ),
                  const Text("Get started with your account"),
                  const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Email cannot be empty." : null,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email"),
                      ),
                    )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      validator: (value) => value!.length < 8
                          ? "Password should have atleast 8 characters."
                          : null,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Password"),
                      ),
                    )),
                     const SizedBox(
                  height: 10,
                ),
                Row(  mainAxisAlignment: MainAxisAlignment.end,children: [
                  TextButton(onPressed: (){
                  showDialog(context: context, builder:  (builder) {
                  return AlertDialog(
                    title:  const Text("Forget Password"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Enter you email"),
                        const SizedBox(height: 10,),
                        TextFormField (controller:  _emailController, decoration: const InputDecoration(label: Text("Email"), border: OutlineInputBorder()),),
                      ],
                    ),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);}, child: const Text("Cancel")),
                      TextButton(onPressed: ()async{
                        if(_emailController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email cannot be empty")));
                          return;
                        }
                       await AuthService().resetPassword(_emailController.text).then( (value) {
                        if(value=="Mail Sent"){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password reset link sent to your email")));
                          Navigator.pop(context);
                        }
                        else{
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value,style: const TextStyle( color:  Colors.white),), backgroundColor: Colors.red.shade400,));
                        }
                        });
                      }, child: const Text("Submit")),
                    ]

                  );
                });
                  }, child: const Text("Forget Password")),
                ],),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width * .9,
                    child: ElevatedButton(
                        onPressed: () {
                           if (formKey.currentState!.validate()) {
                              AuthService()
                              .loginWithEmail(
                                  _emailController.text, _passwordController.text)
                              .then((value) {
                            if (value == "Login Successful") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Login Successful")));
                             Navigator.restorablePushNamedAndRemoveUntil(context, "/home" , (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  value,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red.shade400,
                              ));
                            }
                          });
                        
                        }
                        },
                        style:  ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 16),
                        ))),
          
                        const SizedBox(
                  height: 10,
                ),
          
          
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have and account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/signup");
                        },
                        child: const Text("Sign Up"))
                  ],
                )
               
          ],),
        ),
      ),
    );
  }
}