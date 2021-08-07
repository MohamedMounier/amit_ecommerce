import 'package:amit_ecommerce/Provider/AppProvider.dart';
import 'package:amit_ecommerce/Provider/Model_HudProvider.dart';
import 'package:amit_ecommerce/Provider/Plus_Minus_Provider.dart';
import 'package:amit_ecommerce/Screens/AllProductsScreen.dart';
import 'package:amit_ecommerce/Screens/Item_screen.dart';
import 'package:amit_ecommerce/Screens/admin_addCategory.dart';
import 'package:amit_ecommerce/Screens/login_screen.dart';
import 'package:amit_ecommerce/Screens/menu_screen.dart';
import 'package:amit_ecommerce/Screens/registration_screen.dart';
import 'package:amit_ecommerce/Screens/user.Cart.dart';
import 'package:amit_ecommerce/Screens/user.HomeScreen.dart';
import 'package:amit_ecommerce/Screens/user_categories.dart';
import 'package:amit_ecommerce/Screens/user_products.dart';
import 'package:amit_ecommerce/bloc/bloc_Item.dart';
import 'package:amit_ecommerce/bloc/bloc_control.dart';
import 'package:amit_ecommerce/consonants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/adminPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isLoggedin;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return MaterialApp(
              home: Scaffold(
                  backgroundColor: KMainColor,
                  body: Center(child: CircularProgressIndicator())),
            );
          }else if(snapshot.hasError){
            print(snapshot.error.toString());
            return MaterialApp(
              home: Center(child: CircularProgressIndicator(),),
            );
          }else{
            isLoggedin=snapshot.data.getBool(KeepMeLoggedIn)??false;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModelHud>(
                    create: (context)=>ModelHud()),
                ChangeNotifierProvider<AppProvider>(
                    create: (context) => AppProvider()),
                ChangeNotifierProvider<AmountProvider>(
                    create: (context) => AmountProvider()),
                BlocProvider<BlocControl>(
                  create: (context) => BlocControl(0),
                ),

              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: isLoggedin?HomeScreenUser.id:LoginScreen.id,
                routes: {
                  LoginScreen.id :(context)=>LoginScreen(),
                  RegisterScreen.id:(context)=>RegisterScreen(),
                  AddCategory.id:(context)=>AddCategory(),
                  AdminHomePage.id:(context)=>AdminHomePage(),
                  UserCategories.id:(context)=>UserCategories(),
                  UserProducts.id:(context)=>UserProducts(),
                  AllProducts.id:(context)=>AllProducts(),
                  HomeScreenUser.id:(context)=>HomeScreenUser(),
                  ItemScreen.id:(context)=>ItemScreen(),
                  UserCart.id:(context)=>UserCart(),
                  MenuScreen.id:(context)=>MenuScreen(),


                },

              ),
            );
          }
        },
    );
  }
}
/*
MultiProvider(
      providers: [
    ChangeNotifierProvider<AppProvider>(
    create: (context) => AppProvider()),
    ChangeNotifierProvider<AmountProvider>(
    create: (context) => AmountProvider()),
        BlocProvider<BlocControl>(
            create: (context) => BlocControl(0),
        ),

      ],
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id :(context)=>LoginScreen(),
          RegisterScreen.id:(context)=>RegisterScreen(),
          AddCategory.id:(context)=>AddCategory(),
          AdminHomePage.id:(context)=>AdminHomePage(),
          UserCategories.id:(context)=>UserCategories(),
          UserProducts.id:(context)=>UserProducts(),
          AllProducts.id:(context)=>AllProducts(),
          HomeScreenUser.id:(context)=>HomeScreenUser(),
          ItemScreen.id:(context)=>ItemScreen(),
          UserCart.id:(context)=>UserCart()

        },

      ),
    );
 */