import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:chungmugong_front_end/util/design_kit.dart';
import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:chungmugong_front_end/util/util.dart';
import 'package:chungmugong_front_end/view/lobby_body.dart';
import 'package:chungmugong_front_end/view/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LobbyView extends StatelessWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    DateTime today = appState.appDate;

    // print(appState.reservations.reservations[SectionName.na]!.reserved);

    return WillPopScope(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(DesignKit.getHeight(context, 42)),
            child: AppBar(
              backgroundColor: DesignKit.mainBlue,
              leading: const SizedBox(),
              title: BoldText16(
                '${today.year}년 ${today.month}월 ${today.day}일 (${weekDayToString(today.weekday)})',
                textColor: Colors.white,
              ),
              actions: [],
            ),
          ),
          endDrawer: DrawerView(),
          body: LobbyBody(),
        ),
        onWillPop: () async => false);
  }
}
