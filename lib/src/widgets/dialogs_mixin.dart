import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:music_instruments/src/helpers/utils.dart';
import 'package:screensize_utils/screensize_util.dart';

mixin Dialogs {
  showDialogCategory(BuildContext context) {
    return showDialog(
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
                  child: SvgPicture.asset('assets/icons/add.svg'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2.w, color: AppTheme.border),
                            borderRadius: BorderRadius.circular(8.r)),
                        hintText: 'Nomi',
                        hintStyle: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: AppTheme.border),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2.w, color: AppTheme.border),
                            borderRadius: BorderRadius.circular(8.r))),
                  ),
                ),
                InkWell(
                  onTap: () {
                    pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: AppTheme.linearGradient,
                        borderRadius: BorderRadius.circular(12.r)),
                    padding:
                        EdgeInsets.symmetric(vertical: 7.h, horizontal: 21.w),
                    child: Text(
                      'Saqlash',
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: AppTheme.fontFamily),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
