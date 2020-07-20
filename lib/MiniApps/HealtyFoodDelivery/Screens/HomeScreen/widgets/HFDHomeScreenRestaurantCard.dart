import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_uis/configs/AppDimensions.dart';
import 'package:flutter_uis/Utils.dart';

import 'package:flutter_uis/Mixins/HoverWidget.dart';

import '../data.dart' as data;
import '../Dimensions.dart';

class HFDHomeScreenRestaurantCard extends StatefulWidget {
  final data.HFDRestaurant resrutant;
  HFDHomeScreenRestaurantCard(this.resrutant, {Key key}) : super(key: key);

  @override
  _HFDHomeScreenRestaurantCardState createState() =>
      _HFDHomeScreenRestaurantCardState();
}

class _HFDHomeScreenRestaurantCardState
    extends State<HFDHomeScreenRestaurantCard> with HoverWidgetMixin {
  @override
  Widget build(BuildContext context) {
    final sigma = Utils.rangeMap(this.animation.value, 0.0, 1.0, 2.4, 0);

    return Padding(
      padding: EdgeInsets.all(AppDimensions.padding * 2),
      child: Align(
        child: this.buildInkWell(
          child: Container(
            width: Dimensions.restaurantCardBaseWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(widget.resrutant.image),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                  color: Colors.black.withOpacity(
                    Utils.rangeMap(this.animation.value, 0.0, 1.0, 0.2, 0.6),
                  ),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      stops: [
                        // 0.3,
                        Utils.rangeMap(
                          this.animation.value,
                          0.0,
                          1.0,
                          0.3,
                          0.4,
                        ),
                        Utils.rangeMap(
                          this.animation.value,
                          0.0,
                          1.0,
                          0.8,
                          1.0,
                        ),
                      ],
                      colors: [
                        Colors.black.withOpacity(0.80),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: Utils.rangeMap(
                          this.animation.value,
                          0.0,
                          1.0,
                          AppDimensions.padding,
                          Dimensions.restaurantContainerHeight * 0.2,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.padding * 2,
                          ),
                          child: Text(
                            widget.resrutant.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15 + AppDimensions.ratio * 4,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: Utils.rangeMap(
                          this.animation.value,
                          0.0,
                          1.0,
                          -Dimensions.restaurantContainerHeight * 0.20,
                          Dimensions.restaurantContainerHeight * 0.04,
                        ),
                        child: ControlledAnimation(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 280),
                          playback: this.animation.value > 0.5
                              ? Playback.PLAY_FORWARD
                              : Playback.PLAY_REVERSE,
                          builder: (context, opacityAnimation) {
                            return Opacity(
                              opacity: opacityAnimation,
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.padding * 2,
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
                                        maxLines: 2,
                                        style: TextStyle(
                                          height: 1.26,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white.withOpacity(0.55),
                                          fontSize: 8 + AppDimensions.ratio * 4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}