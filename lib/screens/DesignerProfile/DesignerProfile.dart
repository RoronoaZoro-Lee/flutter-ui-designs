import 'package:flutter/material.dart';
import 'package:flutter_uis/AppRoutes.dart';
import 'package:flutter_uis/widgets/Overlay/GradientFade.dart';
import 'package:flutter_uis/widgets/ScreenAnimation/Base.dart';
import 'package:flutter_uis/widgets/custom/CustomFlexibleSpaceBar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_uis/configs/AppDimensions.dart';

import 'package:flutter_uis/statics/data/uiDesigners.dart';
import 'package:flutter_uis/statics/data/uiList.dart';

import 'package:flutter_uis/widgets/Screen/Screen.dart';

import 'widgets/DesignerProfileBody.dart';
import 'Dimensions.dart';
import 'Provider.dart';

class DesignerProfileScreen extends StatelessWidget {
  const DesignerProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DesignerProfileStateProvider>(
      create: (_) => DesignerProfileStateProvider(),
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  void onClose(BuildContext context) =>
      DesignerProfileStateProvider.state(context).close(
        callback: () {
          Navigator.of(context).popUntil(
            ModalRoute.withName(AppRoutes.uiDetail),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    Dimensions.init(context);

    final Map obj = ModalRoute.of(context).settings.arguments;
    final String username = obj["designer"];
    List<UIItem> uiList =
        uilist.where((ui) => ui.designer == username).toList();
    UIDesigner designer =
        uiDesigners.firstWhere((user) => user.username == username);

    return WillPopScope(
      onWillPop: () async {
        this.onClose(context);
        return false;
      },
      child: Screen(
        overlayBuilders: [],
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(opacity: 0.0),
              expandedHeight: Dimensions.coverImageHeight,
              flexibleSpace: Stack(
                children: [
                  CustomFlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    stretchModes: [
                      StretchMode.zoomBackground,
                    ],
                    background: Image.asset(
                      designer.cover,
                      fit: BoxFit.cover,
                    ),
                  ),
                  OverlayGradientFade<DesignerProfileStateProvider>(
                    height: Dimensions.cardHeight * 0.6 +
                        MediaQuery.of(context).padding.top,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top +
                        AppDimensions.padding,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.padding,
                      ),
                      child: ScreenAnimationBase<DesignerProfileStateProvider>(
                        delay: 500,
                        builder: (_, child, animation) {
                          return Opacity(
                            child: child,
                            opacity: animation,
                          );
                        },
                        child: BackButton(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: DesignerProfileBody(
                uiList: uiList,
                designer: designer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// DesignerProfileAvatar(username: designer.username),
