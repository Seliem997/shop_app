import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! FavoritesLoadingState ,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavoritesItemsList(context, ShopCubit.get(context).favoritesModel!.data!.data[index]),
            separatorBuilder: (context, index) => const Divider(color: kDefaultColor,thickness: 2.2,),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
          ) ,
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Widget buildFavoritesItemsList(context, DataFavoritesModel model){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: double.infinity,
        height: 20.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.productsData!.image}'),
                  width: 35.w,
                  height: 18.h,
                ),
                if( model.productsData!.discount != 0 )
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 4.w,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.productsData!.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.productsData!.price.round()}',
                        style: TextStyle(
                          fontSize: 12,
                          color: kDefaultColor,
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      if(model.productsData!.discount != 0)
                        Text(
                          '${model.productsData!.oldPrice}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: (){
                          print('${model.productsData!.id}');
                          ShopCubit.get(context).changeFavoritesItems(model.productsData!.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: ShopCubit.get(context).favorites[model.productsData!.id] ==true ? kDefaultColor : Colors.brown,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
