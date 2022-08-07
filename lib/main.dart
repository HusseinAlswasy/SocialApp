

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialapp/SocialApp/Home/cubit/state.dart';
import 'package:socialapp/SocialApp/SingUp/cubit/cubit.dart';
import 'package:socialapp/SocialApp/loginScreen/login.dart';
import 'package:socialapp/shared/components/componentes.dart';
import 'package:socialapp/shared/components/constent.dart';
import 'package:socialapp/shared/network/local/chahe_helper.dart';
import 'package:socialapp/shared/network/remote/dio_helper.dart';
import 'package:socialapp/shared/styles/theme.dart';
import 'SocialApp/Home/cubit/cubit.dart';
import 'SocialApp/Home/social_layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> fm(RemoteMessage message)async{
print('on background messaging oppened app');
print(message.data.toString());

showToast(text: 'on background messaging oppened app', state: ToastStates.SUCCESS);
}

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message oppend app', state: ToastStates.SUCCESS);

  });
  FirebaseMessaging.onBackgroundMessage(fm);

  DioHelper.init();
  await CacheHelper.init();
  // Bloc.observer = MyBlocObserver();

  uId =CacheHelper.getData(key: 'uId');
  print(uId);

  Widget? widget;
  if(uId != null){
    widget =SocialLayout();
  }else{
    widget =LoginScreen();
  }
  runApp(MyApp(startWidget: widget,));
}


class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({Key? key, this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create:(BuildContext context)=>SocialSignUpCubit(),
        ),
        BlocProvider(
          create:(BuildContext context)=>SocialCubit()..getUserData()..getPost(),
        ),
      ],
      child: BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state) {},
          builder:(context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              home: startWidget,
            );
          }
      ),
    );
  }
}
