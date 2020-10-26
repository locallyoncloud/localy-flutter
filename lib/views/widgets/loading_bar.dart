import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingBar extends StatelessWidget {
  final Widget child;
  final bool isLoadingVisible;

  LoadingBar({this.child, this.isLoadingVisible});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isLoadingVisible ? Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    child: FlareActor(
                      'assets/animations/loading.flr',
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      animation: "loading_anim",
                    ),
                  ),
                ),
              ),
            )
        ) : Container()
      ],
    );
  }
}
