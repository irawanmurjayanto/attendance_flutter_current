import 'package:flutter/services.dart';

void getPortraitCentral() async{
await SystemChrome.setPreferredOrientations([
DeviceOrientation.portraitDown,
DeviceOrientation.portraitUp
]);
}