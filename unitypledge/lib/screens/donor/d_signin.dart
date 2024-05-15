import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/providers/auth_provider.dart';
import 'package:unitypledge/screens/donor/d_signup.dart';
import 'package:unitypledge/screens/widgets/drawer.dart';

// class SignInPage1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign In/Sign Up'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(height: 20.0),
//             Container(
//               margin: EdgeInsets.only(bottom: 20.0),
//               child: Column(children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(300),
//                   child: Image.asset(
//                     './images/unitypledge_logo.png',
//                     width: 250,
//                     height: 250,
//                   ),
//                 ),
//                 Text(
//                   "Welcome back, ",
//                   style: TextStyle(fontSize: 30.0),
//                 ),
//                 Text("Join the Pledge, Ignite Unity."),
//               ]),
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             SizedBox(height: 20.0),
//             TextField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//               ),
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement sign-in logic here
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => DonorPage()),
//                 );
//               },
//               child: Text('Sign In'),
//             ),
//             SizedBox(height: 20.0),
//             GestureDetector(
//               onTap: () {
//                 // Navigate to sign-up page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignUpPage()),
//                 );
//               },
//               child:
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 Text('Don\'t have an account? '),
//                 Text(
//                   'Sign up',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: Colors.blue,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

///////////////////////////
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool showSignInErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading,
                  logo,
                  const Text("Welcome back, ",
                      style: TextStyle(fontSize: 30.0)),
                  const Text("Join the Pledge, Ignite Unity."),
                  emailField,
                  passwordField,
                  showSignInErrorMessage ? signInErrorMessage : Container(),
                  submitButton,
                  signUpButton
                ],
              ),
            )),
      ),
    );
  }

  Widget get logo => ClipRRect(
        borderRadius: BorderRadius.circular(300),
        child: Image.asset(
          './images/unitypledge_logo.png',
          width: 250,
          height: 250,
        ),
      );

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Sign In",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Email"),
              hintText: "juandelacruz09@gmail.com"),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your email";
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Password"),
              hintText: "******"),
          obscureText: true,
          onSaved: (value) => setState(() => password = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your password";
            }
            return null;
          },
        ),
      );

  Widget get signInErrorMessage => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Invalid email or password",
          style: TextStyle(color: Colors.red),
        ),
      );

  Widget get submitButton => ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          String? message = await context
              .read<UserAuthProvider>()
              .authService
              .signIn(email!, password!);

          print(message);
          print(showSignInErrorMessage);

          setState(() {
            if (message != null && message.isNotEmpty) {
              showSignInErrorMessage = true;
            } else {
              showSignInErrorMessage = false;
            }
          }

          );
        }
      },
      child: const Text("Sign In"));

  Widget get signUpButton => Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("No account yet?"),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: const Text("Sign Up"))
          ],
        ),
      );
}
