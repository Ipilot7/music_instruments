import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:music_instruments/src/helpers/utils.dart';
import 'package:music_instruments/src/pages/catalog.dart';
import 'package:screensize_utils/screensize_util.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 40.h,
              left: 20.w,
              child: Container(
                  width: 36.w,
                  height: 36.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.w, color: AppTheme.border),
                      color: AppTheme.background,
                      shape: BoxShape.circle),
                  child: Text(
                    'i',
                    style: AppTheme.body18w4,
                  )),
            ),
            Align(
              alignment: Alignment(0.1,-0.4),
              child: Transform.rotate(
                angle: -0.2,
                child: Text('Laerning\n   Curve', style: AppTheme.body50w6),
              ),
            ),
            Positioned(
              bottom: 77.h,
              right: 109.w,
              child: GestureDetector(
                onTap: () async{
                  bool result = await InternetConnectionChecker().hasConnection;
                  if(result == true) {
                    pushTo(const CatalogPage(), context);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Internet bilan a'loqa mavjud emas!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black38,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }

                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 31.w, vertical: 3.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 2, color: AppTheme.border),
                      color: AppTheme.background,
                    ),
                    child: Text(
                      'PLAY',
                      style: AppTheme.body48w4,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
