import 'package:flutter/material.dart';

import '../widget/navigator.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Library Page"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PageNavigator(pageIndex: 2),
    );
  }
}