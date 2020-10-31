import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/product.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';


class AnimatedListItem extends StatefulWidget {
  final int index;
  final Product product;

  AnimatedListItem({this.index, this.product});

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;

  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: widget.index * 100), () {
            setState(() {
              _animate = true;
              _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: Container(
        height: 70,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/placeholder_image.jpg?alt=media&token=60820f73-af25-43a4-89a7-f9027dd3523c",
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.product.name,
                      style: AppFonts.getMainFont(
                          fontSize: 14,
                          color: AppColors.PRIMARY_COLOR,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 4.wb,
                    ),
                    Visibility(
                      visible: widget.product.size.length > 0 ? true : false,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            widget.product.size.contains("küçük")
                                ? Container(
                                    width: 22,
                                    child: AspectRatio(
                                        aspectRatio: 0.64,
                                        child: Image.asset(
                                          "assets/png/coffee_cup.png",
                                        )),
                                  )
                                : Container(),
                            widget.product.size.contains("orta")
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Container(
                                      width: 27,
                                      child: AspectRatio(
                                          aspectRatio: 0.64,
                                          child: Image.asset(
                                            "assets/png/coffee_cup.png",
                                          )),
                                    ),
                                  )
                                : Container(),
                            widget.product.size.contains("büyük")
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Container(
                                      width: 32,
                                      child: AspectRatio(
                                          aspectRatio: 0.64,
                                          child: Image.asset(
                                              "assets/png/coffee_cup.png")),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "${widget.product.price.toString()}₺",
                style: AppFonts.getMainFont(
                    fontSize: 14,
                    color: AppColors.PRIMARY_COLOR,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
