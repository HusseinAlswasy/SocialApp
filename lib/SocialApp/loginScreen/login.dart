
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/SocialApp/Home/social_layout.dart';
import 'package:socialapp/SocialApp/loginScreen/cubit/states.dart';
import '../../shared/components/componentes.dart';
import '../../shared/network/local/chahe_helper.dart';
import '../SingUp/ٍsingup.dart';
import 'cubit/cubit.dart';


class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passWord = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorStates) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialLoginSuccessStates) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateAndFinish(
                context,
                SocialLayout(),
              );
            });
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
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.deepPurple),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Login now to Communicate with friends',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 40,
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
                            suffix: SocialLoginCubit.get(context).suffix,
                            isPassword:
                                SocialLoginCubit.get(context).isPasswordShow,
                            controller: passWord,
                            type: TextInputType.visiblePassword,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Password Not be Empty!!';
                              }
                              return null;
                            },
                            SuffixPressed: () {
                              SocialLoginCubit.get(context)
                                  .ChangePasswordVisibility();
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          deafultButton(
                            background: Colors.deepPurple,
                            width: double.infinity,
                            height: 50,
                            function: () {
                              if (formkey.currentState!.validate()) {
                                print(emailController.text);
                                print(passWord.text);
                                SocialLoginCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passWord.text,
                                );
                              }
                            },
                            text: 'Login',
                            radius: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an acoount ?'),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, SignUpScreen());
                                },
                                child: const Text(
                                  'SingUp',
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
            ),
          );
        },
      ),
    );
  }
}
