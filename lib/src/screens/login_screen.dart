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
    username = TextEditingController();
    password = TextEditingController();
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
              Text(
                "Tap&Tell",
                style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: username,
                        obscureText: false,
                        onEditingComplete: usernameFn.requestFocus,
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Username is required"),
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
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: password,
                        obscureText: showPass,
                        onEditingComplete: () {
                          passwordFn.unfocus();
                          onSubmit();
                        },
                        keyboardType: TextInputType.visiblePassword,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Password is required"),
                          MinLengthValidator(
                            8,
                            errorText:
                                "Password must to be at least 8 characters long",
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
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 67, 106, 214),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              textStyle: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            onSubmit();
                          },
                          child: const Text('Login'),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onSubmit() async {
    if (formKey.currentState?.validate() ?? false) {
      WaitingDialog.show(context,
          future: AuthController.I
              .login(username.text.trim(), password.text.trim()));
    }
  }
}
