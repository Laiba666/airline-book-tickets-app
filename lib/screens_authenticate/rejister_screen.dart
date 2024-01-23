import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_tickets_app/shared/loading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  const RegisterScreen({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  String _passwordValue = '';
  final AuthService _auth = AuthService();
  bool loading = false;

  final _key = GlobalKey<FormState>();


  void _handleSubmit() async {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState?.save();
      setState(() {
        loading = true;
      });
      dynamic result = await _auth.register(email, password);
      var snackBar;
      if(result == '$email is already in use'){
        snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
                title: 'Error!',
                message: "$email is already in use, please use a different email!",
                contentType: ContentType.failure));
        setState(() {
          loading = false;
        });
      }
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      _key.currentState?.reset();
      FocusManager.instance.primaryFocus?.unfocus();

    } else {
      final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
              title: 'Error!',
              message: "Invalid form",
              contentType: ContentType.failure));
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      print('Invalid form');
    }
  }

  String fullname = '';
  String username = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Registration',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: fullname,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (v) {
                    fullname = v ?? '';
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty || v.length < 3) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Full name",
                    hintText: "Your full name",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: username,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (v) {
                    username = v ?? '';
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty || v.length < 3) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Your username",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (v) {
                    email = v ?? '';
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please enter your email';
                    } else if(EmailValidator.validate(v) == false)
                    {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Your email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: '+84',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (v) {
                    phoneNumber = v ?? '';
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty || v.length < 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    hintText: "Your phone number",
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (v) {
                    password = v ?? '';
                    _passwordValue = password;
                  },
                  onChanged: (v) {
                    setState(() {
                      _passwordValue = v;
                    });
                  },
                  validator: (v) {
                    RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    var passNonNullValue = v ?? "";
                    if (passNonNullValue.isEmpty) {
                      return ("Password is required");
                    } else if (passNonNullValue.length < 6) {
                      return ("Password Must be more than 5 characters");
                    } else if (!regex.hasMatch(passNonNullValue)) {
                      return ("Password should contain upper, lower, digit, and special character");
                    }
                    return null;
                  },
                  obscureText: _isObscure,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (v) {
                    confirmPassword = v ?? '';
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return ("Please confirm your password");
                    } else if (v != _passwordValue) {
                      return ("Passwords do not match");
                    }
                    return null;
                  },
                  obscureText: _isObscureConfirm,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    hintText: "Confirm Password",
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscureConfirm = !_isObscureConfirm;
                          });
                        },
                        icon: Icon(_isObscureConfirm
                            ? Icons.visibility
                            : Icons.visibility_off)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(55)),
                  onPressed: _handleSubmit,
                  child: Text('Sign Up'),
                ),
                SizedBox(
                  height: 30,
                ),
                Text.rich(
                    TextSpan(
                        text: "Already have an account? ",
                        children: [
                          WidgetSpan(
                              child: InkWell(
                                onTap: () {
                                  widget.toggleView();
                                },
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ))
                        ]
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
