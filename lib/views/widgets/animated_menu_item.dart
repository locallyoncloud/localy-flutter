import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/product.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/measure_size.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/views/company_details_page/menu_tab/choose_product_size.dart';
import 'package:locally_flutter_app/views/company_details_page/menu_tab/price_text.dart';
import 'package:supercharged/supercharged.dart';

class AnimatedListItem extends StatefulWidget {
  final int index;
  final Product product;

  AnimatedListItem({this.index, this.product});

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;
  int selectedIndex = 0;
  double width = 0, height = 0;

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
    return Draggable<Product>(
      dragAnchor: DragAnchor.pointer,
      affinity: Axis.horizontal,
      data: widget.product,
      feedback: Transform.translate(
        offset: Offset(-100,-30),
        child: Container(
          width: 200,
          height: 60,
          child: Card(
            color: AppColors.PRIMARY_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.product.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.WHITE,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
      ),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 1000),
        opacity: _animate ? 1 : 0,
        curve: Curves.easeInOutQuart,
        child: Container(
          height: 90,
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
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.PRIMARY_COLOR,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    widget.product.price.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.GREY
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  renderProductCategorizationImages(double width, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: 300.milliseconds,
        width: width,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(
                color: selectedIndex == index
                    ? AppColors.PRIMARY_COLOR
                    : Colors.transparent)),
        child: AspectRatio(
            aspectRatio: 0.64, child: Image.asset("assets/png/coffee_cup.png")),
      ),
    );
  }
}
