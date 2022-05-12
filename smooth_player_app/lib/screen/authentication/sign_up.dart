import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:smooth_player_app/api/http/authentication/signup_http.dart';
import 'package:smooth_player_app/api/model/user_model.dart';

import '../../colors.dart';
import '../home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String username = "",
      email = "",
      password = "",
      confirm_password = "",
      profile_name = "",
      birthDate = "",
      biography = "";
  String? gender = "";

  File? _image;
  bool hidePass = true;
  bool hideCPass = true;

  void _pickProfileImg() async {
    final image = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
        dialogTitle: "Select an image");
    if (image == null) return;
    PlatformFile file = image.files.first;
    setState(() {
      _image = File(file.path.toString());
    });
  }

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
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("SmoothPlayer"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: _screenWidth * 0.05,
            right: _screenWidth * 0.05,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Welcome to Smooth Player',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(alignment: Alignment.center, children: [
                  _image == null
                      ? CircleAvatar(
                          radius: 80,
                          backgroundColor: AppColors.primary,
                          child: ElevatedButton(
                            onPressed: () {
                              _pickProfileImg();
                            },
                            child: Icon(Icons.upload, size: 50),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                              elevation: 10,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(_image!),
                          child: InkWell(
                            onTap: () {
                              _pickProfileImg();
                            },
                          ),
                        )
                ]),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (value) {
                    username = value!.trim();
                  },
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    MultiValidator([
                      RequiredValidator(errorText: "Username is required!"),
                    ]);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.form,
                    hintText: "Enter your username.....",
                    enabledBorder: formBorder,
                    focusedBorder: formBorder,
                    errorBorder: formBorder,
                    focusedErrorBorder: formBorder,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (value) {
                    email = value!;
                  },
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    MultiValidator([
                      RequiredValidator(errorText: "Email is required!"),
                    ]);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.form,
                    hintText: "Enter your email.....",
                    enabledBorder: formBorder,
                    focusedBorder: formBorder,
                    errorBorder: formBorder,
                    focusedErrorBorder: formBorder,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (value) {
                    profile_name = value!;
                  },
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    MultiValidator([
                      RequiredValidator(errorText: "Profile name is required!"),
                    ]);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.form,
                    hintText: "Enter your profile name.....",
                    enabledBorder: formBorder,
                    focusedBorder: formBorder,
                    errorBorder: formBorder,
                    focusedErrorBorder: formBorder,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        password = value!;
                      },
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        MultiValidator([
                          RequiredValidator(errorText: "Password is required!"),
                        ]);
                      },
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
                SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        confirm_password = value!;
                      },
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        MultiValidator([
                          RequiredValidator(
                              errorText: "Password confirmation is required!"),
                        ]);
                      },
                      obscureText: hideCPass,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.form,
                        hintText: "Enter your password again.....",
                        enabledBorder: formBorder,
                        focusedBorder: formBorder,
                        errorBorder: formBorder,
                        focusedErrorBorder: formBorder,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          hideCPass = !hideCPass;
                        });
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: AppColors.primary,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender:",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Laila-Bold",
                      ),
                    ),
                    Row(
                      children: [
                        Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          value: "Male",
                          groupValue: gender,
                          onChanged: (String? value) => setState(() {
                            gender = value;
                          }),
                        ),
                        Text(
                          "Male",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          value: "Female",
                          groupValue: gender,
                          onChanged: (String? value) => setState(() {
                            gender = value;
                          }),
                        ),
                        Text(
                          "Female",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          value: "Other",
                          groupValue: gender,
                          onChanged: (String? value) => setState(() {
                            gender = value;
                          }),
                        ),
                        Text(
                          "Other",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Birthdate:",
                      style: TextStyle(fontSize: 17, fontFamily: "Laila-Bold"),
                    ),
                    DatePickerWidget(
                      dateFormat: "yyyy-MMMM-dd",
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      onChange: (DateTime newDate, _) {
                        String month = "${newDate.month}";
                        String day = "${newDate.day}";
                        if (int.parse(newDate.month.toString()) < 10) {
                          month = "0${newDate.month}";
                        }
                        if (int.parse(newDate.day.toString()) < 10) {
                          day = "0${newDate.day}";
                        }
                        birthDate = "${newDate.year}-$month-$day";
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  maxLines: 5,
                  onSaved: (value) {
                    biography = value!.trim();
                  },
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.form,
                    hintText: "Write about you.....",
                    enabledBorder: formBorder,
                    focusedBorder: formBorder,
                    errorBorder: formBorder,
                    focusedErrorBorder: formBorder,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_image == null) {
                      Fluttertoast.showToast(
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        msg: "Please select an image",
                      );
                    } else if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (gender == null || birthDate.isEmpty) {
                        Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          msg: "Provide gender and birthdate also.",
                        );
                        return;
                      }

                      final resData = await SignUpHttp().signUp(
                        UploadUser(
                          username: username,
                          email: email,
                          profile_name: profile_name,
                          profile_picture: _image,
                          password: password,
                          confirm_password: confirm_password,
                          biography: biography,
                          birth_date: birthDate,
                          gender: gender,
                        ),
                      );
                      if (resData["statusCode"] == 201) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          msg: resData["body"]["resM"],
                        );
                      } else {
                        Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          msg: resData["body"]["resM"],
                        );
                      }
                    } else {
                      Fluttertoast.showToast(
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        msg: "Please fill the required form",
                      );
                    }
                  },
                  child: Text(
                    "Sign Up",
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
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "login");
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}