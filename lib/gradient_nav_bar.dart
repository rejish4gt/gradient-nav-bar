/* Copyright 2019 Rejish Radhakrishnan

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. */

library gradient_nav_bar;

import 'package:gradient_nav_bar/model/tab_info.dart';
import 'package:flutter/material.dart';

const double containerHeight = 70;
const double itemContainerHeight = 66;
const double topZero = 0;
const double dashBarHeight = 3;

class GradientNavigationBar extends StatefulWidget {
  final Gradient gradient;
  final Color labelColor;
  final Color iconColor;
  final Color selectedLabelColor;
  final Color selectedIconColor;
  final Color backgroundColor;
  final List<TabInfo> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showLabel;
  final double selectedFontSize;
  final double unselectedFontSize;

  const GradientNavigationBar(
      {Key key,
      this.gradient,
      this.labelColor = Colors.grey,
      this.iconColor = Colors.grey,
      this.selectedLabelColor = Colors.white,
      this.selectedIconColor = Colors.white,
      this.backgroundColor,
      @required this.items,
      this.currentIndex = 0,
      this.onTap,
      this.showLabel = false,
      this.selectedFontSize = 14.0,
      this.unselectedFontSize = 12.0})
      : assert(items != null && items.length > 1, 'Atleast 2 Tab items are required.'),
        super(key: key);

  @override
  GradientNavigationBarState createState() => GradientNavigationBarState();
}

class GradientNavigationBarState extends State<GradientNavigationBar>
    with TickerProviderStateMixin {
  Duration duration = Duration(milliseconds: 100);
  double width;
  double currentPosition;
  int previousIndex;
  int currentIndex;
  Animation<Color> forwardIconAnimation;
  Animation<Color> reverseIconAnimation;
  Animation<Color> forwardLabelAnimation;
  Animation<Color> reverseLabelAnimation;
  Animation<double> forwardFontAnimation;
  Animation<double> reverseFontAnimation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    previousIndex = widget.currentIndex;
    currentIndex = widget.currentIndex;
    controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    controller.forward();
    forwardIconAnimation =
        ColorTween(begin: widget.iconColor, end: widget.selectedIconColor)
            .animate(controller)
              ..addListener(() {
                setState(() {});
              });
    reverseIconAnimation =
        ColorTween(begin: widget.selectedIconColor, end: widget.iconColor)
            .animate(controller)
              ..addListener(() {
                setState(() {});
              });
    forwardLabelAnimation =
        ColorTween(begin: widget.labelColor, end: widget.selectedLabelColor)
            .animate(controller)
              ..addListener(() {
                setState(() {});
              });
    reverseLabelAnimation =
        ColorTween(begin: widget.selectedLabelColor, end: widget.labelColor)
            .animate(controller)
              ..addListener(() {
                setState(() {});
              });
    forwardFontAnimation = Tween<double>(
            begin: widget.unselectedFontSize, end: widget.selectedFontSize)
        .animate(controller)
          ..addListener(() {
            setState(() {});
          });
    reverseFontAnimation = Tween<double>(
            begin: widget.selectedFontSize, end: widget.unselectedFontSize)
        .animate(controller)
          ..addListener(() {
            setState(() {});
          });
  }

  void _changePosition() {
    setState(() {
      controller.reset();
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<_TabItem> tabItems = List();

    width = MediaQuery.of(context).size.width / widget.items.length;
    currentPosition = widget.currentIndex * width;
    for (var i = 0; i < widget.items.length; i++) {
      tabItems.add(_TabItem(
        labelColor: i == widget.currentIndex
            ? forwardLabelAnimation.value
            : i == previousIndex
                ? reverseLabelAnimation.value
                : widget.labelColor,
        iconColor: i == widget.currentIndex
            ? forwardIconAnimation.value
            : i == previousIndex
                ? reverseIconAnimation.value
                : widget.iconColor,
        icon: widget.items[i].icon,
        label: widget.items[i].label,
        gradient: widget.gradient,
        selected: i == widget.currentIndex,
        duration: duration,
        showLabel: widget.showLabel,
        fontSize: i == widget.currentIndex
            ? forwardFontAnimation.value
            : i == previousIndex
                ? reverseFontAnimation.value
                : widget.unselectedFontSize,
        onTap: () {
          if (widget.onTap != null) 
          {
            widget.onTap(i);
            previousIndex = currentIndex;
            currentIndex = i;
            _changePosition();
          }
        },
      ));
    }

    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: containerHeight,
          decoration: BoxDecoration(
            color: widget.backgroundColor!=null
                ? widget.backgroundColor
                : Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 8),
            ],
          ),
        ),
        AnimatedPositioned(
          top: 0,
          left: currentPosition,
          duration: duration,
          child: SizedBox(
            height: dashBarHeight,
            width: width,
            child: Container(
              decoration: BoxDecoration(
                color: widget.gradient != null
                    ? widget.gradient.colors[0]
                    : widget.selectedIconColor,
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          top: 0,
          duration: duration,
          left: currentPosition,
          child: Container(
            height: itemContainerHeight,
            width: width,
            decoration: BoxDecoration(
              gradient: widget.gradient != null
                  ? widget.gradient
                  : LinearGradient(
                      colors: [Colors.transparent, Colors.transparent]),
            ),
          ),
        ),
        Container(
          height: itemContainerHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: tabItems,
          ),
        ),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final Gradient gradient;
  final Color labelColor;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;
  final Duration duration;
  final bool showLabel;
  final double fontSize;

  const _TabItem(
      {Key key,
      this.selected = false,
      this.icon,
      this.gradient,
      this.labelColor,
      this.iconColor,
      this.label,
      this.onTap,
      this.duration,
      this.showLabel = false,
      this.fontSize})
      : assert(showLabel ? label != null : true),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          InkResponse(
            onTap: onTap,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 2, bottom: 10),
                  child: showLabel
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              icon,
                              color: iconColor,
                            ),
                            Text(
                              label,
                              style: TextStyle(
                                  color: labelColor, fontSize: fontSize),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      : Icon(
                          icon,
                          color: iconColor,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
