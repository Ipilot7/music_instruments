import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_instruments/src/pages/main_page.dart';
import 'package:screensize_utils/screensize_util.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenSizeUtilInit(
      designSize: const Size(852, 393),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MainPage(),
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!,
            );
          },
        );
      },
    );
  }
}
