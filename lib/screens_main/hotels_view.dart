import 'package:book_tickets_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_layout.dart';

class HotelView extends StatelessWidget {
  final Map<String, dynamic> hotel;
  const HotelView({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width*0.6,
      height: AppLayout.getHeight(390),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      margin: const EdgeInsets.only(right: 17, top: 5),
      decoration: BoxDecoration(
          color: Styles.primaryColor,
          borderRadius: BorderRadius.circular(AppLayout.getHeight(24)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 20,
                spreadRadius: 1
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AppLayout.getHeight(200),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppLayout.getHeight(12)),
                color: Styles.primaryColor,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/${hotel['image']}")
                )
            ),
          ),
          const Gap(10),
          Text(hotel['place'], style: Styles.headlineStyle2.copyWith(color: Styles.kakiColor),),
          const Gap(5),
          Text(hotel['destination'], style: Styles.headlineStyle3.copyWith(color: Colors.white),),
          const Gap(8),
          Text('${hotel['price']}VND/night', style: Styles.headlineStyle.copyWith(color: Styles.kakiColor),),
        ],
      ),
    );
  }
}
