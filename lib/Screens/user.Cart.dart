import 'package:amit_ecommerce/Database/DbHelper.dart';
import 'package:amit_ecommerce/Database/DbModel.dart';
import 'package:amit_ecommerce/Screens/user_categories.dart';
import 'package:amit_ecommerce/bloc/bloc_control.dart';
import 'package:amit_ecommerce/bloc/bloc_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../consonants.dart';
import 'menu_screen.dart';

class UserCart extends StatefulWidget {
  static String id = 'cartScreen';
  @override
  _UserCartState createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  DbHelper helper;
  var totals;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper = DbHelper();


  }

  @override
  Widget build(BuildContext context) {
    double heightMedia = MediaQuery.of(context).size.height;
    double widthMedia = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KMainColor,

      body: Column(
        children: [
          Container(
            height: heightMedia-heightMedia*.15218,
            child: Stack(
              children: [
                FutureBuilder<List<DbModel>>(
                    future: helper.getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error.toString());
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState != ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {

                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data.length == 0) {
                              return Center(
                                  child: Column(
                                children: [
                                  Text('Your cart is empty !'),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(
                                              KButtonColor)),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, UserCategories.id);
                                      },
                                      child: Text('Start Shopping Now !'))
                                ],
                              ));
                            } else {
                              num totalPrice=0;
                              List<DbModel>listPrice= snapshot.data;
                              for(var item in listPrice){
                                totalPrice=totalPrice+item.total*item.amount;

                                print('total list price is $totalPrice');
                                print('item price is ${item.total}');

                              }
                               totals= totalPrice;
                              print(totals);
                              DbModel product = snapshot.data[index];
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: heightMedia * .2,
                                          width: widthMedia * .28,
                                          child: Image(
                                            image: NetworkImage(product.image),
                                            fit: BoxFit.cover,
                                          )),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${product.title}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0, right: 6.0, top: 6.0),
                                              child: Text(
                                                '${product.name}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'In Stock :- ${product.inStock} ',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      Text(
                                                        '${(product.total).toString()} EGP',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: KButtonColor),
                                                      ),
                                                      Text(
                                                        'Total = ${product.total*product.amount} EGP',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.normal),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .indeterminate_check_box_outlined,
                                                            size: 30,
                                                            color: KButtonColor,
                                                          ),
                                                          onPressed: () {
                                                            minusAmount(product.amount,product.name,product.title,product.image,
                                                                product.price,product.total,product.inStock,product.id);
                                                            setState(() {
                                                              totals= totalPrice;
                                                            });
                                                            //  prov.minusAmount(amount);
                                                            //    minusAmount();
                                                          }),
                                                      Text(
                                                        '${product.amount}',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons.add_box_outlined,
                                                            size: 30,
                                                            color: KButtonColor,
                                                          ),
                                                          onPressed: () {
                                                            addAmount(product.amount,product.inStock,product.name,product.title,product.image,
                                                            product.price,product.total,product.inStock,product.id
                                                            );
                                                            setState(() {
                                                              totals= totalPrice;
                                                            });
                                                            //addAmount(product.amount,product.inStock);
                                                            //  prov.addAmount(amount);
                                                            //addAmount(product.pInStock);
                                                          }),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),

                                            Container(
                                              height: 30,
                                              width: 100,
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty.all(Colors.black45)),
                                                  onPressed: () {
                                                    setState(() {
                                                      helper.deleteProduct(product.id);
                                                    });
                                                  },
                                                  child: Text(
                                                    'Remove item',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 11),
                                                  )),
                                            ),
                                           Divider(thickness: 1,)
                                          ],
                                        ),
                                      )
                                    ],
                                  ));
                            }
                          },
                        );
                      } else if (snapshot.data.length == 0) {
                        return Center(
                            child: Column(
                          children: [
                            Text('Your cart is empty !'),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(KButtonColor)),
                                onPressed: () {
                                  Navigator.pushNamed(context, UserCategories.id);
                                },
                                child: Text('Start Shopping Now !'))
                          ],
                        ));
                      } else {
                        return Center(
                            child:
                                Text('Kindly, send us a screen shot with the error'));
                      }
                    }),

              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: widthMedia*.4,
                child: ElevatedButton(
                    style: ButtonStyle(

                        backgroundColor: MaterialStateProperty.all(KButtonColor)),
                    onPressed: () {
                     setState(() {
                       helper.deleteAll();
                     });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          'Clear Cart',
                          style: TextStyle(color: Colors.white,fontSize: 18),
                        )
                      ],
                    )),
              ),
              Container(
                width: widthMedia*.4,
                child: ElevatedButton(
                    style: ButtonStyle(

                        backgroundColor: MaterialStateProperty.all(KButtonColor)),
                    onPressed: () {
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order Submitted Successfully !')));

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          'Confirm Order',
                          style: TextStyle(color: Colors.white,fontSize: 18),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void minusAmount(amount,name,title,image,price,total,inStock,pid) {
    if(amount==1){
      setState(() {
        amount=1;
      });
    }else{
      DbHelper dbHelper=DbHelper();

      setState(() {
        amount--;
        DbModel model= DbModel(name, title, image, price, amount, total, inStock,pid);
        dbHelper.updateProduct(model);
      });
    }
  }

  void addAmount(amount,productInStock,name,title,image,price,total,inStock,pid) {
    DbHelper dbHelper=DbHelper();
    if(amount<productInStock){
      setState(() {
        amount++;

        DbModel model= DbModel(name, title, image, price, amount, total, inStock,pid);
        dbHelper.updateProduct(model);
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


}
/*
ListTile(
                      title: Text('${product.title}',
                      maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: Container(
                          height: heightMedia*.5,
                          width: widthMedia*.25,
                          child: Image(image: NetworkImage(product.image),fit: BoxFit.cover,)),
                    ),
 */
