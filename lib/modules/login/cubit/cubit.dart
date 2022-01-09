import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates>{

 LoginCubit () : super(LogInitialState());

 static LoginCubit get(context) => BlocProvider.of(context);


}