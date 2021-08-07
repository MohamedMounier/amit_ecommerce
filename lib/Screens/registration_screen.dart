import 'package:amit_ecommerce/Provider/Model_HudProvider.dart';
import 'package:amit_ecommerce/Screens/login_screen.dart';
import 'package:amit_ecommerce/reusable_widgets/TextFormField_Widgets.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';


import '../consonants.dart';

class RegisterScreen extends StatefulWidget {
  static String id='Resgisteration Screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formkeyReg=GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode;
  var _nameReg=TextEditingController();
  var _emailReg=TextEditingController();
  var _passReg=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double heightMedia= MediaQuery.of(context).size.height;
    double widthMedia= MediaQuery.of(context).size.width;
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      backgroundColor: KMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Center(
          child: Container(
            height: heightMedia,

            child: Form(
              key: formkeyReg,
              autovalidateMode: _autovalidateMode,
              child: ListView(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: heightMedia*.03),
                    child: Container(
                        height: heightMedia*.2,
                        width: widthMedia*.5,
                        color: Colors.transparent,
                        child: Image(image: AssetImage('assets/images/AmitT.png'),)),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: heightMedia*.03,horizontal: widthMedia*.05),
                    child: EmailAndPassField(
                      obsecure: false,
                      controller: _nameReg,
                      validator: (String value){
                        if(value.isEmpty){
                          return'Name Should be entered';
                        }
                      },
                      heightMedia: heightMedia,
                      widthMedia: widthMedia,
                      prefix: Icons.person_outline,
                      hint: 'Enter your Name',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: heightMedia*.01,horizontal: widthMedia*.05),
                    child: EmailAndPassField(
                      obsecure: false,
                      controller: _emailReg,
                        validator: (String value){
                  if(value.isEmpty){
                  return'Email Should be entered';
                  }
                  },
                      heightMedia: heightMedia,
                      widthMedia: widthMedia,
                      prefix: Icons.email_outlined,
                      hint: 'Enter your Email',

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: heightMedia*.03,horizontal: widthMedia*.05),
                    child: EmailAndPassField(
                      obsecure: false,
                      controller: _passReg,
                      validator: (String value){
                        if(value.isEmpty){
                          return'Password Should be entered';
                        }
                      },
                      heightMedia: heightMedia,
                      widthMedia: widthMedia,
                      prefix: Icons.lock_outline,
                      hint: 'Enter your Password',
                      suffix: Icons.remove_red_eye,
                      suffixFunc: (){},
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: heightMedia*.05,horizontal: widthMedia*.35),
                    child: Container(
                      width: widthMedia*.3,
                      child: ElevatedButton( child: Text('Register'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(KButtonColor),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                        ),
                        onPressed: ()async{
                          final modelHud= Provider.of<ModelHud>(context,listen: false);
                          modelHud.ChangeisLoading(true);
                        if(formkeyReg.currentState.validate()){
                          print('validate');
                          print(_emailReg.text);
                           await PostReg();
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Account has been created successfully , Login Now !')));
                          Navigator.pushNamed(context, LoginScreen.id);
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
                  Padding(
                    padding: EdgeInsets.only(top:heightMedia*.007),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account ?',
                          style: TextStyle(
                              fontSize: 15

                          ),
                        ),
                        TextButton(
                            child: Text('Login',
                              style: TextStyle(
                                  color:KButtonColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                              ),),
                            onPressed: (){
                              Navigator.pushNamed(context, LoginScreen.id);
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
    );
  }
   PostReg()async{
    Map paramaeter= {
      KEmail:_emailReg.text,
      KPassword:_passReg.text,
      KName:_nameReg.text
    };

    var user= await Dio().post('https://retail.amit-learning.com/api/register',
        data:  paramaeter,

        //RegistrationModel(_emailReg.text,_passReg.text,_nameReg.text).ToJson()
    );
    print(user.data);
  }
}

