
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
       // TO DO: implement initState 
    _email = TextEditingController();       // must initialise final vars
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
      // TO DO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
          
          switch(snapshot.connectionState){

            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: " Enter your email here..."
                      ),
                    ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: " Enter your password here..."
                      ),
                    ),
                  TextButton(
                    onPressed: () async {
                      
                      final email = _email.text;
                      final password = _password.text;
                      try{
                      final userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email, 
                        password: password);
                        print(userCredentials);
                    }
                    on FirebaseAuthException catch(e){
                      print(e.code);
                    } 
                    },
                    child: const Text('Register')
                    ),
                    TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login/', 
                        (route) => false);
                    },
                    child: const Text('Already registered? Login here!'),
                    )
                ],
              );
            default:
              return const CircularProgressIndicator();
          }   
        },
        future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,)     
      ),
    );
  }
}

