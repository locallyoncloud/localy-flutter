import 'package:animations/animations.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/enums/camera_of.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/utilities/utility_widgets.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/views/admin_page/qr_code_scan_page/customer_info.dart';
import 'package:locally_flutter_app/views/scan_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class LoyaltyScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Scaffold(
      backgroundColor: AppColors.BG_WHITE,
      appBar: UtilityWidgets.CustomAppBar(Text(
        "Loyalty Okut",
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.WHITE),
      ), null),
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
                      style: TextStyle(
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
    );
  }


}
