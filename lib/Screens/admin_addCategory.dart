import 'package:amit_ecommerce/models/CategoryModel.dart';
import 'package:amit_ecommerce/reusable_widgets/TextFormField_Widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../consonants.dart';

class AddCategory extends StatelessWidget {
  static String id='AddCategory page';
  @override
  Widget build(BuildContext context) {
    double heightMedia= MediaQuery.of(context).size.height;
    double widthMedia= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: KButtonColor,),
            onPressed: (){
              Navigator.pop(context);
            }),
        title: Text('Add Category',style: TextStyle(
            color: KButtonColor
        ),),
        centerTitle: true,
        backgroundColor: KMainColor,
        elevation: 0,
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream:  GetCateg(),
        builder: (context,snapshot){
          if(snapshot.connectionState!=ConnectionState.done){
            return Center(child: CircularProgressIndicator(),);
          }else if (snapshot.hasError){
            print(snapshot.error.toString());
            return Text(snapshot.error.toString());
          }else if (snapshot.hasData){
            List<CategoryModel> list1=snapshot.data;
            return GridView.builder(
              itemCount:list1.length
              //list1.length
              ,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context,index){

                  //list=snapshot.data;
                  return Padding(
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
  // print('The map is ${response.data}');
   var data= response.data['categories'];
   return  data;
  }

 Stream<List<CategoryModel>> GetCateg()async*{
    List<CategoryModel> listCat=[];
    var response = await Dio().get('https://retail.amit-learning.com/api/categories');
  //  print(response.data);
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
   //  print(listCat);
   }
   yield listCat;
  }
}
