import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:screensize_utils/screensize_util.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.5, sigmaY: 12.5),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              // Container(
              //             width: 215 . w,
              //             height: 146 . h,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(12 . o),
              //                 color: AppTheme.border),
              //           ),
              Container(
                alignment: Alignment.center,
                // margin: EdgeInsets.symmetric(horizontal: 30 . w),
                height: 150.h,
                child: ListView.separated(
                    separatorBuilder: (_, index) => SizedBox(width: 20.w),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (_, index) => Container(
                          width: 210.w,
                          height: 146.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppTheme.border),
                        )),
              ),
              SizedBox(height: 55.h),
              Container(
                alignment: Alignment.center,
                // margin: EdgeInsets.symmetric(horizontal: 30 . w),
                height: 130.h,
                child: ListView.separated(
                    separatorBuilder: (_, index) => SizedBox(width: 20.w),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (_, index) => Column(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: AppTheme.border),
                            ),
                            SizedBox(height: 6.h),
                            const Text(
                              'O‘zbek cholg‘ulari tarixi',
                            )
                          ],
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
