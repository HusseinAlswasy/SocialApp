
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/SocialApp/Home/social_layout.dart';
import 'package:socialapp/SocialApp/SingUp/cubit/states.dart';
import 'package:socialapp/SocialApp/loginScreen/login.dart';
import 'package:socialapp/shared/components/componentes.dart';

import 'cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class SignUpScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passWord = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialSignUpCubit(),
      child: BlocConsumer<SocialSignUpCubit, SocialSignUpStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, SocialLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SignUp',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.deepPurple),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'SignUp now to Communicate with friends',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormFeild(
                          label: 'Name',
                          hint: 'Name',
                          controller: name,
                          prefix: Icons.drive_file_rename_outline,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Name Not be Empty!!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormFeild(
                          label: 'Email',
                          hint: 'Email',
                          prefix: Icons.email,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Email Not be Empty!!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormFeild(
                          label: 'Password',
                          hint: 'Password',
                          prefix: Icons.lock,
                          suffix: SocialSignUpCubit.get(context).suffix,
                          isPassword:
                              SocialSignUpCubit.get(context).isPasswordShow,
                          controller: passWord,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password Not be Empty!!';
                            }
                            return null;
                          },
                          SuffixPressed: () {
                            SocialSignUpCubit.get(context)
                                .ChangePasswordVisibility();
                          },
                        ),
                         SizedBox(
                          height: 10,
                        ),
                        TextFormFeild(
                          label: 'Phone',
                          hint: 'Phone',
                          prefix: Icons.phone,
                          controller: phone,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Phone Not be Empty!!';
                            }
                            return null;
                          },
                        ),
                         SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition:
                              state is! SocialSignUpLoadingHomeDataStates,
                          builder: (context) => deafultButton(
                            height: 50,
                            function: () {
                              if (formkey.currentState!.validate()) {
                                print(emailController.text);
                                print(passWord.text);
                                SocialSignUpCubit.get(context).userRegister(
                                  name: name.text,
                                  email: emailController.text,
                                  password: passWord.text,
                                  phone: phone.text,
                                );
                              }
                            },
                            text: 'SignUp',
                            radius: 30,
                          ),
                          fallback: (context) =>
                               Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text('You have an account ?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, LoginScreen());
                              },
                              child:  Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
