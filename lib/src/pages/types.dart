import 'package:flutter/material.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:music_instruments/src/pages/detail.dart';
import 'package:screensize_utils/screensize_util.dart';

import '../widgets/background.dart';

class TypesScreen extends StatefulWidget {
  const TypesScreen({super.key});

  @override
  State<TypesScreen> createState() => _TypesScreenState();
}

class _TypesScreenState extends State<TypesScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundApp(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GridView.count(
          padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 63.w),
          crossAxisCount: 3,
          mainAxisSpacing: 30.w,
          childAspectRatio: 0.97,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: List.generate(
            20,
            (index) {
              return InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailScreen(),
                    )),
                child: Column(
                  children: [
                    Container(
                      width: 215.w,
                      height: 146.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppTheme.border),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: 215.h,
                      child: Text(
                        'O‘zbek cholg‘ulari tarixi',
                        style: TextStyle(fontSize: 24.sp, fontFamily: 'Inter'),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
