
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';


class LoginScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var emailController=TextEditingController();
    var passwordController=TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if( state is LoginSuccessState ){
            if( state.loginModel.status!){

              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              showToast(message: state.loginModel.message!, state: ToastStates.success);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {

                token = state.loginModel.data!.token;
                navigateAndFinish(context, const ShopLayout());

              });

            }else{

              print(state.loginModel.message);

              showToast(message: state.loginModel.message!, state: ToastStates.error);
            }
          }
        } ,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(backgroundColor: Colors.white,centerTitle: true,title: Text(
              'Welcome Back ...',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                letterSpacing: 1,
                color: kDefaultColor,
              ),
            ),),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      horizontalSpace(3),
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      horizontalSpace(3),
                      Text(
                        'Login now to browse our hot offer',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey),
                      ),
                      horizontalSpace(8),
                      defaultFormField(
                        label: 'Email Address',
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        prefixIcn: Icons.email_outlined,
                        validate: (value) {
                          if(value.isEmpty){
                            return 'PLease, Enter Email address first';
                          }
                        },
                      ),
                      horizontalSpace(3),

                      defaultFormField(

                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'Enter Password',
                        isPassword: LoginCubit.get(context).isPassword,
                        prefixIcn: Icons.lock_outlined,
                        suffixIcn: LoginCubit.get(context).suffixPasswordVisible,

                        suffixPressed: (){
                          LoginCubit.get(context).changePasswordVisibility();
                        },

                        validate: (value){
                          if(value.isEmpty){
                            return 'Password must not be empty';
                          }
                          return null;
                        },

                        onSubmit: (value){
                          if(formKey.currentState!.validate()){
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },

                      ),

                      horizontalSpace(5),

                      Conditional.single(
                        context: context,
                        conditionBuilder:(context) => state is ! LoginLoadingState,
                        widgetBuilder: (context) => defaultButton(
                            function: (){

                              showToast(message: 'message', state: ToastStates.error);  //*************************-----------------------**************************

                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            textData: 'Login',
                        ),
                        fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()),
                      ),
                      horizontalSpace(7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account ?',
                          ),
                          verticalSpace(5),
                          TextButton(
                            onPressed: (){
                              navigateTo(context, RegisterScreen());
                            },
                            child: const Text(
                              'REGISTER!',
                              style: TextStyle(
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
          );
        },
      ),
    );
  }
}
