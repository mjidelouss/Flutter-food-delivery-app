import 'package:flutter/cupertino.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class NoDataPage extends StatelessWidget {
  final String imgPath;
  const NoDataPage({Key? key, this.imgPath="assets/images/empty-cart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(RouteHelper.getInitial());
      },
      child: ListView(
          children: [
            Image.asset(
              imgPath,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
    );
  }
}
