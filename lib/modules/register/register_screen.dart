import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
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
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      'Register',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    horizontalSpace(3),

                    Text(
                      'Login now to browse our hot offer',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey),
                    ),

                    horizontalSpace(5),

                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'Name',
                      prefixIcn: Icons.person,
                      validate: (value){
                        if(value.isEmpty){
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                    ),

                    horizontalSpace(2),

                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email Address',
                      prefixIcn: Icons.email,
                      validate: (value){
                        if(value.isEmpty){
                          return 'Email Address must not be empty';
                        }
                        return null;
                      },
                    ),

                    horizontalSpace(2),

                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      prefixIcn: Icons.phone,
                      validate: (value){
                        if(value.isEmpty){
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                    ),

                    horizontalSpace(2),

                    defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      label: 'Password',
                      prefixIcn: Icons.password,
                      suffixIcn: RegisterCubit.get(context).suffixPasswordVisible,
                      isPassword: RegisterCubit.get(context).isPassword,
                      suffixPressed: (){
                        RegisterCubit.get(context).changePasswordVisibility();
                      },
                      validate: (value){
                        if(value.isEmpty){
                          return 'Password must not be empty';
                        }
                        return null;
                      },
                    ),

                    horizontalSpace(7),

                    ConditionalBuilder(
                      condition: state is! RegisterLoadingState,
                      builder: (context) => defaultButton(
                        function: (){
                          if(formKey.currentState!.validate()){
                            RegisterCubit.get(context).userRegister(
                                email : emailController.text,
                                name : nameController.text,
                                phone : phoneController.text,
                                password : passwordController.text,
                            );
                          }
                        },
                        textData: 'REGISTER',
                      ),
                      fallback: (context) => const Center(child: CircularProgressIndicator()) ,
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
