import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';

class HomeShopping extends StatelessWidget {
  const HomeShopping(
      {Key key, @required this.themeChange, this.homeScroller, this.exhight});

  final DarkThemeProvider themeChange;
  final ScrollController homeScroller;
  final exhight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          NestedScrollView(
            controller: homeScroller,
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: exhight,
                  backgroundColor: mainBlue,
                  leading: Container(
                    margin: EdgeInsets.all(10),
                    child: ClipOval(
                      child: Material(
                        color: Colors.blue, // button color
                        child: InkWell(
                          splashColor: Colors.blue[300], // inkwell color
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Image.asset(
                                  "assets/images/isgpp_avatar_placeholder.png")),
                          onTap: () => print("sds"),
                        ),
                      ),
                    ),
                  ),
                  flexibleSpace: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: [
                                CustomText(
                                  text: themeChange.langName
                                      ? arabicLang["welcomeTitle"]
                                      : kurdishLang["welcomeTitle"],
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: [
                                CustomText(
                                  text: themeChange.langName
                                      ? arabicLang["welcomeSubTitle"]
                                      : kurdishLang["welcomeSubTitle"],
                                  fontSize: 18,
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            onSubmitted: (String searchCase) =>
                                print(searchCase),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 17),
                              hintText: themeChange.langName
                                  ? arabicLang["search"]
                                  : kurdishLang["search"],
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
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
