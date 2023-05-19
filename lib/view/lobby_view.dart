import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/util/design_kit.dart';
import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:chungmugong_front_end/view/lobby_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LobbyView extends StatelessWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
 //   var appState = context.watch<AppState>();
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/no_profile.png"),
                  BoldText16('학번'),
                  BoldText16('이름'),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BoldText14('2023년 4월 14일 (금)'),
                        SizedBox(height: DesignKit.getHeight(context, 20),),
                        BoldText14('<가>'),
                        BoldText14('14:00 ~ 18:00')
                      ],
                    ),
                    SizedBox(width: DesignKit.getWidth(context, 50),),
                    SvgPicture.asset(
                      'assets/icons/cancel.svg',
                      width: DesignKit.getWidth(context, 35),
                      height: DesignKit.getHeight(context, 35),
                    )
                  ],
                )),
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
      ),
      body: LobbyBody(),
    );
  }
}
