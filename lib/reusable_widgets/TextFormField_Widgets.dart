import 'package:flutter/material.dart';

class EmailAndPassField extends StatelessWidget {
  const EmailAndPassField({
    Key key,
    @required this.widthMedia,
    @required this.heightMedia,
    this.prefix,
    this.suffix,
    this.hint,
    this.suffixFunc,
    this.validator,
    this.controller,
    this.obsecure
  }) : super(key: key);

  final double widthMedia;
  final double heightMedia;
  final IconData prefix;
 final IconData suffix;
 final String hint;
 final Function suffixFunc;
  final bool obsecure;
 final Function validator;
 final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Container(
        width: widthMedia*.8,
        child: TextFormField(
          obscureText: obsecure,
          controller:controller ,
          validator:validator ,
          cursorColor: Colors.black45,
          decoration: InputDecoration(
            suffixIcon: IconButton(icon: Icon(suffix,color: Colors.black45,),
            onPressed:suffixFunc ,
            ),
            prefixIcon: Icon(prefix,color: Colors.black45,),
            hintText: hint,
            border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.black54,
                    style: BorderStyle.solid
                )

            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.black54,
                    style: BorderStyle.solid
                )

            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.black54,
                    style: BorderStyle.solid
                )

            ),
          ),
        ));
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key key,
    @required this.widthMedia,
    @required this.heightMedia,
    this.prefix,
    this.hint,

    this.validator,
    this.controller
  }) : super(key: key);

  final double widthMedia;
  final double heightMedia;
  final IconData prefix;

  final String hint;
  final Function validator;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Container(
        width: widthMedia*.8,
        child: TextFormField(

          controller:controller ,
          validator:validator ,
          cursorColor: Colors.black45,
          decoration: InputDecoration(

            prefixIcon: Icon(prefix,color: Colors.black45,),
            hintText: hint,
            border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.black54,
                    style: BorderStyle.solid
                )

            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.black54,
                    style: BorderStyle.solid
                )

            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.black54,
                    style: BorderStyle.solid
                )

            ),
          ),
        ));
  }
}
