
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/SocialApp/Home/cubit/state.dart';
import 'package:socialapp/shared/components/componentes.dart';
import '../Edit_Profile/edit_profile.dart';
import '../newPost/new_post.dart';
import 'cubit/cubit.dart';

class SocialLayout extends StatelessWidget {
  SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPost){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {

        var cubit= SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:Text(cubit.titles[cubit.CurrentIndex]),
            actions: [
              IconButton(onPressed: () {  }, icon: Icon(Icons.notifications_active,color: Colors.deepPurple),),
              IconButton(onPressed: () {  }, icon: Icon(Icons.search,color: Colors.deepPurple,),),
            ],
          ),
          body: cubit.screens[cubit.CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.CurrentIndex,
            onTap: (index){
              cubit.ChangeBottomIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            elevation: 20.0,
            backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                ),
                label: 'chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.upload_file,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.location_on,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'settings',
              ),
            ],

          ),
        );
      },
    );
  }
}