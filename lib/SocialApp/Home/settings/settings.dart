
import 'package:flutter/material.dart';
import 'package:socialapp/SocialApp/Home/cubit/cubit.dart';
import 'package:socialapp/SocialApp/Home/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/componentes.dart';
import '../../Edit_Profile/edit_profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class settings extends StatelessWidget {
  const settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){},
      builder:(context,state)
      {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 210,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${userModel?.cover}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          '${userModel?.image}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6,),
              Text(
                '${userModel?.name}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4,),
              Text(
                '${userModel?.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: const [
                            Text('100',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('Posts',style: TextStyle(fontSize: 16,color: Colors.grey),),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: const [
                            Text('10k',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('follower',style: TextStyle(fontSize: 16,color: Colors.grey),),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: const [
                            Text('1200',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            Text("following",style: TextStyle(fontSize: 16,color: Colors.grey),),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: const [
                            Text('100',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('photos',style: TextStyle(fontSize: 16,color: Colors.grey),),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: Text('ADD PHOTO'),
                    ),
                  ),
                  SizedBox(width: 4,),
                  OutlinedButton(
                    onPressed: (){
                      navigateTo(context, EditPostScreen());
                    },
                    child:Icon(Icons.edit,size:18,),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(onPressed: (){
                    FirebaseMessaging.instance.subscribeToTopic('announcements');
                  }, child: Text('Subscribe')),
                  SizedBox(width: 10,),
                  OutlinedButton(onPressed: (){
                    FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                  }, child: Text('UnSubscribe')),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}
