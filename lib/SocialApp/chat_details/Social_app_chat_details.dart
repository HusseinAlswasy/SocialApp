import 'package:flutter/material.dart';
import 'package:socialapp/SocialApp/Home/cubit/cubit.dart';
import 'package:socialapp/SocialApp/Home/cubit/state.dart';
import 'package:socialapp/models/messagemodel.dart';
import 'package:socialapp/models/social_user_model.dart';
import 'package:socialapp/shared/styles/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;

  ChatDetailsScreen({
    required this.userModel,
  });

  var MessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context){
        SocialCubit.get(context).getMessages(reciverId: '${userModel.uId}');
        return  BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('${userModel.name}'),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)
                          {
                            var message = SocialCubit.get(context).messages[index];
                             if(SocialCubit.get(context).userModel!.uId==message.senderId)
                               return buildMyMessage(message);

                               return buildMessage(message);
                          },
                          separatorBuilder: (context,index)=>SizedBox(height: 16,),
                          itemCount: SocialCubit.get(context).messages.length,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[300],
                            ),
                            // clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: MessageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type Your Message Here ....',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: deafultcolor,
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: MaterialButton(
                            onPressed: () {
                              SocialCubit.get(context).SendMessage(
                                reciverId:'${userModel.uId}',
                                dateTime:'${DateTime.now().toString()}',
                                text: '${MessageController.text}',
                              );
                            },
                            minWidth: 1,
                            child: Icon(Icons.send, size: 16, color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  Widget buildMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(.3),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(
                '${model.text}'
            ),
          ),
        ),
      );
  Widget buildMyMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(
              '${model.text}'
            ),
          ),
        ),
      );


}
