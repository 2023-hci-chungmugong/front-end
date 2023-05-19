import 'package:chungmugong_front_end/util/design_kit.dart';
import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:chungmugong_front_end/view/lobby_body.dart';
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
          backgroundColor: DesignKit.mainColor,
          leading: const SizedBox(),
          title: const BoldText16(
            '2023년 4월 29일 (토)',
            textColor: Colors.white,
          ),
          actions: [],
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: DesignKit.getHeight(context, 260),
              width: DesignKit.getWidth(context, 400),
              child: DrawerHeader(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/no_profile.png"),
                  Text('학번',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text('이름',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: DesignKit.getHeight(context, 30),
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
                          color: DesignKit.yellow,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        width: DesignKit.getWidth(context, 20),
                        height: DesignKit.getHeight(context, 25),
                        margin: EdgeInsets.only(
                            right: DesignKit.getWidth(context, 7)),
                        decoration: BoxDecoration(
                          color: DesignKit.gray,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        width: DesignKit.getWidth(context, 20),
                        height: DesignKit.getHeight(context, 25),
                        decoration: BoxDecoration(
                          color: DesignKit.gray,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      )
                    ],
                  )
                ],
              )),
            )
          ],
        ),
      ),
      body: LobbyBody(),
    );
  }
}
