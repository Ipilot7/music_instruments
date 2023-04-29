import 'package:flutter/material.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:music_instruments/src/widgets/background.dart';
import 'package:screensize_utils/screensize_util.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundApp(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Container(
                width: 293.w,
                height: 198.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/images/def_image.png'),
                      fit: BoxFit.scaleDown),
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: AppTheme.linearGradient,
                ),
              ),
              SizedBox(height: 43.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.w),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. Curabitur pellentesque nibh nibh, at maximus ante fermentum sit amet. Pellentesque commodo lacus at sodales sodales. Quisque sagittis orci ut diam condimentum, vel',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
