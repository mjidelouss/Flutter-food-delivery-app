import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/small_text.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_text__widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26),
        SizedBox(height: Dimensions.height10),
        //comments section
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => const Icon(Icons.star, color: AppColors.mainColor,)),
            ),
            const SizedBox(width: 10),
            SmallText(text: "4.5"),
            const SizedBox(width: 10),
            SmallText(text: "267"),
            const SizedBox(width: 10),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Dimensions.height20),
        // time and distance section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndTextWidget(icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on,
                text: "1.2km",
                iconColor: AppColors.mainColor),
            IconAndTextWidget(icon: Icons.access_time_rounded,
                text: "25min",
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
