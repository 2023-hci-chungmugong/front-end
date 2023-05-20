import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/util/design_kit.dart';
import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:chungmugong_front_end/view/drawer_view.dart';
import 'package:chungmugong_front_end/view/lobby_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LobbyView extends StatelessWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(DesignKit.getHeight(context, 42)),
        child: AppBar(
          backgroundColor: DesignKit.mainBlue,
          leading: const SizedBox(),
          title: const BoldText16(
            '2023년 4월 29일 (토)',
            textColor: Colors.white,
          ),
          actions: [],
        ),
      ),
      endDrawer: DrawerView(),
      body: LobbyBody(),
    );
  }
}
