import 'package:amit_ecommerce/Screens/login_screen.dart';
import 'package:amit_ecommerce/bloc/bloc_control.dart';
import 'package:amit_ecommerce/bloc/bloc_events.dart';
import 'package:amit_ecommerce/models/getUser_model.dart';
import 'package:amit_ecommerce/reusable_widgets/Drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../consonants.dart';

class MenuScreen extends StatelessWidget {
  static String id='MenuScreeen';
  String userName;
  @override
  Widget build(BuildContext context) {
    double heightMedia = MediaQuery.of(context).size.height;
    double widthMedia = MediaQuery.of(context).size.width;
    print('KToken in constants is $KToken');
    GetUserDetails(KToken);
    BlocControl counter = BlocProvider.of<BlocControl>(context);
    counter.add(BlocEvents.lastValue);
    int count = 7;
    return Scaffold(
        backgroundColor: KMainColor,
        drawer: ProfileDrawer('me@gmail'),
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: KMainColor,
          iconTheme: IconThemeData(color: KButtonColor),
        ),
        body: FutureBuilder<GetUserModel>(
          future: GetUserDetails(KToken),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'No Orders Yet !',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              );
            } else if (snapshot.hasData) {
              GetUserModel modelUser = snapshot.data;
              return Column(
               // crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(
                      '${modelUser.name}',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    subtitle: Text('${modelUser.email}',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    leading: CircleAvatar(
                      radius: 40,
                        child: Icon(Icons.person),
                        backgroundColor: KButtonColor,
                        backgroundImage: null
                        //AssetImage('assets/images/profileavatar.jpg'),
                        ),
                  ),
                ],
              );
            } else {
              return null;
            }
          },
        ));
  }

  void minusAmountTry(context) {
    BlocControl counter = BlocProvider.of<BlocControl>(context);
    if (counter.state == 1) {
      counter.add(BlocEvents.lastValue);
    } else {
      counter.add(BlocEvents.decrement);
    }
  }

  void addAmountTry(productInStock, context) {
    BlocControl counter = BlocProvider.of<BlocControl>(context);
    if (counter.state < productInStock) {
      counter.add(BlocEvents.increment);
    } else {
      num number = counter.state;
      number = productInStock;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            ' There is only $productInStock items available ,thank you for your patience ! '),
      ));
    }
  }

  Future<GetUserModel> GetUserDetails(KToken) async {
    var response = await Dio().get('https://retail.amit-learning.com/api/user',
        options: Options(headers: {'Authorization': '$KToken'}));
    var data = response.data['user'];
    print(data);
    GetUserModel model = GetUserModel.fromJson(data);
    print('model is $model');
    return model;
  }
}
/*
Center(

          child: Column(
            children: [
              Row(
                children: [
                  IconButton(icon: Icon(Icons.minimize_outlined), onPressed: () {
                    minusAmountTry(context);
                    //counter.add(BlocEvents.decrement);
                  }),
                  BlocBuilder<BlocControl,int>(
                    builder:(context, state) =>  Text(
                      '$state',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.add), onPressed: () {
                    addAmountTry(count,context);
                  })
                ],
              ),
              Text('Number in Stock = $count')
            ],
          ),
        ),
 */
