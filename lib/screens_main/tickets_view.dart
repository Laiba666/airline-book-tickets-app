import 'package:book_tickets_app/utils/app_layout.dart';
import 'package:book_tickets_app/utils/app_styles.dart';
import 'package:book_tickets_app/widgets/thick_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TicketView extends StatelessWidget {
  final Map<String, dynamic> ticket;
  const TicketView({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      width: size.width*0.85,
      height: AppLayout.getHeight(200),
      child: Container(
        margin: EdgeInsets.only(right: AppLayout.getHeight(16)),
        child: Column(
          children: [
            //Blue part of the ticket
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF526799),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(AppLayout.getHeight(21)),
                      topRight: Radius.circular(AppLayout.getHeight(21)))
              ),
              padding:  EdgeInsets.all(AppLayout.getHeight(17)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(ticket['from']['code'], style: Styles.headlineStyle3.copyWith(color: Colors.white),),
                      const Spacer(),
                      const ThickContainer(),
                      Expanded(child: Stack(
                        children: [
                          SizedBox(
                            height: AppLayout.getHeight(24),
                            child: LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints ) {
                                return Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate((constraints.constrainWidth()/6).floor(), (index) => SizedBox(
                                    width: AppLayout.getWidth(3), height: AppLayout.getHeight(1), child: const DecoratedBox(decoration: BoxDecoration(color: Colors.white),),
                                  )),
                                );
                              },
                            ),
                          ),
                          Center(child: Transform.rotate(angle: 1.5, child: const Icon(Icons.local_airport_rounded, color: Colors.white,))),
                        ],
                      )),
                      const ThickContainer(),
                      const Spacer(),
                      Text(ticket['to']['code'], style: Styles.headlineStyle3.copyWith(color: Colors.white),),
                    ],
                  ),
                  const Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: AppLayout.getWidth(100),
                        child: Text(ticket['from']['name'], style: Styles.headlineStyle4.copyWith(color: Colors.white),),
                      ),
                      Text(ticket['flying_time'], style: Styles.headlineStyle4.copyWith(color: Colors.white),),
                      SizedBox(
                        width: AppLayout.getWidth(100),
                        child: Text(ticket['to']['name'], textAlign: TextAlign.end, style: Styles.headlineStyle4.copyWith(color: Colors.white),),
                      )
                    ],
                  )
                ],
              ),
            ),
            //Orange top part of the ticket
            Container(
              color: Styles.orangeColor,
              child: Row(
                children:  [
                  SizedBox(
                    height: AppLayout.getHeight(20),
                    width: AppLayout.getWidth(10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Styles.bgColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(AppLayout.getHeight(10)),
                              bottomRight: Radius.circular(AppLayout.getHeight(10))
                          )
                      ),
                    ),
                  ),
                  Expanded(child: Padding(
                    padding: EdgeInsets.all(AppLayout.getHeight(12.0)),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints ) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate((constraints.constrainWidth()/17).floor(), (index) => SizedBox(
                            width: AppLayout.getWidth(5), height: AppLayout.getHeight(1), child: const DecoratedBox(decoration: BoxDecoration(color: Colors.white),),
                          )),
                        );
                      },
                    ),
                  ),
                  ),
                  SizedBox(
                    height: AppLayout.getHeight(20),
                    width: AppLayout.getWidth(10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Styles.bgColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppLayout.getHeight(10)),
                              bottomLeft: Radius.circular(AppLayout.getHeight(10))
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
            //Orange bottom part of the ticket
            Container(
              decoration: BoxDecoration(
                  color: Styles.orangeColor,
                  borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(AppLayout.getHeight(21)),
                      bottomRight: Radius.circular(AppLayout.getHeight(21)))
              ),
              padding: const EdgeInsets.only(left: 17, top: 10, right: 17, bottom: 17),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ticket['date'], style: Styles.headlineStyle3.copyWith(color: Colors.white)),
                          const Gap(5),
                          Text("DATE", style: Styles.headlineStyle4.copyWith(color: Colors.white))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(ticket['departure_time'], style: Styles.headlineStyle3.copyWith(color: Colors.white)),
                          const Gap(5),
                          Text("Departure time", style: Styles.headlineStyle4.copyWith(color: Colors.white))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(ticket['number'], style: Styles.headlineStyle3.copyWith(color: Colors.white)),
                          const Gap(5),
                          Text("FLIGHT", style: Styles.headlineStyle4.copyWith(color: Colors.white))
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
