import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder:(context, state) {

        var model = ShopCubit.get(context).loginModel;

        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return  ConditionalBuilder(
          condition: ShopCubit.get(context).loginModel !=null ,
          builder: (context) {
            return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is UpdateProfileLoadingState) const LinearProgressIndicator(),
                    horizontalSpace(5),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'Name',
                      prefixIcn: Icons.person,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                    ),
                    horizontalSpace(3),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email Address',
                      prefixIcn: Icons.email,
                      validate: (value) {
                        if(value.isEmpty){
                          return 'Email Address must not be empty';
                        }
                        return null;
                      },
                    ),
                    horizontalSpace(3),
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
                    horizontalSpace(5),
                    defaultButton(
                      function: (){
                        if(formKey.currentState!.validate()){
                          ShopCubit.get(context).updateProfileInfo(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      textData: 'Update Profile Info',
                    ),
                    horizontalSpace(5),
                    defaultButton(
                      function: (){
                        signOut(context);
                      },
                      textData: 'LogOut',
                    ),
                  ],
                ),
              ),
            ),
          );
          },
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
