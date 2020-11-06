import 'package:animations/animations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/enums/camera_of.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/views/admin_page/qr_code_scan_page/customer_info.dart';
import 'package:locally_flutter_app/views/scan_qr_code.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:supercharged/supercharged.dart';
import 'package:provider/provider.dart';

class LoyaltyScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BG_WHITE,
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: AppColors.PRIMARY_COLOR,
          centerTitle: true,
          title: Text(
            "Loyalty Okut",
            style: AppFonts.getMainFont(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.WHITE),
          ),
        ),
        body: Stack(
          children: [
            context.watch<AdminPanelVM>().lastReadAdminQrCode.length > 0
                ? Positioned.fill(
                  child: StreamProvider<LoyaltyProgress>.value(
                    value: context
                          .watch<AdminPanelVM>()
                          .getLoyaltyProgressStatus(
                              context.watch<AdminPanelVM>().lastReadAdminQrCode),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: CustomerInfo()
                        ),
                      ),
                  )
                : Container(),
            Positioned.fill(
              child: Visibility(
                visible: context.watch<AdminPanelVM>().lastReadAdminQrCode.length > 0 ?  false : true,
                child: Container(
                color: Colors.black.withOpacity(0.7),
              ),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 30,
              child: Row(
                children: [
                  Visibility(
                    visible: context.watch<AdminPanelVM>().lastReadAdminQrCode.length > 0 ?  false : true,
                    child: DelayedDisplay(
                      delay: 500.milliseconds,
                      child: Text(
                        "QR kod okut",
                        textAlign: TextAlign.end,
                        style: AppFonts.getMainFont(
                            fontSize: 14,
                            color: AppColors.WHITE,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: context.watch<AdminPanelVM>().lastReadAdminQrCode.length > 0 ?  false : true,
                    child: MirrorAnimation<double>(
                      tween: (0.0).tweenTo(25.0),
                      duration: 1.seconds,
                      curve: Curves.easeInOutSine,
                      builder: (context, child, value) {
                        return DelayedDisplay(
                          delay: 500.milliseconds,
                          slidingBeginOffset: Offset(-0.50, 0),
                          child: Transform.translate(
                            offset: Offset(value, 0),
                            child: Icon(
                              FontAwesome.long_arrow_right,
                              color: AppColors.WHITE,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  OpenContainer(
                    closedElevation: 10.0,
                    openElevation: 15.0,
                    openColor: AppColors.PRIMARY_COLOR,
                    closedColor: Colors.transparent,
                    transitionType: ContainerTransitionType.fade,
                    transitionDuration: 500.milliseconds,
                    openBuilder: (context, action) {
                      return ScanQRCode(CameraOf.Admin);
                    },
                    closedBuilder: (context, action) {
                      return InkWell(
                        onTap: () {
                          action();
                          print(Navigator.defaultRouteName);
                        },
                        child: Container(
                          width: 63,
                          height: 63,
                          decoration: BoxDecoration(
                              color: AppColors.PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.WHITE)),
                          child: Center(
                            child: Icon(
                              AntDesign.camera,
                              color: AppColors.WHITE,
                              size: 30,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
