import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/expanded_loyalty_card.dart';
import 'package:supercharged/supercharged.dart';
import 'package:provider/provider.dart';
import 'mini_loyalty_count.dart';

class GradientExpandingButton extends StatefulWidget {

  LoyaltyProgress loyaltyProgress;
  bool isExpanded;
  LoyaltyCard loyaltyCard;


  GradientExpandingButton({this.loyaltyProgress, this.isExpanded, this.loyaltyCard,});

  @override
  _GradientExpandingButtonState createState() =>
      _GradientExpandingButtonState();
}

class _GradientExpandingButtonState extends State<GradientExpandingButton>
    with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController sequenceAnimationController;
  SequenceAnimation sequenceAnimation;
  Animation animation;
  double containerWidth = 264;
  double containerHeight = 48;
  bool isExpanded;
  ValueKey expandedKey, unExpandedKey;


  @override
  void initState() {
    super.initState();
    isExpanded= widget.isExpanded;
    expandedKey = ValueKey(1);
    unExpandedKey = ValueKey(0);
    sequenceAnimationController = AnimationController(vsync: this);
    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: isExpanded ? 346 : 264, end: 346),
            from: 0.seconds,
            to: 0.5.seconds,
            curve: Curves.easeInOutCirc,
            tag: "width")
        .addAnimatable(
            animatable: Tween<double>(begin: isExpanded ? 136 : 48, end: 136),
            from: 0.seconds,
            to: 0.5.seconds,
            curve: Curves.easeInOutCirc,
            tag: "height")
        .animate(sequenceAnimationController);
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    animationController.repeat(reverse: true);
    animation = Tween(begin: -0.3, end: 0.5).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

  }


  @override
  void dispose() {
    animationController.dispose();
    sequenceAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return AnimatedBuilder(
      animation: sequenceAnimationController,
      builder: (BuildContext context, Widget child) {
       return InkWell(
         onTap: () {
           if(!isExpanded){
             sequenceAnimationController.forward();
             Timer(0.8.seconds, () {
               setState(() {
                 isExpanded = true;
                 context.read<HomePageVM>().openLoyaltyCardForUser(widget.loyaltyCard.uid, context.read<RegistrationPageVM>().currentUser.email);
               });
             });
           }
         },
         child: Container(
           width: sequenceAnimation["width"].value,
           height: sequenceAnimation["height"].value,
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               gradient: RadialGradient(
                   center: Alignment(animation.value, animation.value),
                   radius: 2.5,
                   colors: [
                     Color(0xffEADAA9),
                     Color(0xffC3AF89),
                     Color(0xff9C8469)
                   ])),
           child: AnimatedSwitcher(
             duration: 0.5.seconds,
             child: isExpanded ?
             Column(
               key: expandedKey,
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Container(
                   color: AppColors.GREY,
                   width: 346,
                   height: 2,
                 ),
                 Container(
                   width: 346,
                   height: 107,
                   padding: EdgeInsets.symmetric(horizontal: 13),
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image: AssetImage("assets/png/mini_loyalty_bg.png"),
                           fit: BoxFit.cover,
                           alignment: Alignment.topCenter)),
                   child: Center(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           width: 64.0,
                           height: 64.0,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(11.0),
                             gradient: RadialGradient(
                               center: Alignment(0.0, 0.0),
                               radius: 0.5,
                               colors: [
                                 const Color(0xffeadaa9),
                                 const Color(0xff9c8469)
                               ],
                               stops: [0.0, 1.0],
                             ),
                             image: DecorationImage(
                                 image: NetworkImage(context.watch<CompanyDetailsPageVM>().currentCompany.mini_logo),
                                 fit: BoxFit.contain
                             ),
                             boxShadow: [
                               BoxShadow(
                                 color: const Color(0x29000000),
                                 offset: Offset(6, 6),
                                 blurRadius: 6,
                               ),
                             ],
                           ),
                         ),
                         Container(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 context.watch<CompanyDetailsPageVM>().currentCompany.name,
                                 style: AppFonts.getMainFont(
                                     color: AppColors.WHITE,
                                     fontSize: 18,
                                     fontWeight: FontWeight.w700),
                               ),
                               SizedBox(
                                 height: 6,
                               ),
                             ] + renderCardContents(),
                           ),
                         ),
                         InkWell(
                           onTap: () => onClick(),
                           child: Icon(
                             AntDesign.infocirlceo,
                             color: AppColors.WHITE,
                             size: 30,
                           ),
                         )
                       ],
                     ),
                   ),
                 ),
                 Container(
                   color: AppColors.GREY,
                   width: 346,
                   height: 2,
                 )
               ],
             )
                 : Center(
               key: unExpandedKey,
               child: Text(
                 "LOYALTY AKTİFLEŞTİR",
                 style: GoogleFonts.nunitoSans(
                     fontSize: 14,
                     fontWeight: FontWeight.w900,
                     color: AppColors.GREY),
               ),
             ),
           ),
         ),
       );
      }
    );
  }
  List<Widget> renderCardContents(){
    switch (0){
      case 0:
        return [
          Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.WHITE)
              ),
              child: Wrap(
                spacing: 10,
                children:  List.generate(widget.loyaltyCard.target, (index) => MiniLoyaltyCount(isActive: index+1<=widget.loyaltyProgress.progress,))
              )),
          SizedBox(
            height: 6,
          ),
          Text(
            "Hediye için ${widget.loyaltyCard.target - widget.loyaltyProgress.progress} adet kaldı!",
            style: AppFonts.getMainFont(
                color: AppColors.WHITE,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          )
        ];
      case 1:
        return [
          RichText(text: TextSpan(
              text: widget.loyaltyProgress.progress.toString() ,style: AppFonts.getMainFont(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.green
          ),
              children: [
                TextSpan(
                  text: "₺ birikmiş paranız var!",style: AppFonts.getMainFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.WHITE
                ),
                )
              ]
          ),)
        ];
    }
  }

  onClick() {
      showDialog(context: context,
          builder: (_) => ExpandedLoyaltyCard(
            loyaltyCard: widget.loyaltyCard,
          )
      );
  }

}
