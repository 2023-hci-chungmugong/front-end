import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:chungmugong_front_end/util/design_kit.dart';
import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:chungmugong_front_end/util/util.dart';
import 'package:chungmugong_front_end/view/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../model/app_state.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: DesignKit.getHeight(context, 260),
            width: DesignKit.getWidth(context, 400),
            child: DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/no_profile.png"),
                    BoldText16(appState.userData.id),
                    BoldText16(appState.userData.name),
                    SizedBox(
                      height: DesignKit.getHeight(context, 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: DesignKit.getWidth(context, 20),
                          height: DesignKit.getHeight(context, 25),
                          margin: EdgeInsets.only(
                              right: DesignKit.getWidth(context, 7)),
                          decoration: BoxDecoration(
                            color: (appState.abusingLog.length>0 ? DesignKit.yellow:DesignKit.gray),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          width: DesignKit.getWidth(context, 20),
                          height: DesignKit.getHeight(context, 25),
                          margin: EdgeInsets.only(
                              right: DesignKit.getWidth(context, 7)),
                          decoration: BoxDecoration(
                            color: (appState.abusingLog.length>1 ? DesignKit.yellow:DesignKit.gray),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          width: DesignKit.getWidth(context, 20),
                          height: DesignKit.getHeight(context, 25),
                          decoration: BoxDecoration(
                            color: (appState.abusingLog.length>2 ? DesignKit.yellow:DesignKit.gray),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical:DesignKit.getHeight(context, 20),horizontal: DesignKit.getWidth(context, 20)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: DesignKit.getWidth(context, 1),
                          color: DesignKit.gray))),
              child: DrawerReservationSection()),
          SizedBox(height: DesignKit.getHeight(context, 300),),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/logout.svg',width: DesignKit.getWidth(context, 32),height: DesignKit.getHeight(context, 40),),
              BoldText16('로그아웃')

            ],
          )
        ],
      ),
    );
  }
}
class DrawerReservationSection extends StatelessWidget {
  const DrawerReservationSection({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return appState.myReservations.isEmpty ? Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BoldText16('예약 정보가 없습니다.'),
      ],
    ): Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldText14(dateTimeToString(appState.myReservations[0].date)),
            SizedBox(height: DesignKit.getHeight(context, 20),),
            BoldText14("<${sectionNameToString(appState.myReservations[0].section)}>"),
            BoldText14("${appState.myReservations[0].start}:00 ~ ${appState.myReservations[0].end}:00")
          ],
        ),
        SizedBox(width: DesignKit.getWidth(context, 50),),
        SvgPicture.asset(
          'assets/icons/cancel.svg',
          width: DesignKit.getWidth(context, 35),
          height: DesignKit.getHeight(context, 35),
        )
      ],
    );
  }
}