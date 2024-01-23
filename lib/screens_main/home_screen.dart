import 'package:book_tickets_app/screens_main/hotels_view.dart';
import 'package:book_tickets_app/screens_main/tickets_view.dart';
import 'package:book_tickets_app/utils/app_info_list.dart';
import 'package:book_tickets_app/utils/app_styles.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utils/app_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good morning", style: Styles.headlineStyle3,),
                        const Gap(5),
                        Text("Anh Nguyen Chi", style: Styles.headlineStyle,),
                      ],
                    ),
                    Container(
                      height: AppLayout.getHeight(50),
                      width: AppLayout.getHeight(50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppLayout.getHeight(10)),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/img_1.png")
                          )
                      ),
                    )
                  ],
                ),
                const Gap(25),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppLayout.getHeight(10)),
                      color: const Color(0xFFF4F6FD)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    children: [
                      const Icon(FluentSystemIcons.ic_fluent_search_regular, color: Color(0xFFBFC205),),
                      Text("Search", style: Styles.headlineStyle4,)
                    ],
                  ),
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Upcoming flights", style: Styles.headlineStyle2,),
                    InkWell(
                        onTap: (){
                        },
                        child: Text("View all", style: Styles.textStyle.copyWith(color: Styles.primaryColor),))
                  ],
                )
              ],
            ),
          ),
          const Gap(15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            child: Row(
                children: ticketList.map((ticket) => TicketView(ticket: ticket)).toList()
            ),
          ),
          const Gap(15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20) ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hotels", style: Styles.headlineStyle2,),
                InkWell(
                    onTap: (){
                    },
                    child: Text("View all", style: Styles.textStyle.copyWith(color: Styles.primaryColor),))
              ],
            ),
          ),
          const Gap(15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding:const EdgeInsets.only(left: 20),
            child: Row(
                children:hotelList.map((hotel) => HotelView(hotel: hotel)).toList()
            ),
          ),
        ],
      ),
    );
  }
}
