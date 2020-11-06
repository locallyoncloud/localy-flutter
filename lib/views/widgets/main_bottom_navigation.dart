import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/enums/camera_of.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/view_models/main_page_vm.dart';
import 'package:locally_flutter_app/views/scan_qr_code.dart';
import 'package:provider/provider.dart';

class GetirBottomNavigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Color(0xFF455A64).withOpacity(0.4)))),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 41,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GrowingIcon(AntDesign.home,0),
                    GrowingIcon(AntDesign.shoppingcart,1),
                  ],
                ),
              ),
              Flexible(
                flex: 18,
                child: SizedBox(),
              ),
              Flexible(
                flex: 41,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GrowingIcon(AntDesign.user,2),
                    GrowingIcon(AntDesign.infocirlceo,3),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: -10,
            child: InkWell(
              onTap: () => Get.to(ScanQRCode(CameraOf.Menu)),
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Color(0xffFEFEFE),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff515f65).withOpacity(0.6),
                      offset: Offset(0, 2),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.qr_code_sharp,
                    size: 30,
                    color: Color(0xFF455A64),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


class GrowingIcon extends StatefulWidget {
  IconData iconData;
  int  normalIndex;

  GrowingIcon(this.iconData, this.normalIndex);

  @override
  _GrowingIconState createState() => _GrowingIconState();
}

class _GrowingIconState extends State<GrowingIcon> with SingleTickerProviderStateMixin {
  AnimationController controller;
  SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);

    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
        animatable: Tween<double>(begin: 27, end: 32),
        from: Duration(milliseconds: 0),
        to: Duration(milliseconds: 200),
        curve: Curves.easeInOutCirc,
        tag: "size")
        .animate(controller);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child){
        return InkWell(
          onTap: (){
            if(context.read<MainPageVM>().currentSelectedIndex != widget.normalIndex){
              context.read<MainPageVM>().setCurrentSelectedIndex(widget.normalIndex);
              controller.forward();
              Timer(Duration(milliseconds: 300), (){
                controller.reverse();
              });
            }
          },
          child: Container(
            width: 35,
            height: 35,
            child: Icon(
              widget.iconData,
              size: sequenceAnimation["size"].value,
              color: context.watch<MainPageVM>().currentSelectedIndex == widget.normalIndex  ? AppColors.PRIMARY_COLOR : Color(0xffA5A5A5),
            ),
          ),
        );
      },
    );
  }
}