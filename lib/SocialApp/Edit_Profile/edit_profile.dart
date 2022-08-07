


import 'package:flutter/material.dart';
import 'package:socialapp/SocialApp/Home/cubit/state.dart';
import 'package:socialapp/shared/components/componentes.dart';
import '../Home/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EditPostScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = SocialCubit.get(context).userModel;
          var profileImage = SocialCubit.get(context).profileImage;
          var profileCover = SocialCubit.get(context).profileCover;

          nameController.text = userModel!.name!;
          bioController.text = userModel.bio!;

          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(
                  function: () {
                    SocialCubit.get(context).updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                  },
                  text: 'UPDATE',
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is SocialUserLoadingUpdatePost)
                    LinearProgressIndicator(),
                    if(state is SocialUserLoadingUpdatePost)
                      SizedBox(height: 10,),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 210,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 160,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          topLeft: Radius.circular(5),
                                        ),
                                        image: DecorationImage(
                                          image:profileCover == null ?NetworkImage('${userModel.cover}') :FileImage(profileCover) as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topCenter,
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 65,
                                    backgroundColor:
                                        Theme.of(context).scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage: profileImage == null ?NetworkImage('${userModel.image}') :FileImage(profileImage) as ImageProvider,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getProfileImage();
                                    },
                                    icon: const CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileCover();
                              },
                              icon: CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if(SocialCubit.get(context).profileImage != null ||SocialCubit.get(context).profileCover!= null )
                    Row(
                      children: [
                        if(SocialCubit.get(context).profileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              deafultButton(
                                  function: (){SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text,);},
                                  text: 'UPLOAD IMAGE',
                                  height:40,radius: 6,
                              ),
                              if(state is SocialUserLoadingUpdatePost)
                              SizedBox(height: 4,),
                              if(state is SocialUserLoadingUpdatePost)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5,),
                        if(SocialCubit.get(context).profileCover != null)
                        Expanded(
                          child: Column(
                            children: [
                              deafultButton(
                                function: (){SocialCubit.get(context).uploadProfileCover(name: nameController.text, phone: phoneController.text, bio: bioController.text,);},
                                  text: 'UPLOAD COVER',
                                  height:40,radius: 6,
                              ),
                              if(state is SocialUserLoadingUpdatePost)
                                SizedBox(height: 4,),
                              if(state is SocialUserLoadingUpdatePost)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ]
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormFeild(
                      label: 'Name',
                      hint: 'Name',
                      validate: (String? value) {
                        if(value!.isEmpty){
                          return 'name must be not empty';
                        }
                        return null;
                      },
                      type: TextInputType.name,
                      prefix: Icons.person_outline_sharp,
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormFeild(
                      label: 'Bio',
                      hint: 'Bio',
                      validate: (String? value) {
                        if(value!.isEmpty){
                          return 'Bio must be not empty';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                      prefix: Icons.info_outline_rounded,
                      controller: bioController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormFeild(
                      label: 'Phone',
                      hint: 'Phone',
                      validate: (String? value) {
                        if(value!.isEmpty){
                          return 'Phone must be not empty';
                        }
                        return null;
                      },
                      type: TextInputType.phone,
                      prefix: Icons.phone,
                      controller: phoneController,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
