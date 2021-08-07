import 'package:amit_ecommerce/Screens/Item_screen.dart';
import 'package:amit_ecommerce/Screens/user.Cart.dart';
import 'package:amit_ecommerce/Screens/user.HomeScreen.dart';
import 'package:amit_ecommerce/models/CategoryModel.dart';
import 'package:amit_ecommerce/models/ProductsCategoryModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consonants.dart';
class UserProducts extends StatefulWidget {


  static String id ='UserProducts';

  @override
  _UserProductsState createState() => _UserProductsState();
}

class _UserProductsState extends State<UserProducts> {
  @override
  Widget build(BuildContext context) {
    double heightMedia= MediaQuery.of(context).size.height;
    double widthMedia= MediaQuery.of(context).size.width;
    CategoryModel arg=ModalRoute.of(context).settings.arguments;
    print(arg);

    var categoryName=arg.cName;
    var categoryId=arg.cId;
    print(categoryName);
    print(categoryId);
    return Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.home,color: KButtonColor,),
            onPressed: (){
            Navigator.pushNamed(context, HomeScreenUser.id);
            },
          )
        ],
        leading: IconButton(icon: Icon(Icons.arrow_back,color: KButtonColor,),
            onPressed: (){
              Navigator.pop(context);
            }),
        title: Text('$categoryName',style: TextStyle(
            color: KButtonColor
        ),),
        centerTitle: true,
        backgroundColor: KMainColor,
        elevation: 0,
      ),
     body: StreamBuilder<List<ProductsCategoryModel>>(
         stream: GetCategProducts(arg.cId),
         builder: (context,snapshot){
           if(snapshot.connectionState!=ConnectionState.done){
             return Center(child: CircularProgressIndicator(),);
           }else if(snapshot.hasError){
             print(snapshot.error.toString());
             return Center(child: CircularProgressIndicator(),);

           }else if (snapshot.hasData){
             List<ProductsCategoryModel> prodList=snapshot.data;
             return GridView.builder(
                 physics: BouncingScrollPhysics(),
                padding:  EdgeInsets.symmetric(vertical: heightMedia*.02,horizontal: widthMedia*.03),
               itemCount: prodList.length,
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 // childAspectRatio: .7,
                   childAspectRatio: MediaQuery.of(context).size.aspectRatio,
                   //heightMedia*.001,
                   crossAxisSpacing: widthMedia*.02,
                   mainAxisSpacing: heightMedia*.02,
                   crossAxisCount: 2
                 ),
                 itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, ItemScreen.id,arguments: prodList[index]);
                    },
                    child: Container(

                      child: GridTile(
                        child: Column(
                          children: [
                            Image(image: NetworkImage(prodList[index].pAvatar, ),fit: BoxFit.fill,height: heightMedia*.25,width: widthMedia*.4,),
                            Container(
                              color: Colors.white,
                              height: heightMedia*.14,
                              width: widthMedia*.4,
                              child:Padding(
                                padding:  EdgeInsets.symmetric(horizontal: widthMedia*.01,vertical: heightMedia*.01),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(prodList[index].pTitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                    Text(prodList[index].pName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(icon: Icon(Icons.add_box_outlined,size: 30,color: KButtonColor,), onPressed: (){}),
                                        Column(
                                          children: [

                                            Row(
                                              children: [
                                                Text('${prodList[index].pPrice!=prodList[index].pPriceAfterDiscount?'${prodList[index].pPrice}':''} ',style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                  decoration: prodList[index].pPrice!=prodList[index].pPriceAfterDiscount?TextDecoration.lineThrough:TextDecoration.none
                                                ),),
                                                Text(' ${prodList[index].pDiscount!=0?'(${prodList[index].pDiscount}'
                                                    ' ${prodList[index].pDiscountType=='FIXED'?'EGP Off':'% Off'})':''}',style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: prodList[index].pPrice.bitLength<4? 10:8,
                                                  color: Colors.red,
                                               //   decoration: TextDecoration.lineThrough
                                                ),),
                                              ],
                                            ),
                                            Text('${prodList[index].pPriceAfterDiscount.toString()} ${prodList[index].pCurrency}'
                                            ,style: TextStyle(
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )

                                  ],
                                ),
                              ),
                            )
                              ],
                        ),
                      ),
                    ),
                  );
                 });

           }else{
             return Center(child: CircularProgressIndicator(),);

           }
           return null;
         }

     ),
    );
  }

 Stream<List<ProductsCategoryModel>> GetCategProducts(idC)async* {
    List<ProductsCategoryModel> list=[];

    var response=await Dio().get('https://retail.amit-learning.com/api/categories/$idC}',
        );

   var data=response.data['products'];
print (data);

   for(var prod in data){
     list.add(ProductsCategoryModel.fromJson(prod));
   }
 //  print(' the poducts are $list');
   yield list;

 }
}
/*
Container(
                    height: heightMedia*.4,
                    width: widthMedia*.4,
                    color: Colors.yellow,
                    child:Column(
                      children: [
                         Container(
                          width: widthMedia*.4,
                          height: heightMedia*.3,

                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(prodList[index].pAvatar)
                              )
                          ),
                          child:null
                        ),
                      ],
                    )
                  ) ;
 */


/*
Container(
                            color: Colors.yellow,
                            child: ListTile(
                              leading:  Text("ProductName"),
                              trailing:  Row(

                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text("Salary 5000"),
                                  Text("Salary 5000",style: TextStyle(
                                    decoration: TextDecoration.lineThrough,

                                  ),),
                                  Icon(Icons.add_shopping_cart_rounded,),

                                ],
                              ),
                            )
                          )
 */