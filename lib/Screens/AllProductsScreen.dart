import 'package:amit_ecommerce/models/CategoryModel.dart';
import 'package:amit_ecommerce/models/ProductsCategoryModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consonants.dart';
import 'Item_screen.dart';
class AllProducts extends StatefulWidget {


  static String id ='AllProducts';

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    double heightMedia= MediaQuery.of(context).size.height;
    double widthMedia= MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: KMainColor,

      body: StreamBuilder<List<ProductsCategoryModel>>(
          stream: GetAllProducts(),
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
                 padding:  EdgeInsets.symmetric(vertical: heightMedia*.04,horizontal: widthMedia*.05),
                  itemCount: prodList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // childAspectRatio: .7,
                      childAspectRatio: MediaQuery.of(context).size.aspectRatio,
                      //heightMedia*.001,
                      crossAxisSpacing: widthMedia*.1,
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

  Stream<List<ProductsCategoryModel>> GetAllProducts()async* {
    List<ProductsCategoryModel> list=[];

    var response=await Dio().get('https://retail.amit-learning.com/api/products',
    );
    print(response);
    var data=response.data['products'];

    for(var prod in data){
      list.add(ProductsCategoryModel.fromJson(prod));
    }
     print(' the poducts are $list');
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