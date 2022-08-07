

import '../network/local/chahe_helper.dart';

void singout(context){
  CacheHelper.removeDate(
    key: 'token',
  ).then((value) {
    if (value) {
      //navigateAndFinish(context, ShopAppLogin());
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1.800}');
  pattern.allMatches(text).forEach((element)=> print(element.group(0)));
}

String? token=''; //علشان وانا بجيب token احطة فيه
String? uId;