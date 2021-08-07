import 'package:amit_ecommerce/Screens/user_products.dart';
import 'package:amit_ecommerce/models/CategoryModel.dart';
import 'package:amit_ecommerce/reusable_widgets/TextFormField_Widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../consonants.dart';

class UserCategories extends StatelessWidget {
  static String id='UserCategories';
  @override
  Widget build(BuildContext context) {
    double heightMedia= MediaQuery.of(context).size.height;
    double widthMedia= MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: KMainColor,

        body: FutureBuilder<List<CategoryModel>>(
            future: GetCateg(),
            builder: (context,snapshot){
              if(snapshot.connectionState!=ConnectionState.done){
                return Center(child: CircularProgressIndicator(),);
              }else if (snapshot.hasError){
                print(snapshot.error.toString());
                return Text(snapshot.error.toString());
              }else if (snapshot.hasData){
                List<CategoryModel> list1=snapshot.data;
                return GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: list1.length
                    //list1.length
                    ,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (context,index){

                      //list=snapshot.data;
                      return GestureDetector(
                        onTap: (){


                          Navigator.pushNamed(context, UserProducts.id,
                              arguments:list1[index]
                               );
                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: heightMedia*.02,horizontal: widthMedia*.03),
                          child: Container(
                            width: widthMedia*.4,
                            height: heightMedia*.3,

                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(list1[index].cAvatar)
                                )
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                      color: Colors.black54.withOpacity(.5),
                                      child: Text('${list1[index].cName}',style:
                                      TextStyle(
                                          fontSize: 19,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      )
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                );
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
              return null;
            }
        )
    );
  }
  Future<Map> getMap()async{
    var response =await Dio().get('https://retail.amit-learning.com/api/categories');
  //  print('The map is ${response.data}');
    var data= response.data['categories'];
    return  data;
  }

  Future<List<CategoryModel>> GetCateg()async{
    List<CategoryModel> listCat=[];
    var response = await Dio().get('https://retail.amit-learning.com/api/categories');
   // print(response.data);
    var cattegories=response.data['categories'];

    /*
      response.data.forEach((element){
      listCat.add(CategoryModel.fromJson(element));
      print('the list is  $element');

      print('the list is  $listCat');
    });
     */


    for(var cat in cattegories){
      listCat.add(CategoryModel.fromJson(cat));
   //   print(listCat);
    }

    return listCat;
  }
}
