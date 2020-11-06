import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class ChangingButton extends StatefulWidget {
  Color primaryColor;
  Function  approveFunction, textOnchange;
  bool isDisabled;
  int cardType;

  ChangingButton({this.primaryColor, this.approveFunction, this.textOnchange, this.isDisabled, this.cardType = 0});

  @override
  _ChangingButtonState createState() => _ChangingButtonState();
}

class _ChangingButtonState extends State<ChangingButton> {
  bool isActive;
  ValueKey activeKey;
  ValueKey inActiveKey;

  @override
  void initState() {
    super.initState();
    isActive = false;
    activeKey = ValueKey("activekey");
    inActiveKey = ValueKey("inactivekey");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: isActive
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          key: activeKey,
          children: [
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isActive = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: widget.primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Center(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: TextField(
                key: PageStorageKey('textfield'),
                textAlign: TextAlign.center,
                maxLength: 2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(counterText: "",contentPadding: EdgeInsets.only(bottom: 8)),
                style: AppFonts.getMainFont(
                    fontSize: 14,
                    color: Colors.teal,
                    fontWeight: FontWeight.w700
                ),
                onChanged: (value) => widget.textOnchange(value),
              ),
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: (){
                  widget.approveFunction();
                  setState(() {
                    isActive = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: widget.primaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Center(
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
            : InkWell(
          key: inActiveKey,
          onTap: widget.isDisabled ? null : () {
            setState(() {
              isActive = true;
            });
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: widget.isDisabled  ? Color(0xFFBBBBBB) : Colors.green,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                widget.cardType == 0 ? "Hediye ver" : widget.cardType == 1 ? "TL ver" : "Puan ver",
                style: AppFonts.getMainFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
