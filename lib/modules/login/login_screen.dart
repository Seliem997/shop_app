import 'package:flutter/material.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isPassword=true;
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {

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
            isPassword: isPassword,
            prefixIcn: Icons.lock_outlined,
            suffixIcn: isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            suffixPressed: (){
              setState(() {
                isPassword=!isPassword;
              });
            },
            validate: (value){
              if(value.isEmpty){
                return 'Password must not be empty';
              }
              return null;
            },),
              horizontalSpace(5),
              defaultButton(function: (){}, textData: 'Login'),
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
                        navigateTo(context, const RegisterScreen());
                      },
                      child: const Text('Register!',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
