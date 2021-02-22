import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Views/connection.dart';
// import 'package:Bina/Model/Classes/LangStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// import 'Model/Classes/Routers.dart';
import 'Model/Classes/ThemeColor.dart';

// Views
import 'package:Bina/Views/splashScreen.dart';
import 'package:Bina/Views/WelcomeIntroPage.dart';
import 'package:Bina/Views/maino.dart';
import 'package:Bina/Views/login.dart';
import 'package:Bina/Views/signup.dart';
import 'package:Bina/Views/moreCategories.dart';
import 'package:Bina/Views/changeLang.dart';
import 'package:Bina/Views/changeTheme.dart';
import 'package:Bina/Views/products.dart';
import 'package:Bina/Views/searchingResultPage.dart';
import 'Views/discountProducts.dart';
import 'Views/viewProducts.dart';
import 'package:Bina/Views/productInBasketView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Adding Dark theme provider to have provider changer theme
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    getCurrentAppLanguage();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  void getCurrentAppLanguage() async {
    themeChangeProvider.langName =
        await themeChangeProvider.darkThemePreferences.getLangName();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          // SystemChrome.setSystemUIOverlayStyle(themeChangeProvider.darkTheme
          //     ? SystemUiOverlayStyle.light
          //     : SystemUiOverlayStyle.dark);
          return MaterialApp(
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            // onGenerateRoute: AppRouters.allRouters,
            initialRoute: splashScreen,
            routes: {
              splashScreen: (context) => SplashScreen(),
              welcomeIntroPage: (context) => WelcomeIntroPage(),
              maino: (context) => Maino(),
              signup: (context) => Signup(),
              login: (context) => Login(),
              moreCategoriesPage: (context) => MoreCategories(),
              changeLangPage: (context) => ChangeLang(),
              changeThemePage: (context) => ChangeTheme(),
              productsPage: (context) => ProductsPage(),
              productViewPage: (context) => ProductView(),
              searchResultPage: (context) => SearchResult(),
              discountPage: (context) => DiscountedPage(),
              productBasketView: (context) => ProductInBasketView(),
              connectionPage: (context) => ConnectionPage(),
            },
          );
        },
      ),
    );
  }
}
