

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
 Widget deafultButton({
  Color background = Colors.deepPurple,
  double width =double.infinity,
  required double height,
  required Function function,
  required String text,
  bool isUpperCase = true,
  double radius = 0.0,
}) =>Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
      ),
    );


Widget TextFormFeild({
  required String label,
  required String hint,
  IconData? prefix,
  IconData? suffix,
  required Function validate,
  TextEditingController? controller,
  required TextInputType type,
  Function? onSubmit,
  bool isPassword = false,
  Function? SuffixPressed,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  SuffixPressed!();
                },
                icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
      keyboardType: type,
      onFieldSubmitted: (value) {
        onSubmit;
      },
      validator: (value) {
        return validate(value);
      },
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,

})=> AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_back_ios_new_outlined),
  ),
  titleSpacing: 0.0,
  title: Text(title!,style: TextStyle(color: Colors.deepPurple),),
  actions: actions,
);



void navigateTo(context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

void navigateAndFinish(context, Widget screen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false,
  );
}

