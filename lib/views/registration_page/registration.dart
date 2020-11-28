import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/app_config.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
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
  AppConfig config;

  PageController _pageController = PageController(initialPage: 1);


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
          child: CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover
                    )
            ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 175.0,
                        height: 175.0,
                        decoration: BoxDecoration(
                            color: AppColors.WHITE,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage("assets/logos/localy_logo.png")
                            )
                        ),),
                      SizedBox(
                        height: 3.hb,
                      ),
                      Container(
                        height: 8.hb,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text("Localy'e hoşgeldiniz! Devam etmek için lütfen giriş yapın veya üye olun.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.WHITE,
                              fontSize: 14,
                              fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.hb,
                      ),
                      Container(
                        height: 50.hb,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: PageView(
                          controller: _pageController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            SignUpContainer(),
                            LoginContainer()
                          ],
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            imageUrl: context.watch<RegistrationPageVM>().backgroundImage,
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

