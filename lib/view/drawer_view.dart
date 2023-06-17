import 'package:chungmugong_front_end/intent/cancel_reservation.dart';
import 'package:chungmugong_front_end/model/abusing.dart';
import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:chungmugong_front_end/util/design_kit.dart';
import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:chungmugong_front_end/util/util.dart';
import 'package:chungmugong_front_end/view/login_view.dart';
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
            height: DesignKit.getHeight(context, 280),
            width: DesignKit.getWidth(context, 400),
            child: DrawerHeader(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: Divider.createBorderSide(context,
                            color: DesignKit.gray, width: 1.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/no_profile.png"),
                    BoldText16(appState.userData.id),
                    BoldText16(appState.userData.name),
                    SizedBox(
                      height: DesignKit.getHeight(context, 10),
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text(
                                      '부정 사용 기록',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    content: SizedBox(
                                        height:
                                            DesignKit.getHeight(context, 140),
                                        child: Column(
                                          children: [
                                            (appState.abusingLog.isNotEmpty
                                                ? PlainText14(
                                                    "${getAbusingMessage(appState.abusingLog[0].type)} - ${dateTimeToString2(appState.abusingLog[0].date)}")
                                                : const PlainText14(
                                                    '첫 번째 부정 이용이 없습니다.',
                                                    textColor: DesignKit.gray,
                                                  )),
                                            SizedBox(
                                                height: DesignKit.getHeight(
                                                    context, 15)),
                                            (appState.abusingLog.length > 1
                                                ? PlainText14(
                                                    "${getAbusingMessage(appState.abusingLog[1].type)} - ${dateTimeToString2(appState.abusingLog[1].date)}")
                                                : const PlainText14(
                                                    '두 번째 부정 이용이 없습니다.',
                                                    textColor: DesignKit.gray,
                                                  )),
                                            SizedBox(
                                                height: DesignKit.getHeight(
                                                    context, 15)),
                                            (appState.abusingLog.length > 2
                                                ? PlainText14(
                                                    "${getAbusingMessage(appState.abusingLog[2].type)} - ${dateTimeToString2(appState.abusingLog[2].date)}")
                                                : const PlainText14(
                                                    '세 번째 부정 이용이 없습니다.',
                                                    textColor: DesignKit.gray,
                                                  )),
                                          ],
                                        )),
                                    actions: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  const AlertDialog(
                                                    title: Text(
                                                      '패널티란?',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    content: PlainText14(
                                                        '패널티는 3회 부정이용 시 3일 간 무한상상공간을 사용할 수 없게 하는 시스템입니다. '
                                                        '부정이용은 예약 후 입장하지 않거나, 자리를 오래 비우는 것을 의미합니다. 패널티를 받았다면 부정이용 정보는 초기화됩니다.'),
                                                  ));
                                        },
                                        child: const Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              PlainText10(
                                                '세번 부정 이용 시 패널티가 부과됩니다.',
                                                textColor: DesignKit.gray,
                                              ),
                                              PlainText10(
                                                '패널티가 무엇입니까?',
                                                textColor: DesignKit.gray,
                                              )
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
                                color: (appState.abusingLog.isNotEmpty
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
              child: const DrawerReservationSection()),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/logout.svg',
                          width: DesignKit.getWidth(context, 32),
                          height: DesignKit.getHeight(context, 40),
                        ),
                        const BoldText16('로그아웃')
                      ],
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                content: const PlainText14('정말 로그아웃 하시겠습니까?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginView(),
                                        ),
                                      );
                                    },
                                    child: const Text('네'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('아니요'),
                                  ),
                                ],
                              ));
                    },
                  )
                ],
              )),
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
        ? const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BoldText16('예약 정보가 없습니다.'),
            ],
          )
        : Column(
            children: appState.myReservations
                .asMap()
                .map((index, ReservationForUser e) => (MapEntry(
                    index,
                    ReservationSection(
                        reserveDate: dateTimeToString(e.date),
                        sectionName: sectionNameToString(e.section),
                        start: e.start,
                        end: e.end,
                        idx: index))))
                .values
                .toList(),
          );
  }
}

class ReservationSection extends StatefulWidget {
  const ReservationSection(
      {super.key,
      required this.reserveDate,
      required this.sectionName,
      required this.start,
      required this.end,
      required this.idx});

  final String reserveDate;
  final String sectionName;
  final int start;
  final int end;
  final int idx;

  @override
  State<ReservationSection> createState() => _ReservationSectionState();
}

class _ReservationSectionState extends State<ReservationSection> {
  @override
  Widget build(BuildContext context) {
    return (Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoldText14(widget.reserveDate),
              SizedBox(
                height: DesignKit.getHeight(context, 20),
              ),
              BoldText14("<${widget.sectionName}>"),
              BoldText14("${widget.start}:00 ~ ${(widget.end) + 1}:00")
            ],
          ),
          SizedBox(
            width: DesignKit.getWidth(context, 50),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        content: const PlainText14('해당 예약을 정말 취소하시겠습니까?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await cancelReservation(widget.idx)
                                  .then((value) => Navigator.pop(context));
                            },
                            child: const Text('네'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('아니요'),
                          ),
                        ],
                      ));
            },
            child: SvgPicture.asset(
              'assets/icons/cancel.svg',
              width: DesignKit.getWidth(context, 35),
              height: DesignKit.getHeight(context, 35),
            ),
          )
        ],
      ),
      SizedBox(
        height: DesignKit.getHeight(context, 20),
      ),
    ]));
  }
}
