import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';

import 'package:music_instruments/src/helpers/data/user_model.dart';

import 'package:music_instruments/src/pages/detail.dart';
import 'package:screensize_utils/screensize_util.dart';

import '../widgets/background.dart';

class TypesScreen extends StatefulWidget {
  const TypesScreen({super.key, required this.subCategoryId});

  final int subCategoryId;

  @override
  State<TypesScreen> createState() => _TypesScreenState();
}

class _TypesScreenState extends State<TypesScreen> {
  bool isMusic = false;
  @override
  Widget build(BuildContext context) {
    return BackgroundApp(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimationLimiter(
          child: GridView.builder(
            itemCount: subCategoryList[widget.subCategoryId].items.length,
            padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 63.w),
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 600),
                columnCount: 3,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
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
                                gradient: AppTheme.linearGradient,
                                borderRadius: BorderRadius.circular(12.r),
                                color: AppTheme.border),
                            child: Image.asset(
                                subCategoryList[widget.subCategoryId]
                                    .items[index]
                                    .image),
                          ),
                          SizedBox(height: 24.h),
                          SizedBox(
                            width: 215.h,
                            child: Text(
                              subCategoryList[widget.subCategoryId]
                                  .items[index]
                                  .title,
                              style: TextStyle(
                                  fontSize: 24.sp, fontFamily: 'Inter'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 30.w,
              childAspectRatio: 0.97,
            ),
            // shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
