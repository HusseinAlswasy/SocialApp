import 'package:flutter/material.dart';
import 'package:socialapp/SocialApp/Home/cubit/cubit.dart';
import 'package:socialapp/SocialApp/Home/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:socialapp/SocialApp/chat_details/Social_app_chat_details.dart';
import 'package:socialapp/models/social_user_model.dart';
import 'package:socialapp/shared/components/componentes.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit
              .get(context)
              .users
              .length > 0,
          builder: (context) =>
              ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildChatItem(SocialCubit
                        .get(context)
                        .users[index],context),
                separatorBuilder: (context, index) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 1.0,
                        width: double.infinity,
                        color: Colors.grey.shade100,
                      ),
                    ),
                itemCount: SocialCubit
                    .get(context)
                    .users
                    .length,
              ),
          fallback: (context) =>
              Center(child: const CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildChatItem(SocialUserModel model,context) =>
    InkWell(
      onTap: () {
        navigateTo(context, ChatDetailsScreen(userModel: model,));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              '${model.name}',
              style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
