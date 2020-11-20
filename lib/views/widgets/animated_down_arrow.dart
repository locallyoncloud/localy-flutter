import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class AnimatedDownArrow extends StatefulWidget {

  Color iconColor;
  String closedText, openedText;
  bool isExpanded;

  AnimatedDownArrow(this.iconColor,{this.closedText = "", this.openedText = "", this.isExpanded});

  @override
  _AnimatedDownArrowState createState() => _AnimatedDownArrowState();
}

class _AnimatedDownArrowState extends State<AnimatedDownArrow>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    animation = Tween<double>(begin: 0, end: 0.5).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedDownArrow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.isExpanded != widget.isExpanded){
      if(!widget.isExpanded){
        animationController.forward();
      }else{
        animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          !widget.isExpanded ? widget.closedText : widget.openedText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: widget.iconColor
          ),
        ),
        RotationTransition(
          turns: animation,
          child: Icon(
              Icons.arrow_downward,
              color: widget.iconColor),
        )
      ],
    );
  }
}
