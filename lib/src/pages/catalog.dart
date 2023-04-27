import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:music_instruments/src/helpers/data/user_model.dart';
import 'package:music_instruments/src/helpers/utils.dart';
import 'package:music_instruments/src/pages/types.dart';
import 'package:music_instruments/src/widgets/background.dart';
import 'package:music_instruments/src/widgets/dialogs_mixin.dart';
import 'package:screensize_utils/screensize_util.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> with Dialogs {
  int selectedCategoryId = 0;
  bool isChange = false;

  @override
  Widget build(BuildContext context) {
    return BackgroundApp(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 20.h),
            children: [
              SizedBox(
                height: 146.h,
                child: AnimationLimiter(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 36.w),
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (_, index) => SizedBox(width: 30.w),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categoryList.length + 1,
                    itemBuilder: (_, index) {
                      if (index == categoryList.length) {
                        return InkWell(
                          overlayColor: const MaterialStatePropertyAll(
                              Colors.transparent),
                          onTap: () {
                            // showDialogCategory(context);
                          },
                          child: Container(
                            width: 215.w,
                            height: 146.h,
                            decoration: BoxDecoration(
                                gradient: AppTheme.linearGradient,
                                borderRadius: BorderRadius.circular(12.r),
                                color: AppTheme.border),
                            child: SvgPicture.asset(
                              'assets/icons/add.svg',
                              fit: BoxFit.none,
                            ),
                          ),
                        );
                      }
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: InkWell(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: selectedCategoryId != index
                                  ? () {
                                      setState(
                                          () => selectedCategoryId = index);
                                      isChange = true;
                                      Future.delayed(
                                        const Duration(milliseconds: 100),
                                        () => setState(() => isChange = false),
                                      );
                                    }
                                  : null,
                              child: Container(
                                width: 215.w,
                                height: 146.h,
                                decoration: BoxDecoration(
                                    gradient: AppTheme.linearGradient,
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: AppTheme.border),
                                child: Image.asset(
                                    categoryList[selectedCategoryId].image),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              isChange
                  ? const SizedBox()
                  : Container(
                      alignment: Alignment.center,
                      height: 150.h,
                      margin: EdgeInsets.only(top: 35.h),
                      child: AnimationLimiter(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 36.w),
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (_, index) => SizedBox(width: 20.w),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount:
                              categoryList[selectedCategoryId].items.length,
                          itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              pushTo(
                                  TypesScreen(subCategoryId: index), context);
                            },
                            child: AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100.h,
                                        height: 100.h,
                                        margin: EdgeInsets.only(bottom: 6.h),
                                        padding: EdgeInsets.all(10.h),
                                        decoration: BoxDecoration(
                                            gradient: AppTheme.linearGradient,
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            color: AppTheme.border),
                                        child: Image.asset(
                                            categoryList[selectedCategoryId]
                                                .items[index]
                                                .image),
                                      ),
                                      SizedBox(
                                        width: 100.h,
                                        child: Text(
                                          categoryList[selectedCategoryId]
                                              .items[index]
                                              .title,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'Inter',
                                          ),
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
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
