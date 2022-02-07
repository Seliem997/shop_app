import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:sizer/sizer.dart';

import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool? onBoarding = CacheHelper.returnData(key: 'onBoarding');
  token = CacheHelper.returnData(key: 'token');
  print(token);

  if(onBoarding != null){
    if(token != null){
      widget = const ShopLayout();
    } else{
      widget = LoginScreen();
    }
  } else{
    widget = const OnBoardingScreen();
  }

  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {

  // final bool? onBoarding;
  final Widget startWidget;

  const MyApp({Key? key, /*this.onBoarding,*/ required this.startWidget,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getProfileInfo(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home:startWidget,
          );
        },
      ),
    );
  }
}
