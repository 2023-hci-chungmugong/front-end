import 'package:chungmugong_front_end/model/abusing.dart';
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
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  '부정 사용 기록',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                content: SizedBox(
                                    height: DesignKit.getHeight(context, 140),
                                    child: Column(
                                      children: [
                                        (appState.abusingLog.length>0 ?
                                        PlainText14(
                                            "${getAbusingMessage(appState.abusingLog[0].type)} - ${dateTimeToString2(appState.abusingLog[0].date)}") : 
                                        PlainText14('첫 번째 부정 이용이 없습니다.',textColor: DesignKit.gray,)),
                                        SizedBox(height: DesignKit.getHeight(context, 15)),
                                        (appState.abusingLog.length>1 ?
                                        PlainText14(
                                            "${getAbusingMessage(appState.abusingLog[1].type)} - ${dateTimeToString2(appState.abusingLog[1].date)}") :
                                        PlainText14('두 번째 부정 이용이 없습니다.',textColor: DesignKit.gray,)),
                                        SizedBox(height: DesignKit.getHeight(context, 15)),
                                        (appState.abusingLog.length>2 ?
                                        PlainText14(
                                            "${getAbusingMessage(appState.abusingLog[2].type)} - ${dateTimeToString2(appState.abusingLog[2].date)}") :
                                        PlainText14('세 번째 부정 이용이 없습니다.',textColor: DesignKit.gray,)),

                                      ],

                                    )),
                                actions: [

                                  GestureDetector(
                                    onTap:(){
                                      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                                        title: Text(
                                          '패널티란?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontWeight: FontWeight.w700),
                                        ),
                                        content: PlainText14('패널티는 3회 부정이용 시 3일 간 무한상상공간을 사용할 수 없게 하는 시스템입니다. '
                                            '부정이용은 예약 후 입장하지 않거나, 자리를 오래 비우는 것을 의미합니다. 패널티를 받았다면 부정이용 정보는 초기화됩니다.'),
                                      ));
                                    },
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          PlainText10('세번 부정 이용 시 패널티가 부과됩니다.',textColor: DesignKit.gray,),
                                          PlainText10('패널티가 무엇입니까?',textColor: DesignKit.gray,)
                                        ],
                                      ),

                                    ),
                                  )

                                ],
                              ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: DesignKit.getWidth(context, 20),
                          height: DesignKit.getHeight(context, 25),
                          margin: EdgeInsets.only(
                              right: DesignKit.getWidth(context, 7)),
                          decoration: BoxDecoration(
                            color: (appState.abusingLog.length > 0
                                ? DesignKit.yellow
                                : DesignKit.gray),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          width: DesignKit.getWidth(context, 20),
                          height: DesignKit.getHeight(context, 25),
                          margin: EdgeInsets.only(
                              right: DesignKit.getWidth(context, 7)),
                          decoration: BoxDecoration(
                            color: (appState.abusingLog.length > 1
                                ? DesignKit.yellow
                                : DesignKit.gray),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          width: DesignKit.getWidth(context, 20),
                          height: DesignKit.getHeight(context, 25),
                          decoration: BoxDecoration(
                            color: (appState.abusingLog.length > 2
                                ? DesignKit.yellow
                                : DesignKit.gray),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        )
                      ],
                    )),
              ],
            )),
          ),
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: DesignKit.getHeight(context, 20),
                  horizontal: DesignKit.getWidth(context, 20)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: DesignKit.getWidth(context, 1),
                          color: DesignKit.gray))),
              child: DrawerReservationSection()),
          SizedBox(
            height: DesignKit.getHeight(context, 300),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/logout.svg',
                width: DesignKit.getWidth(context, 32),
                height: DesignKit.getHeight(context, 40),
              ),
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
    return appState.myReservations.isEmpty
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BoldText16('예약 정보가 없습니다.'),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldText14(dateTimeToString(appState.myReservations[0].date)),
                  SizedBox(
                    height: DesignKit.getHeight(context, 20),
                  ),
                  BoldText14(
                      "<${sectionNameToString(appState.myReservations[0].section)}>"),
                  BoldText14(
                      "${appState.myReservations[0].start}:00 ~ ${appState.myReservations[0].end}:00")
                ],
              ),
              SizedBox(
                width: DesignKit.getWidth(context, 50),
              ),
              SvgPicture.asset(
                'assets/icons/cancel.svg',
                width: DesignKit.getWidth(context, 35),
                height: DesignKit.getHeight(context, 35),
              )
            ],
          );
  }
}
