import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Views/products.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Search extends StatelessWidget {
  const Search(
      {@required this.themeChange,
      this.searchResult,
      this.scrollController,
      this.onSearchSubmision});

  final DarkThemeProvider themeChange;
  final List searchResult;
  final scrollController;
  final Function onSearchSubmision;

  @override
  Widget build(BuildContext context) {
    final loadLottie = Lottie.asset("assets/lottie/loading.json");
    final readCategoryList = GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // TODO CHANGE THE ASPECT RATIO IN HORIZONTAL
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height),
      ),
      itemBuilder: (_, index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, productViewPage, arguments: {
            "productId": searchResult[index]['id'],
          });
          // print(productsLs[index]['id']);
        },
        child: ProductViewer(
          themeChange: themeChange,
          productImg: searchResult[index]['image'],
          productName: searchResult.isEmpty
              ? ""
              : themeChange.langName
                  ? searchResult[index]['name_ar']
                  : searchResult[index]['name_ku'],
          productAvailable: searchResult[index]['available'],
          productPrice: searchResult[index]['price'],
        ),
      ),
      itemCount: searchResult.length,
    );

    final usageProducts = searchResult.isEmpty ? loadLottie : readCategoryList;
    return Stack(
      children: [
        NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 150,
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
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: [
                              CustomText(
                                text: themeChange.langName
                                    ? arabicLang["searchingProducts"]
                                    : kurdishLang["searchingProducts"],
                                fontSize: 18,
                                fw: FontWeight.bold,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: themeChange.darkTheme
                              ? darkObjBgColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          // TODO (Sreach Case will go to searching page)
                          onSubmitted: onSearchSubmision,
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(fontSize: 17, fontFamily: mainFont),
                            hintText: themeChange.langName
                                ? arabicLang["searchBar"]
                                : kurdishLang["searchBar"],
                            suffixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
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
                  usageProducts,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
