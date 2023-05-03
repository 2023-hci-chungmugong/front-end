import 'package:chungmugong_front_end/util/design_kit.dart';
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
          title: Text(
            '2023년 4월 29일 (토)',
            style: TextStyle(
              fontSize: DesignKit.getFontSize(context, 16),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/hamburger.svg',
                width: DesignKit.getWidth(context, 24),
                height: DesignKit.getHeight(context, 21),
              ),
            ),
          ],
        ),
      ),
      body: LobbyBody(),
    );
  }
}

class LobbyBody extends StatelessWidget {
  const LobbyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
