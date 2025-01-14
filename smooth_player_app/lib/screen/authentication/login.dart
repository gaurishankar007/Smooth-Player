import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:smooth_player_app/resource/colors.dart';
import 'package:smooth_player_app/api/http/authentication/login_http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_player_app/screen/authentication/forget_password.dart';
import 'package:smooth_player_app/screen/authentication/sign_up.dart';
import 'package:smooth_player_app/screen/home.dart';
import '../../api/log_status.dart';
import '../admin/featured_playlist.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String usernameEmail = "", password = "";
  bool hidePass = true;
  OutlineInputBorder formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: AppColors.form,
      width: 2,
      style: BorderStyle.solid,
    ),
  );
  TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.black87,
  );
  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    final sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: sWidth * .05,
            right: sWidth * .05,
            top: sHeight * .03,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    height: 160,
                    width: 175,
                    fit: BoxFit.cover,
                    image: AssetImage("image/logo.png"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username or Email",
                      style: textStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      key: Key("username_email"),
                      onSaved: (value) {
                        usernameEmail = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "Username or Email is required!"),
                      ]),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.form,
                        hintText: "Enter your username or email.....",
                        enabledBorder: formBorder,
                        focusedBorder: formBorder,
                        errorBorder: formBorder,
                        focusedErrorBorder: formBorder,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password",
                      style: textStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          key: Key("password"),
                          onSaved: (value) {
                            password = value!.trim();
                          },
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Password is required!"),
                          ]),
                          obscureText: hidePass,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.form,
                            hintText: "Enter your password.....",
                            enabledBorder: formBorder,
                            focusedBorder: formBorder,
                            errorBorder: formBorder,
                            focusedErrorBorder: formBorder,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              hidePass = !hidePass;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: AppColors.primary,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final resData =
                          await LoginHttp().login(usernameEmail, password);
                      if (resData["statusCode"] == 202) {
                        if (resData["body"]["userData"]["admin"]) {
                          LogStatus().setToken(resData["body"]["token"],
                              resData["body"]["userData"]["admin"]);
                          LogStatus.token = resData["body"]["token"];
                          LogStatus.admin =
                              resData["body"]["userData"]["admin"];
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => FeaturedPlaylistView(),
                            ),
                            (route) => false,
                          );
                        } else {
                          LogStatus().setToken(resData["body"]["token"],
                              resData["body"]["userData"]["admin"]);
                          LogStatus.token = resData["body"]["token"];
                          LogStatus.admin =
                              resData["body"]["userData"]["admin"];
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => Home(),
                            ),
                            (route) => false,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: resData["body"]["resM"],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    }
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                    elevation: 10,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ForgetPassword()));
                  },
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                ElevatedButton(
                  key: Key("button"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => SignUp(),
                      ),
                    );
                  },
                  child: Text(
                    "Create an account",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                    elevation: 10,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
