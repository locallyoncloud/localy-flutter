import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/main_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:provider/provider.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/views/widgets/admin_menu_selection.dart';
import 'package:supercharged/supercharged.dart';

class AdminPanel extends StatefulWidget {

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AdminPanelVM>().getCompanyById(context.read<RegistrationPageVM>().currentUser.company_id);
    });
    declareAnimation();
  }
 @override
  void didUpdateWidget(covariant AdminPanel oldWidget) {
    if(context.read<MainPageVM>().currentSelectedIndex==1){
      controller.forward();
    } else{
      controller.reset();
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);

    return Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.BG_WHITE,
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: sequenceAnimation["firstItemTranslate"].value,
                  child: AdminMenuSelection(
                    backgroundColor: Color(0xFFE5B7F8),
                    text: "Loyalty Kartlarım",
                    iconData: MaterialCommunityIcons.cards_variant,
                    isReverse: false,
                    onClick: () => context.read<AdminPanelVM>().goToPage("Loyalty Kartlarım"),
                  ),
                ),
                Transform.translate(
                  offset: sequenceAnimation["secondItemTranslate"].value,
                  child: AdminMenuSelection(
                    backgroundColor: Color(0xFFB7B7F8),
                    text: "QR Kod Okut",
                    iconData: Ionicons.md_barcode,
                    isReverse: true,
                    onClick: ()=> context.read<AdminPanelVM>().goToPage("QR Kod Okut"),
                  ),
                ),
                Transform.translate(
                  offset: sequenceAnimation["thirdItemTranslate"].value,
                  child: AdminMenuSelection(
                    backgroundColor: Color(0xFFA6FC95),
                    text: "Müşterilerim",
                    iconData: Ionicons.ios_people,
                    isReverse: false,
                    onClick: () => context.read<AdminPanelVM>().goToPage("Müşterilerim"),
                  ),
                ),
                Transform.translate(
                  offset: sequenceAnimation["fourthItemTranslate"].value,
                  child: AdminMenuSelection(
                    backgroundColor: Color(0xFFFCFF9F),
                    text: "Bildirimler",
                    iconData: Ionicons.md_notifications,
                    isReverse: true,
                    onClick: () => context.read<AdminPanelVM>().goToPage("Bildirimler"),
                  ),
                ),
              ],
            );
          },
        ));
  }

  declareAnimation() {
    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<Offset>(begin: Offset(-331,0), end: Offset(0,0)),
            from: 0.seconds,
            to: 0.3.seconds,
            curve: Curves.easeInOutCirc,
            tag: "firstItemTranslate")
        .addAnimatable(
            animatable: Tween<Offset>(begin: Offset(ScreenSize.screenWidth,0), end: Offset(ScreenSize.screenWidth-331,0)),
            from: 0.3.seconds,
            to: 0.6.seconds,
            curve: Curves.easeInOutCirc,
            tag: "secondItemTranslate")
        .addAnimatable(
            animatable: Tween<Offset>(begin: Offset(-331,0), end: Offset(0,0)),
            from: 0.6.seconds,
            to: 0.9.seconds,
            curve: Curves.easeInOutCirc,
            tag: "thirdItemTranslate")
        .addAnimatable(
            animatable: Tween<Offset>(begin: Offset(ScreenSize.screenWidth,0), end: Offset(ScreenSize.screenWidth-331,0)),
            from: 0.9.seconds,
            to: 1.2.seconds,
            curve: Curves.easeInOutCirc,
            tag: "fourthItemTranslate")
        .animate(controller);

  }
}
