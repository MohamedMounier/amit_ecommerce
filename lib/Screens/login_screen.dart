import 'package:amit_ecommerce/Provider/Model_HudProvider.dart';
import 'package:amit_ecommerce/Screens/adminPage.dart';
import 'package:amit_ecommerce/Screens/registration_screen.dart';
import 'package:amit_ecommerce/Screens/user.HomeScreen.dart';
import 'package:amit_ecommerce/Screens/user_categories.dart';
import 'package:amit_ecommerce/consonants.dart';
import 'package:amit_ecommerce/reusable_widgets/TextFormField_Widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
static  String id ='Login Screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
var _passLog=TextEditingController();

var _emailLog=TextEditingController();

AutovalidateMode _autovalidateMode;
bool obsercure=true;
bool keepMeLoggedin=false;

final GlobalKey<FormState> formKeylogin=GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
   double heightMedia= MediaQuery.of(context).size.height;
   double widthMedia= MediaQuery.of(context).size.width;
   final appbarSize=AppBar().preferredSize.height;
   final statusBarSize=MediaQuery.of(context).padding.top;
   print('KToken in constants is $KToken');

    return Scaffold(

      backgroundColor: KMainColor,
      body: ModalProgressHUD(
        inAsyncCall:  Provider.of<ModelHud>(context).isLoading,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: heightMedia,

              child: Form(
                autovalidateMode: _autovalidateMode,
                key: formKeylogin,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: heightMedia*.15),
                        child: Container(
                            height: heightMedia*.2,
                            width: widthMedia*.5,
                            color: Colors.transparent,
                            child: Image(image: AssetImage('assets/images/AmitT.png'),)),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: heightMedia*.03),
                        child: EmailField(

                          controller: _emailLog,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Email Shouldn\'t be empty';
                            }
                          },
                          heightMedia: heightMedia,
                          widthMedia: widthMedia,
                          prefix: Icons.email_outlined,
                          hint: 'Enter your Email',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: heightMedia*.015),
                        child: EmailAndPassField(
                          obsecure: obsercure,
                          controller: _passLog,
                          validator: (String value){
                            if(value.isEmpty){
                              return 'Password Shouldn\'t be empty';
                            }else{
                              return null;
                            }

                          },
                          heightMedia: heightMedia,
                          widthMedia: widthMedia,
                          prefix: Icons.lock_outline,
                          hint: 'Enter your Password',
                          suffix: Icons.remove_red_eye,
                          suffixFunc: (){
                           setState(() {
                             obsercure=!obsercure;
                           });
                          },
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: widthMedia*.089),
                        child: Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.black45
                              ),
                              child: Checkbox(
                                  activeColor: KButtonColor,
                                  checkColor: Colors.white,
                                  value: keepMeLoggedin,
                                  onChanged: (value){
                                    setState(() {
                                      keepMeLoggedin=value;
                                    });
                                  }),
                            ),
                            Text(
                              'Remember Me',
                              style: TextStyle(
                                  color: Colors.black54, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: heightMedia*.04),
                            child: Container(
                              width: widthMedia*.3,
                              child: ElevatedButton( child: Text('Login as User',style:
                                TextStyle(
                                  fontSize: 12
                                )
                                ,),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(KButtonColor),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                                ),
                                onPressed: ()async{
                                  final modelHud= Provider.of<ModelHud>(context,listen: false);
                                  modelHud.ChangeisLoading(true);

                                if(keepMeLoggedin==true){
                                  keepUserIn();
                                }
                                if(formKeylogin.currentState.validate()){
                                 print('valid');
                                 print(_emailLog.text);
                                try{
                                await PostLogin().then((statuscode) {
                                  print('value is $statuscode');


                                  if(statuscode.toString().contains('20')){
                                    Navigator.pushNamed(context, HomeScreenUser.id);
                                  }else{
                                    modelHud.ChangeisLoading(false);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text('Email and Password don\'t match,Kindly Check your id and password again')));
                                  }
                                } );



                                }catch(e){
                                  print('the error is ${e.toString()}');
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Email and Password don\'t match,Kindly Check your id and password again')));
                                }
                                }else{
                                  modelHud.ChangeisLoading(false);
                                  setState(() {
                                    _autovalidateMode=AutovalidateMode.always;
                                  });
                                }
                                  modelHud.ChangeisLoading(false);
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: widthMedia*.05,),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: heightMedia*.05),
                            child: Container(
                              width: widthMedia*.3,
                              child: ElevatedButton( child: Text('Login as Admin',style:
                                TextStyle(
                                  fontSize: 12
                                )
                                ,),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(KButtonColor),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                                ),
                                onPressed: (){
                                  if(formKeylogin.currentState.validate()){
                                    print('valid');
                                    print(_emailLog.text);
                                    if(_emailLog.text=='admin2134@gmail.com'&&_passLog.text=='21341234'){
                                      Navigator.pushNamed(context, AdminHomePage.id);
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text('Email and Password don\'t match,Kindly Contact us if you are an admin')));
                                    }
                                  }else{
                                    setState(() {
                                      _autovalidateMode=AutovalidateMode.always;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),

                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(top:heightMedia*.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ?',
                            style: TextStyle(
                                fontSize: 15

                            ),
                            ),
                            TextButton(
                                child: Text('Register',
                                  style: TextStyle(
                                    color:KButtonColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                  ),),
                                onPressed: (){
                                  Navigator.pushNamed(context, RegisterScreen.id);
                                }
                            )
                          ],
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
    );
  }

  Future PostLogin()async {
    Map loginParameters = {
      KEmail:_emailLog.text,
      KPassword:_passLog.text
    };
    var path= 'https://retail.amit-learning.com/api/login';
    var response =await Dio().post(path,
    data: loginParameters
    );
    print('data is ${response.data}');
    var token = ('Bearer  ${response.data['token']}');
    print('token is $token');

    KToken=token;
    print('KToken in constants is $KToken');

    return response.statusCode;

  }
  keepUserIn()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setBool(KeepMeLoggedIn, keepMeLoggedin);
  }

}

