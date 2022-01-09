import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding=[
    BoardingModel('Text 1', 'assets/images/splash_1.png', 'Text body 1'),
    BoardingModel('Text 2', 'assets/images/splash_2.png', 'Text body 2'),
    BoardingModel('Text 3', 'assets/images/splash_3.png', 'Text body 3'),
  ];

  var boardController = PageController();
  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: (){
                navigateAndFinish(context, const LoginScreen());
              },
              child: const Text(
                'SKIP',
                style: TextStyle(letterSpacing: 1),
              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildBoardingItem(context, boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index){
                  if(index == boarding.length - 1){

                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 5.h,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    activeDotColor: kDefaultColor,
                  ),
                  count: boarding.length,

                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      navigateAndFinish(context, const LoginScreen());
                    }
                    boardController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(context, BoardingModel model){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: Image(
              image: AssetImage(model.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10.h,),
        Text(
          model.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(height: 5.h,),
        Text(
          model.body,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: 5.h,),

      ],
    );
  }
}

class BoardingModel{
  final String title;
  final String image;
  final String body;

  BoardingModel(this.title, this.image, this.body);
}