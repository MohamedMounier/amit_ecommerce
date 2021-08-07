import 'package:amit_ecommerce/Provider/AppProvider.dart';
import 'package:amit_ecommerce/models/getUser_model.dart';
import 'package:amit_ecommerce/reusable_widgets/Drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consonants.dart';

class HomeScreenUser extends StatelessWidget {
  static String id = 'HomeScreen';
  String userName;
  @override
  Widget build(BuildContext context) {
    double heightMedia= MediaQuery.of(context).size.height;
    double widthMedia= MediaQuery.of(context).size.width;
    AppProvider prov= Provider.of<AppProvider>(context);

    return Scaffold(



        backgroundColor: KMainColor,
        bottomNavigationBar: BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          backgroundColor: KMainColor,
          selectedItemColor: KButtonColor,
          unselectedItemColor: Colors.black,
          items: prov.navList,
          onTap: (index){
            prov.ChangeIndex(index);
          },
          currentIndex:prov.currentIndex
          // AppProvider().currentIndex,
        ),
        body:prov.screens[prov.currentIndex]
    );
  }


}
