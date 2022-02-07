import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
        itemBuilder: (context, index) => buildCategoriesList(ShopCubit.get(context).categoriesModel!.data!.data[index]),
        separatorBuilder: (context, index) => const Divider(
          color: kDefaultColor,
          thickness: 1.5,
        ),
        itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
      ),
    );
  }

  Widget buildCategoriesList(DataCategoriesData dataCategoriesData){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            height: 15.h,
            width: 25.w,
            image: NetworkImage(
              '${dataCategoriesData.image}'
            ),
            fit: BoxFit.cover,
          ),
          SizedBox(width: 3.w,),
          Text(
            '${dataCategoriesData.name}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
          ),

        ],
      ),
    );
  }
}
