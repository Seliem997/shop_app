import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';

navigateTo(context, Widget widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ));
}

navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => widget,
    ),
    (Route<dynamic> route) => false,
  );
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefixIcn,
  required FormFieldValidator validate,
  Function(dynamic)? onSubmit,
  Function(dynamic)? onChange,
  GestureTapCallback? tap,
  bool isPassword= false,
  IconData? suffixIcn,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: tap,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsetsDirectional.only(start: 10.w,bottom: 5.h),
        labelText: label,
        prefixIcon: Icon(
          prefixIcn,
        ),
        suffixIcon: suffixIcn!=null ?
        IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffixIcn,
          ),
        ) : null ,
        border:  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  double radius = 5,
  Color backgroundButton = kDefaultColor,
  bool isUpperCase = true,
  required VoidCallback function,
  required String textData,
}) {
  return Container(
    width: width,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        isUpperCase ? textData.toUpperCase() : textData,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    decoration: BoxDecoration(
      color: backgroundButton,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

Widget horizontalSpace(double height) => SizedBox(height: height.h,);
Widget verticalSpace(double width) => SizedBox(height: width.w,);
