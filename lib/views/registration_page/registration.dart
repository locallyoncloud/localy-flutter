import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/registration_page/signup_container.dart';
import 'package:locally_flutter_app/views/widgets/loading_bar.dart';
import 'package:locally_flutter_app/views/widgets/registration_tabs.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

import 'login_container.dart';



class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return LoadingBar(
      isLoadingVisible: context.watch<RegistrationPageVM>().isLoadingVisible,
      child: Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if(!currentFocus.hasPrimaryFocus){
              currentFocus.unfocus();
            }
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.wb),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  const Color(0xffffffff),
                  const Color(0xffc2c2c2),
                  const Color(0xff6a7b83),
                  const Color(0xff455a64)
                ],
                stops: [0.0, (0.18*812)/ScreenSize.screenHeight, (0.427*812)/ScreenSize.screenHeight, 1.0],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/logos/localy_logo.png", width: 62.wb, height: 16.87.hb),
                    SizedBox(
                      height: 3.hb,
                    ),
                    Text("Localy'e hoşgeldiniz! Devam etmek için lütfen giriş yapın veya üye olun.",
                    textAlign: TextAlign.center,
                    style: AppFonts.getMainFont(
                      color: AppColors.WHITE,
                      fontSize: 14,
                      fontWeight: FontWeight.w900
                    ),
                    ),
                    SizedBox(
                      height: 3.hb,
                    ),
                    RegistrationTabs(
                      tabsWidth: 70.wb,
                      passiveColor: AppColors.WHITE,
                      activeColor: AppColors.PRIMARY_COLOR,
                      onTabChange: changePage,
                      isSignInSelected: context.watch<RegistrationPageVM>().isSignInSelected,
                    ),
                    SizedBox(
                      height: 3.hb,
                    ),
                    Container(
                      height: 50.hb,
                      child: PageView(
                          controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SignUpContainer(),
                          LoginContainer()
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  changePage(int index) {
    _pageController.animateToPage(index, curve: Curves.ease, duration: 0.2.seconds);
    context.read<RegistrationPageVM>().setSelectedRegistrationContainer(index == 0 ? false : true);
  }

}

