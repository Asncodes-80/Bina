import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/Controllers/flusher.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Extracted/productInBasket.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Views/WelcomeIntroPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

class Saved extends StatelessWidget {
  const Saved({
    @required this.themeChange,
    this.scrollController,
    this.userDidSave,
  });

  final DarkThemeProvider themeChange;
  final ScrollController scrollController;
  final List userDidSave;

  @override
  Widget build(BuildContext context) {
    final userSaveProduct = ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: userDidSave.length,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
              color: themeChange.darkTheme ? darkObjBgColor : Colors.white,
              child: ProductInBasket(
                themeChange: themeChange,
                productPrice: userDidSave[index]['price'],
                imgNetSource: userDidSave[index]['img'],
                productName: themeChange.langName
                    ? userDidSave[index]['name_ar']
                    : userDidSave[index]['name_kur'],
              )),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'حذف',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () async {
                var delProc =
                    await saved.delSavedProduct(id: userDidSave[index]['id']);
                if (delProc)
                  showStatusInCaseOfFlush(
                      context: context,
                      icon: Icons.delete,
                      iconColor: Colors.green,
                      msg: "محصول مورد نظر حذف شد",
                      title: "حذف از ذخیره ها");
                else {
                  showStatusInCaseOfFlush(
                      context: context,
                      icon: Icons.close,
                      iconColor: Colors.red,
                      msg: "این کالا یک بار حذف شده است",
                      title: "مشکلی در حذف کالا");
                }
              },
            ),
          ],
        );
      },
    );
    final lottie = Column(
      children: [
        Lottie.asset("assets/lottie/emptyLoading.json"),
        CustomText(
          text: "گلای ذخیره شده ای موجود نیست",
        )
      ],
    );

    final savedList = userDidSave.isEmpty ? lottie : userSaveProduct;

    return Stack(
      children: [
        NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 20,
                backgroundColor: mainBlue,
                // It's null leading
                leading: Container(
                  margin: EdgeInsets.all(10),
                ),
                flexibleSpace: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: [
                              CustomText(
                                text: themeChange.langName
                                    ? arabicLang["favorite"]
                                    : kurdishLang["favorite"],
                                fw: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ];
          },
          body: Container(
            decoration: BoxDecoration(
              color: themeChange.darkTheme ? darkBgColor : lightBgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34),
                topRight: Radius.circular(34),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  savedList,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
