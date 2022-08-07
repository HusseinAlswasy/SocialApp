import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/SocialApp/Home/cubit/cubit.dart';
import 'package:socialapp/SocialApp/Home/cubit/state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:socialapp/models/post_model.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state)=>{},
      builder: (context,state){
        return ConditionalBuilder(
          condition:SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null,
          builder: (context)=> SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  margin: EdgeInsets.all(7),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: const [
                      Image(
                        width: double.infinity,
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/indoor-photo-satisfied-teenage-girl-texts-cellular-reads-interesting-article-online-wears-casual-outfit-creats-new-publication-own-web-page-isolated-brown-wall-with-free-space_273609-26359.jpg?t=st=1658360328~exp=1658360928~hmac=09615fec24f098d8fb3e0773a8b0e96d2fdb7853224d70d26eec0db4f16f535a&w=740'),
                        fit: BoxFit.cover,
                        height: 180,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Commmunication with friends',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder: (context,index)=>SizedBox(height: 10,),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(height:10,),
              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model,context,index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 7),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        '${model.image}',
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.verified,
                              color: Colors.blueAccent,
                              size: 15,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 19,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: double.infinity,
                  height: 0.1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10, top: 5),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 10),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               height: 25,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Medical',
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 12,
              //                   height: 1.3,
              //                   color: Colors.blue,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 10),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               height: 25,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software',
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 12,
              //                   height: 1.3,
              //                   color: Colors.blue,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 10),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               height: 25,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#hardware',
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 12,
              //                   height: 1.3,
              //                   color: Colors.blue,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(model.postImage != '')
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                            '${model.postImage}'),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                size: 16,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).Likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          SocialCubit.get(context).LikePost(SocialCubit.get(context).postsId[index]);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                size: 16,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '0 comments',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          //SocialCubit.get(context).LikePost(SocialCubit.get(context).postsId[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 0.1,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel!.image}'),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Write a Comments...',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 16,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Love',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
