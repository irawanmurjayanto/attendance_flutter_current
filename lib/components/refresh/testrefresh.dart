import 'package:flutter/cupertino.dart';

class TestRefesh extends StatelessWidget {
  const TestRefesh({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5),
    child: TestX(),
    );
  }

  Widget TestX() {
    return Container(
      child: Text("Test X"),
    );
  }
}