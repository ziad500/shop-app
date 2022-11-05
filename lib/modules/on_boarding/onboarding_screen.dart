import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/network/remote/cashe_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      title: 'Explor',
      body:
          'Choose whatever The Product you Wish For The Easiest Way Possible Using Shop.',
      image: 'images/onboard3.jpg',
    ),
    BoardingModel(
      title: 'Shiping',
      body:
          'Your Order Will be Shipped To You As Fast As Possible By Our Carrier.',
      image:
          'images/business-concept-online-store-buying-and-selling-vector-25230465.jpg',
    ),
    BoardingModel(
      title: 'Payment',
      body: 'Pay With The Safest Way Possible Either By Cash Or Credit Cards.',
      image:
          'images/document-purchase-customer-purchaser-deal-buying-contract-bill-sale-written-selling-document-execution-sales-contract-concept_335657-226.jpg',
    ),
  ];

  bool isLast = false;

  void submit() {
    CasheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value == true) navigateAndFinish(context, LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: submit,
                child: const Text(
                  'SKIP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardcontroller,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardcontroller,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                        dotHeight: 10.0,
                        dotColor: Colors.grey,
                        expansionFactor: 4,
                        dotWidth: 10.0,
                        spacing: 5.0,
                        activeDotColor: defaultColor),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast == true) {
                        submit();
                      } else {
                        boardcontroller.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          Text(
            model.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Color(0xff00000099)),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          )
        ],
      );
}
