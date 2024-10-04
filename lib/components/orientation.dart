import 'package:flutter/services.dart';

void getPortraitCentral() async{
await SystemChrome.setPreferredOrientations([
DeviceOrientation.portraitDown,
DeviceOrientation.portraitUp
]);
}


void getLandscapeCentral() async{
await SystemChrome.setPreferredOrientations([
DeviceOrientation.landscapeLeft,
DeviceOrientation.landscapeRight
]);
}