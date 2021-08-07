import 'package:amit_ecommerce/Screens/login_screen.dart';
import 'package:amit_ecommerce/consonants.dart';
import 'package:amit_ecommerce/models/getUser_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDrawer extends StatelessWidget {
  ProfileDrawer(this.emailDrawer) ;

  String emailDrawer;
  @override
  Widget build(BuildContext context) {
    double heightMedia = MediaQuery.of(context).size.height;
    double widthMedia = MediaQuery.of(context).size.width;
    return FutureBuilder<GetUserModel>(
      future: GetUserDetails(KToken),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: widthMedia * .42,
            child: Drawer(
              child: Container(
                color: KMainColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: ListTile(
                            title: Text(
                              'Loading...',
                              style:
                              TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            subtitle: Text(
                                '${emailDrawer != null ?'Loading...' : 'Email is Bugged'}',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black)),
                            leading: CircleAvatar(
                                child: Icon(Icons.person),
                                backgroundColor: KButtonColor,
                                backgroundImage: null
                              //AssetImage('assets/images/profileavatar.jpg'),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Home',
                            style:
                            TextStyle(fontSize: 15, color: Colors.black)),
                        leading: Icon(
                          Icons.home,
                          color: KButtonColor,
                        ),
                      ),
                      ListTile(
                        title: Text('Explore',
                            style:
                            TextStyle(fontSize: 15, color: Colors.black)),
                        leading: Icon(
                          Icons.explore,
                          color: KButtonColor,
                        ),
                        onTap: () {},
                      ),
                      Center(
                        child: Container(
                          // margin: EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsetsDirectional.only(
                              start: 10, top: heightMedia * .47),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: ()async {
                                  await  showDialog(context: context, builder: (context)=>  AlertDialog(title: Text('Are you sure you want to log out?'),actions: [
                                    MaterialButton(onPressed: ()async{
                                      SharedPreferences pref=await SharedPreferences.getInstance();
                                      pref.remove(KeepMeLoggedIn);
                                      Navigator.popAndPushNamed(context, LoginScreen.id);
                                    },child: Text('Yes'),),
                                    MaterialButton(onPressed: (){
                                      Navigator.pop(context);
                                    },child: Text('No'),)
                                  ],) );
                                  //RemoveKeepLoggedin(context);
                                },
                                child: ListTile(
                                    title: Text('Sign Out',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                    leading:
                                    Icon(Icons.home, color: KButtonColor)),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/images/fb.svg',
                                      color: KButtonColor,
                                      width: 15,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/images/insta.svg',
                                        color: KButtonColor,
                                        width: 24,
                                      ),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/images/twit.svg',
                                        color: KButtonColor,
                                        width: 24,
                                      ),
                                      onPressed: () {}),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          GetUserModel modelUser = snapshot.data;
          return Container(
            width: widthMedia * .42,
            child: Drawer(
              child: Container(
                color: KMainColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: ListTile(
                            title: Text(
                              '${modelUser.name}',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            subtitle: Text(
                                '${emailDrawer != null ? modelUser.email : 'Email is Bugged'}',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black)),
                            leading: CircleAvatar(
                                child: Icon(Icons.person),
                                backgroundColor: KButtonColor,
                                backgroundImage: null
                                //AssetImage('assets/images/profileavatar.jpg'),
                                ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Home',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        leading: Icon(
                          Icons.home,
                          color: KButtonColor,
                        ),
                      ),
                      ListTile(
                        title: Text('Explore',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        leading: Icon(
                          Icons.explore,
                          color: KButtonColor,
                        ),
                        onTap: () {},
                      ),
                      Center(
                        child: Container(
                          // margin: EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsetsDirectional.only(
                              start: 10, top: heightMedia * .47),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: ()async {
                                  await  showDialog(context: context, builder: (context)=>  AlertDialog(title: Text('Are you sure you want to log out?'),actions: [
                                    MaterialButton(onPressed: ()async{
                                      SharedPreferences pref=await SharedPreferences.getInstance();
                                      pref.remove(KeepMeLoggedIn);
                                      Navigator.popAndPushNamed(context, LoginScreen.id);
                                    },child: Text('Yes'),),
                                    MaterialButton(onPressed: (){
                                      Navigator.pop(context);
                                    },child: Text('No'),)
                                  ],) );
                                  //RemoveKeepLoggedin(context);
                                },
                                child: ListTile(
                                    title: Text('Sign Out',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                    leading:
                                        Icon(Icons.home, color: KButtonColor)),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/images/fb.svg',
                                      color: KButtonColor,
                                      width: 15,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/images/insta.svg',
                                        color: KButtonColor,
                                        width: 24,
                                      ),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/images/twit.svg',
                                        color: KButtonColor,
                                        width: 24,
                                      ),
                                      onPressed: () {}),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return null;
        }
      },
    );
  }

  void RemoveKeepLoggedin(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(KeepMeLoggedIn);
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, (route) => false);
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
  AlertDialog LoggingOutDialouge(context) => AlertDialog(
    title: Text(
        'Are you sure you want to log out?'),
    actions: [
      MaterialButton(
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.remove(KeepMeLoggedIn);
          Navigator.popAndPushNamed(
              context, LoginScreen.id);
        },
        child: Text('Yes'),
      ),
      MaterialButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('No'),
      )
    ],
  );
}
/*
Container(

      width: 180,
      child: Drawer(

        child: Container(
          color: Colors.black87,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListTile(
                      title: Text('@UserName',style: TextStyle(fontSize: 15,color: Colors.white),),
                      subtitle:Text('${ emailDrawer!=null?emailDrawer:'Email is Bugged'}',style: TextStyle(fontSize: 10,color: Colors.white)),
                      leading: CircleAvatar(
                        backgroundImage: null
                        //AssetImage('assets/images/profileavatar.jpg'),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Home',style: TextStyle(fontSize: 10,color: Colors.white)),
                  leading: Icon(Icons.home,color: Colors.indigo,),
                ),
                ListTile(
                  title: Text('Explore',style: TextStyle(fontSize: 10,color: Colors.white)),
                  leading: Icon(Icons.explore,color: Colors.indigo,),
                  onTap: (){
                    Navigator.pushNamed(context, 'TabBarPages');
                  },
                ),
                Center(
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.only(right: 20,top: 380),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            RemoveKeepLoggedin(context);
                          },
                          child: ListTile(
                            title: Text('Sign Out',style: TextStyle(fontSize: 10,color: Colors.white)),
                            leading: IconButton(icon:Icon(Icons.home,color: Colors.indigo),
                            onPressed: (){

                            },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(icon: SvgPicture.asset('assets/images/fb.svg',color: Colors.indigo,width: 15,),onPressed: (){},),
                            IconButton(icon: SvgPicture.asset('assets/images/insta.svg',color: Colors.indigo,width: 24,),onPressed: (){}),
                            IconButton(icon: SvgPicture.asset('assets/images/twit.svg',color: Colors.indigo,width: 24,),onPressed: (){}),


                          ],

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
 */
