import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_tickets_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../services/auth.dart';

class LoginScreen extends StatefulWidget {
  final Function togggleView;
  const LoginScreen({Key? key, required this.togggleView}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  String _errorMessage = '';
  var _key = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  void _handleSubmit() async {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState?.save();
      setState(() {
        loading = true;
      });
      var snackBar;

      dynamic result = await _auth.signIn(email, password);
      if(result == 'wrongpass'){
        snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
                title: 'Error!',
                message: "Wrong password, please check again!",
                contentType: ContentType.failure));
        setState(() {
          loading = false;
        });
      }
      else if(result == 'usernotfound'){
        snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
                title: 'Error!',
                message: "$email is not registered, please sign up and try again!",
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
    }
  }

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  'Welcome',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (v) {
                    email = v ?? '';
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please enter your email';
                    }
                    else if(EmailValidator.validate(v) == false)
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (v) {
                    password = v ?? '';
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
                      return ("Password should contain upper, lower,digit, and special character");
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
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(55)),
                  onPressed: _handleSubmit,
                  child: Text('Login'),
                ),
                SizedBox(
                  height: 25,
                ),
                Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    children: [
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {
                            widget.togggleView();
                          },
                          child: Text(
                            "Register here",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
