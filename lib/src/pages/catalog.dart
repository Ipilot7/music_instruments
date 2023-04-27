import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:music_instruments/src/widgets/background.dart';
import 'package:screensize_utils/screensize_util.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return BackgroundApp(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                3,
                (index) => GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            backgroundColor: AppTheme.dialog,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 100.h,
                                  height: 100.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      gradient: AppTheme.linearGradient),
                                  child:
                                      SvgPicture.asset('assets/icons/add.svg'),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2.w,
                                                color: AppTheme.border),
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                        hintText: 'Nomi',
                                        hintStyle: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            color: AppTheme.border),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2.w,
                                                color: AppTheme.border),
                                            borderRadius:
                                                BorderRadius.circular(8.r))),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: AppTheme.linearGradient,
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7.h, horizontal: 21.w),
                                  child: Text(
                                    'Saqlash',
                                    style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontFamily: AppTheme.fontFamily),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: 215.w,
                    height: 146.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppTheme.border),
                  ),
                ),
              ),
            ),
            SizedBox(height: 55.h),
            Container(
              alignment: Alignment.center,
              // margin: EdgeInsets.symmetric(horizontal: 30 . w),
              height: 150.h,
              child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 21.w),
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (_, index) => SizedBox(width: 20.w),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          // pushTo(const TypesScreen(), context);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100.h,
                              height: 100.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: AppTheme.border),
                            ),
                            SizedBox(height: 6.h),
                            SizedBox(
                              width: 100.h,
                              child: Text(
                                'O‘zbek cholg‘ulari tarixi',
                                style: TextStyle(
                                    fontSize: 14.sp, fontFamily: 'Inter'),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
