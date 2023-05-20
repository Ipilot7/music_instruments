import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:music_instruments/src/helpers/data/models.dart';
import 'package:music_instruments/src/helpers/utils.dart';
import 'package:music_instruments/src/pages/types.dart';
import 'package:music_instruments/src/widgets/background.dart';
import 'package:screensize_utils/screensize_util.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  int selectedCategoryId = 0;
  bool isChange = false;
  TextEditingController subCategoryController = TextEditingController();
  TextEditingController subCategoryRuController = TextEditingController();
  XFile? xfile;
  String imageUrl = '';
  String categoryImageUrl = '';
  List<dynamic> subCategoryList = [];

  @override
  void initState() {
    super.initState();
    // snapshot
    //     .data?.docs[selectedCategoryId]
    //     .get('image')
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundApp(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('category_model')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (selectedCategoryId != -1 &&
                  (snapshot.data?.docs.isNotEmpty ?? false)) {
                subCategoryList =
                    snapshot.data?.docs[selectedCategoryId].get('items');
              }
              return SafeArea(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 20.h),
                  children: [
                    // (snapshot.data?.size == 0)
                    //     ? const Text('Ma')
                    //     :
                    SizedBox(
                      height: 146.h,
                      child: AnimationLimiter(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 36.w),
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (_, index) => SizedBox(width: 30.w),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: (snapshot.data?.docs.length ?? 0) + 1,
                          itemBuilder: (_, index) {
                            if (categoryImageUrl.isEmpty &&
                                (snapshot.data?.docs.isNotEmpty ?? false)) {
                              categoryImageUrl =
                                  snapshot.data?.docs[0].get('image');
                            }
                            if (index == snapshot.data?.docs.length) {
                              return categoryAddWidget(index);
                            }
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: InkWell(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    onTap: selectedCategoryId != index
                                        ? () async {
                                            setState(() =>
                                                selectedCategoryId = index);
                                            isChange = true;
                                            await Future.delayed(
                                              const Duration(milliseconds: 100),
                                              () => setState(
                                                  () => isChange = false),
                                            );
                                            categoryImageUrl = snapshot
                                                .data?.docs[selectedCategoryId]
                                                .get('image');
                                            subCategoryList = snapshot
                                                .data?.docs[selectedCategoryId]
                                                .get('items');
                                          }
                                        : null,
                                    child: Container(
                                      width: 215.w,
                                      height: 146.h,
                                      decoration: BoxDecoration(
                                          gradient: AppTheme.linearGradient,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          color: AppTheme.border),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: buildCachedNetworkImage(
                                                snapshot.data?.docs[index]
                                                    .get('image'),
                                                220.w,
                                                160.h),
                                          ),
                                          Positioned(
                                            top: 10.h,
                                            right: 10.h,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                // InkWell(
                                                //     onTap: () {
                                                //       var firestore =
                                                //           FirebaseFirestore
                                                //               .instance;
                                                //       firestore
                                                //           .collection(
                                                //               'category_model')
                                                //           .doc(snapshot
                                                //               .data
                                                //               ?.docs[
                                                //                   selectedCategoryId]
                                                //               .id)
                                                //           .get()
                                                //           .then((doc) {
                                                //         if (doc.exists) {
                                                //           var data = doc.data();
                                                //           // saves the data to 'name'
                                                //           firestore
                                                //               .collection(
                                                //                   "category_model")
                                                //               .doc(snapshot
                                                //                   .data
                                                //                   ?.docs[
                                                //                       selectedCategoryId]
                                                //                   .id)
                                                //               .set(data!)
                                                //               .then({
                                                //                 firestore
                                                //                     .collection(
                                                //                         "category_model")
                                                //                     .doc(
                                                //                         '${DateTime.now().millisecondsSinceEpoch}')
                                                //                     .delete()
                                                //               } as FutureOr Function(
                                                //                   void value));
                                                //         }
                                                //       });
                                                //       snapshot
                                                //           .data
                                                //           ?.docs[
                                                //               selectedCategoryId]
                                                //           .id;
                                                //     },
                                                //     child: const Icon(
                                                //       Icons.edit,
                                                //       color: Colors.white,
                                                //     )),
                                                // SizedBox(width: 12.w),
                                                InkWell(
                                                    onTap: () {
                                                      var firestore =
                                                          FirebaseFirestore
                                                              .instance;
                                                      firestore
                                                          .collection(
                                                              "category_model")
                                                          .doc(
                                                              '${snapshot.data?.docs[index].id}')
                                                          .delete();
                                                      selectedCategoryId =
                                                          selectedCategoryId -
                                                              1;
                                                    },
                                                    child: Container(
                                                      width: 36.w,
                                                      height: 36.w,
                                                      alignment:
                                                          Alignment.center,
                                                      // padding: EdgeInsets.all(6.w),
                                                      decoration: BoxDecoration(
                                                          color: Colors.black38,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                        size: 16,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
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
                                separatorBuilder: (_, index) =>
                                    SizedBox(width: 20.w),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    (snapshot.data?.docs.isNotEmpty ?? false
                                            ? snapshot.data
                                                    ?.docs[selectedCategoryId]
                                                    .get('items')
                                                    .length ??
                                                0
                                            : 0) +
                                        1,
                                itemBuilder: (_, index) {
                                  if (snapshot.data?.docs.isNotEmpty ?? false) {
                                    if (index ==
                                        snapshot.data?.docs[selectedCategoryId]
                                            .get('items')
                                            .length) {
                                      return AnimationConfiguration
                                          .staggeredGrid(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        columnCount: 3,
                                        child: ScaleAnimation(
                                          child: FadeInAnimation(
                                            child: InkWell(
                                              overlayColor:
                                                  const MaterialStatePropertyAll(
                                                      Colors.transparent),
                                              onTap: () {
                                                showDialogSubCategory(
                                                  snapshot
                                                          .data
                                                          ?.docs[
                                                              selectedCategoryId]
                                                          .id ??
                                                      '',
                                                  index,
                                                  context,
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 100.w,
                                                    height: 100.h,
                                                    decoration: BoxDecoration(
                                                      gradient: AppTheme
                                                          .linearGradient,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                    ),
                                                    child: SvgPicture.asset(
                                                      'assets/icons/add.svg',
                                                      fit: BoxFit.none,
                                                    ),
                                                  ),
                                                  SizedBox(width: 50.h)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    if (snapshot.data?.docs[selectedCategoryId]
                                        .get('items')
                                        .isNotEmpty) {
                                      return GestureDetector(
                                        onTap: () {
                                          pushTo(
                                              TypesScreen(
                                                categoryId: selectedCategoryId,
                                                categoryImageUrl:
                                                    categoryImageUrl,
                                                subCategoryList: snapshot.data
                                                    ?.docs[selectedCategoryId]
                                                    .get('items'),
                                                subCategoryId: index,
                                                data: snapshot.data
                                                    ?.docs[selectedCategoryId]
                                                    .get(
                                                        'items')[index]['items'],
                                              ),
                                              context);
                                        },
                                        child: AnimationConfiguration
                                            .staggeredList(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          child: SlideAnimation(
                                            verticalOffset: 50.0,
                                            child: FadeInAnimation(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 100.h,
                                                    height: 100.h,
                                                    margin: EdgeInsets.only(
                                                        bottom: 6.h),
                                                    padding:
                                                        EdgeInsets.all(10.h),
                                                    decoration: BoxDecoration(
                                                        gradient: AppTheme
                                                            .linearGradient,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.r),
                                                        color: AppTheme.border),
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child:
                                                                buildCachedNetworkImage(
                                                              snapshot
                                                                      .data
                                                                      ?.docs[
                                                                          selectedCategoryId]
                                                                      .get(
                                                                          'items')[
                                                                  index]['image'],
                                                              80.w,
                                                              80.h,
                                                            )),
                                                        Positioned(
                                                          // top: 5.w,
                                                          right: 0.w,
                                                          child: InkWell(
                                                              onTap: () {
                                                                subCategoryList
                                                                    .removeAt(
                                                                        index);
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'category_model')
                                                                    .doc(snapshot
                                                                        .data
                                                                        ?.docs[
                                                                            selectedCategoryId]
                                                                        .id)
                                                                    .set(
                                                                  {
                                                                    'id':
                                                                        selectedCategoryId,
                                                                    'image':
                                                                        categoryImageUrl,
                                                                    'items':
                                                                        subCategoryList,
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                width: 36.w,
                                                                height: 36.w,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                // padding: EdgeInsets.all(6.w),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black38,
                                                                    shape: BoxShape
                                                                        .circle),
                                                                child:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 16,
                                                                ),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100.h,
                                                    child: Text(
                                                      snapshot
                                                                  .data
                                                                  ?.docs[
                                                                      selectedCategoryId]
                                                                  .get('items')[
                                                              index]['title'] ??
                                                          '',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontFamily: 'Inter',
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }

                                  return const Center();
                                },
                              ),
                            ),
                          )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget buildCachedNetworkImage(String imageUrl, double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
        progressIndicatorBuilder: (context, url, progress) => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error_outline, size: 40, color: Colors.white),
      ),
    );
  }

  InkWell categoryAddWidget(int index) {
    return InkWell(
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      onTap: () async {
        ImagePicker imagePicker = ImagePicker();
        XFile? categoryImageFile =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (categoryImageFile == null) return;
        String uniqueName = 'category$index';
        Reference refRoot = FirebaseStorage.instance.ref();
        Reference refDirImage = refRoot.child('category_images');
        Reference refImageUpload = refDirImage.child(uniqueName);
        try {
          await refImageUpload.putFile(File(categoryImageFile.path));
          categoryImageUrl = await refImageUpload.getDownloadURL();
          FirebaseFirestore.instance
              .collection('category_model')
              .doc('${DateTime.now().millisecondsSinceEpoch}')
              .set(
            {'id': index, 'image': categoryImageUrl, 'items': []},
          );
        } catch (error) {
          Fluttertoast.showToast(msg: '$error');
        }
      },
      child: Container(
        width: 215.w,
        height: 146.h,
        decoration: BoxDecoration(
          gradient: AppTheme.linearGradient,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: SvgPicture.asset(
          'assets/icons/add.svg',
          fit: BoxFit.none,
        ),
      ),
    );
  }

  showDialogSubCategory(String id, int subId, BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              backgroundColor: AppTheme.dialog,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              content: SizedBox(
                height: 250.h,
                width: 1.w,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () async {
                              ImagePicker imagePicker = ImagePicker();
                              xfile = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (xfile == null) return;
                              String uniqueName = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              Reference refRoot =
                                  FirebaseStorage.instance.ref();
                              Reference refDirImage =
                                  refRoot.child('subcategory_image');
                              Reference refImageUpload =
                                  refDirImage.child(uniqueName);
                              try {
                                await refImageUpload.putFile(File(xfile!.path));
                                imageUrl =
                                    await refImageUpload.getDownloadURL();
                                setState(() {});
                              } catch (error) {
                                Fluttertoast.showToast(msg: '$error');
                              }
                            },
                            child: Container(
                              width: 100.h,
                              height: 100.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  gradient: AppTheme.linearGradient),
                              child: xfile != null
                                  ? Image.file(File(xfile!.path))
                                  : SvgPicture.asset('assets/icons/add.svg'),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: TextField(
                          controller: subCategoryController,
                          decoration:
                              AppTheme.inputDecoration(hintText: 'Nomi'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: TextField(
                          controller: subCategoryRuController,
                          decoration:
                              AppTheme.inputDecoration(hintText: 'Название'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                print(subCategoryList.length);
                                if (imageUrl != '') {
                                  subCategoryList.add(SubCategory(
                                    id: subId,
                                    image: imageUrl,
                                    titleRu: subCategoryRuController.text,
                                    categoryId: selectedCategoryId,
                                    items: [],
                                    title: subCategoryController.text,
                                  ).toJson());

                                  FirebaseFirestore.instance
                                      .collection('category_model')
                                      .doc(id)
                                      .set(
                                    {
                                      'id': selectedCategoryId,
                                      'image': categoryImageUrl,
                                      'items': subCategoryList,
                                    },
                                  );
                                  imageUrl = '';
                                  subCategoryController.clear();
                                  subCategoryRuController.clear();
                                  xfile = null;
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Rasm tanlanmagan!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black38,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                                pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: AppTheme.linearGradient,
                                    borderRadius: BorderRadius.circular(12.r)),
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
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
