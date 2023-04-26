import 'package:flutter/material.dart';
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
            const SizedBox(height: 20),
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: AppTheme.border),
                      color: AppTheme.background,
                      shape: BoxShape.circle),
                  child: Text(
                    'i',
                    style: AppTheme.body18w4,
                  )),
            ),
            Center(
              child: Transform.rotate(
                angle: -0.2,
                child: Text('Laerning\n   Curve', style: AppTheme.body50w6),
              ),
            ),
            Positioned(
              bottom: 77.h,
              right: 109.w,
              child: GestureDetector(
                onTap: () => pushTo(const CatalogPage(), context),
                child: Container(
                    height: 57.h,
                    width: 133.w,
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
