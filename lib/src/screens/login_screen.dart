import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mad3_submission_1/src/controllers/auth_controller.dart';
import 'package:mad3_submission_1/src/dialogs/waiting_dialog.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/auth';
  static const String name = 'Login Screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController username;
  late TextEditingController password;
  late FocusNode usernameFn, passwordFn;
  late bool showPass;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
    showPass = true;
    formKey = GlobalKey<FormState>();
    usernameFn = FocusNode();
    passwordFn = FocusNode();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    usernameFn.dispose();
    passwordFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.42,
              color: Colors.lightGreen,
              child:
                  Center(child: Image.asset('assets/images/Tap & Tell-4.png')),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: username,
                            obscureText: false,
                            onEditingComplete: usernameFn.requestFocus,
                            keyboardType: TextInputType.text,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Username is required"),
                              MinLengthValidator(
                                6,
                                errorText:
                                    "Username must be at least 6 characters long",
                              ),
                              PatternValidator(
                                r'^[a-zA-Z0-9 ]+$',
                                errorText:
                                    'Username cannot contain any special characters',
                              ),
                            ]).call,
                            focusNode: usernameFn,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(width: 2),
                              ),
                              prefixIcon: const Icon(Icons.person),
                              labelText: 'Username',
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: password,
                            obscureText: showPass,
                            onEditingComplete: () {
                              passwordFn.unfocus();
                              onSubmit();
                            },
                            keyboardType: TextInputType.visiblePassword,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Password is required"),
                              MinLengthValidator(
                                8,
                                errorText:
                                    "Password must be at least 8 characters long",
                              ),
                              PatternValidator(
                                r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                                errorText:
                                    'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number',
                              ),
                            ]).call,
                            focusNode: passwordFn,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(width: 2),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                    showPass ? Iconsax.eye_slash : Iconsax.eye),
                                onPressed: () {
                                  setState(() {
                                    showPass = !showPass;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.lightGreen,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                textStyle: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                onSubmit();
                              },
                              child: const Text('Login'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSubmit() async {
    if (formKey.currentState?.validate() ?? false) {
      WaitingDialog.show(
        context,
        future:
            AuthController.I.login(username.text.trim(), password.text.trim()),
      );
    }
  }
}
