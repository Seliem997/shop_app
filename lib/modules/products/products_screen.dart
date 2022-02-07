import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var cubit = ShopCubit.get(context);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is HomeSuccessChangeFavoritesState){
          if(state.model.status==false){
            showToast(message: state.model.message!, state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.homeModel != null && cubit.categoriesModel != null ,
          widgetBuilder: (context) => productsBuilder(cubit.homeModel!, cubit.categoriesModel!, context),
          fallbackBuilder: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel ,context){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data!.banners.map((e) =>  Image(
                image: NetworkImage('${e.image}'),
                fit: BoxFit.cover,
                width: double.infinity,
              ),).toList(),
              options: CarouselOptions(
                height: 25.h,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(height: 2.h,),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kDefaultColor),
                ),
                SizedBox(height: 2.h,),
                SizedBox(
                  height: 15.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildCategoryItems(context, categoriesModel.data!.data[index]),
                    separatorBuilder: (context, index) => SizedBox(width: 3.w,),
                    itemCount: categoriesModel.data!.data.length,
                  ),
                ),
                SizedBox(height: 3.h,),
                Text(
                  'New Products',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kDefaultColor),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/1.45,
              children: List.generate(
                model.data!.products.length,
                (index) => buildGridProduct(context, model.data!.products[index]),),

            ),
          ),
        ],
      ),
    );

  }
  Widget buildCategoryItems(context, DataCategoriesData dataCategoriesData) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage('${dataCategoriesData.image}'),
        height: 15.h,
        width: 30.w,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 30.w,
        child: Text(
          '${dataCategoriesData.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
        ),
      ),
    ],
  );

  Widget buildGridProduct(context, ProductsModel model) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage('${model.image}'),
              width: double.infinity,
              height: 23.h,
            ),
            if( model.discount != 0 )
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: kDefaultColor,
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  if(model.discount != 0)
                    Text(
                    '${model.oldPrice.round()}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
              ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){
                      print(model.id);
                      ShopCubit.get(context).changeFavoritesItems(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favorites[model.id]==true ? kDefaultColor : Colors.brown,
                      child: const Icon(
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
  );
}
