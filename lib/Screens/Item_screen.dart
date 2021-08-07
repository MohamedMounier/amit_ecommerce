import 'package:amit_ecommerce/Database/DbHelper.dart';
import 'package:amit_ecommerce/Database/DbModel.dart';
import 'package:amit_ecommerce/Provider/Plus_Minus_Provider.dart';
import 'package:amit_ecommerce/bloc/bloc_control.dart';
import 'package:amit_ecommerce/bloc/bloc_events.dart';
import 'package:amit_ecommerce/models/ProductsCategoryModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../consonants.dart';
class ItemScreen extends StatefulWidget {
  static String id='ItemScreen';

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  num amount=1;
  DbHelper helper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper=DbHelper();
  }
  @override
  Widget build(BuildContext context) {
    double heightMedia= MediaQuery.of(context).size.height;
    double widthMedia= MediaQuery.of(context).size.width;
    ProductsCategoryModel arg=ModalRoute.of(context).settings.arguments;
    print(arg);
    AmountProvider prov= Provider.of<AmountProvider>(context);
    BlocControl bC=BlocProvider.of<BlocControl>(context);
    bC.add(BlocEvents.lastValue);
    num Number=bC.state;


    var productName=arg.pName;
    var productId=arg.pId;
    print(productName);
    print(productId);

    return  Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: KButtonColor,),
            onPressed: (){
              Navigator.pop(context);
            }),

        centerTitle: true,
        backgroundColor: KMainColor,
        elevation: 0,
      ),
      body: StreamBuilder<ProductsCategoryModel>(
          stream: GetItem(productId),
          builder: (context,snapshot){
            if(snapshot.connectionState!=ConnectionState.done){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasError){
              print(snapshot.error.toString());
              return Center(child: CircularProgressIndicator(),);

            }else if (snapshot.hasData){
              ProductsCategoryModel product=snapshot.data;
                    return Center(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: widthMedia*.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(image: NetworkImage(product.pAvatar, ) ,fit: BoxFit.fill,height: heightMedia*.4,width: widthMedia,),
                                  Padding(
                                    padding:  EdgeInsets.only(top: heightMedia*.01),
                                    child: Text(product.pName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                   Text(product.pTitle,
                                     overflow: TextOverflow.ellipsis,
                                     maxLines: 2,
                                     style: TextStyle(
                                         fontWeight: FontWeight.normal
                                     ),
                                   ),
                                  Divider(thickness: 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            children: [
                                              Text('${product.pPrice!=product.pPriceAfterDiscount?'${product.pPrice}':'no recent offer'} ',style: TextStyle(
                                                fontSize:product.pPrice!=product.pPriceAfterDiscount?17:14,
                                                  fontWeight: product.pPrice!=product.pPriceAfterDiscount?FontWeight.bold:FontWeight.normal,
                                                  color: product.pPrice!=product.pPriceAfterDiscount?Colors.red:Colors.black45,
                                                  decoration: product.pPrice!=product.pPriceAfterDiscount?TextDecoration.lineThrough:TextDecoration.none
                                              ),),
                                              Text(' ${product.pDiscount!=0?'(${product.pDiscount}'
                                                  ' ${product.pDiscountType=='FIXED'?'EGP Off':'% Off'})':''}',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.red,
                                                //   decoration: TextDecoration.lineThrough
                                              ),),
                                            ],
                                          ),
                                          Text('${(amount*product.pPriceAfterDiscount).toString()} ${product.pCurrency}'
                                            ,style: TextStyle(
                                              fontSize: 17,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(icon: Icon(Icons.indeterminate_check_box_outlined,size: 30,color: KButtonColor,),
                                              onPressed: (){
                                          //  prov.minusAmount(amount);
                                                //minusAmount();
                                                minusAmountTry(context);
                                              }),
                                          BlocBuilder<BlocControl,int>(
                                            builder:(context, state) =>  Text('$state',style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                          IconButton(icon: Icon(Icons.add_box_outlined,size: 30,color: KButtonColor,),
                                              onPressed: (){
                                              //  prov.addAmount(amount);
                                                //addAmount(product.pInStock);
                                                addAmountTry(product.pInStock,context);
                                              }),
                                        ],
                                      ),

                                    ],
                                  ),
                                  Divider(thickness: 2),
                                  Text(product.pDescription!=null?product.pDescription:'No more details about this product !',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                  Divider(thickness: 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text('In Stock :-  ',style:TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold
                                            ),),
                                            Text('${product.pInStock!=null?product.pInStock:'0'}',style: TextStyle(
                                              color: KButtonColor,
                                              fontSize: 16
                                            ),),
                                          ],
                                        ),
                                      ),

                                     Expanded(child:  Row(

                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                       children: [
                                         Text('Reviews',style: TextStyle(
                                             fontSize: 17,
                                             fontWeight: FontWeight.bold
                                         ),),

                                         Icon(Icons.star_border_outlined,size: 20,color: KButtonColor,),
                                         Icon(Icons.star_border_outlined,size: 20,color: KButtonColor,),
                                         Icon(Icons.star_border_outlined,size: 20,color: KButtonColor,),
                                         Icon(Icons.star_border_outlined,size: 20,color: KButtonColor,),
                                         Icon(Icons.star_border_outlined,size: 20,color: KButtonColor,),
                                       ],
                                     ),)

                                    ],
                                  ),
                                ],

                  ),
                            ),
                            Container(
                              width: widthMedia,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(KButtonColor)
                                  ),
                                  onPressed: (){
                                    AddToDataBase(pname: product.pName,pimage: product.pAvatar,pprice: product.pPriceAfterDiscount,
                                    ptitle: product.pTitle,ptotal: product.pPriceAfterDiscount*amount,pamount: amount,instock: product.pInStock
                                    );
                                    BlocControl counter= BlocProvider.of<BlocControl>(context);

                                    num tryin=counter.state;
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You \'ve added $tryin items to your Cart!')));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_shopping_cart,color: Colors.white,),
                                      Text('ADD TO CART',style: TextStyle(
                                          color: Colors.white
                                      ),)
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    );

            }else{
              return Center(child: CircularProgressIndicator(),);

            }
            return null;
          }

      ),
    );
  }

  Stream<ProductsCategoryModel> GetItem(pID)async*{
    var response= await Dio().get('https://retail.amit-learning.com/api/products/$pID');
   var data= response.data['product'];
   var product= ProductsCategoryModel.fromJson(data);
   yield product;
  }

  void minusAmount() {
    if(amount==1){
      setState(() {
        amount=1;
      });
    }else{
      setState(() {
        amount--;
      });
    }
  }

  void minusAmountTry(context) {
    BlocControl counter= BlocProvider.of<BlocControl>(context);
    if(counter.state==1){
      counter.add(BlocEvents.lastValue);
    }else{
      counter.add(BlocEvents.decrement);
    }
  }
  void addAmountTry(productInStock,context) {
    BlocControl counter= BlocProvider.of<BlocControl>(context);
    if(counter.state<productInStock){
      counter.add(BlocEvents.increment);
    }else{
      num number= counter.state;
        number=productInStock;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(' There is only $productInStock items available ,thank you for your patience ! '),
        ));

    }
  }

  void addAmount(productInStock) {
    if(amount<productInStock){
      setState(() {
        amount++;
      });
    }else{
      setState(() {
        amount=productInStock;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(' There is only $productInStock items available ,thank you for your patience ! '),
        ));
      });
    }
  }

  void AddToDataBase({pname, ptitle, pimage, pprice, ptotal,pamount,instock,pid})async {
   // DbModel model=DbModel({'name':pname,'title':ptitle,'image':pimage,'price':pprice,'total':ptotal,'amount':pamount});
    DbModel model=DbModel(pname, ptitle, pimage, pprice, pamount, ptotal,instock,pid);
  int id=  await helper.insertData(model);
  print('id is $id');
  }
}
