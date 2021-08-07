import 'package:amit_ecommerce/Screens/admin_addCategory.dart';
import 'package:amit_ecommerce/consonants.dart';
import 'package:flutter/material.dart';
class AdminHomePage extends StatelessWidget {
  static String id='AdminHomePage';
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
        title: Text('Products&Orders',style: TextStyle(
          color: KButtonColor
        ),),
        centerTitle: true,
        backgroundColor: KMainColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: heightMedia*.02),
              child: Container(
                width: widthMedia*.3,
                child: ElevatedButton( child: Text('Add Product',style:
                TextStyle(
                    fontSize: 14
                )
                  ,),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(KButtonColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                  ),
                  onPressed: (){
                  Navigator.pushNamed(context, AddCategory.id);
                  },
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: heightMedia*.02),
              child: Container(
                width: widthMedia*.3,
                child: ElevatedButton( child: Text('Edit Products',style:
                TextStyle(
                    fontSize: 14
                )
                  ,),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(KButtonColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                  ),
                  onPressed: (){

                  },
                ),
              ),
            ),
            SizedBox(width: widthMedia*.05,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: heightMedia*.02),
              child: Container(
                width: widthMedia*.3,
                child: ElevatedButton( child: Text('View Orders',style:
                TextStyle(
                    fontSize: 14
                )
                  ,),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(KButtonColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                  ),
                  onPressed: (){

                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
