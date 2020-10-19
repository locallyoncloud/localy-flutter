import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/main_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/carousel.dart';
import 'package:locally_flutter_app/views/widgets/companies.dart';
import 'package:locally_flutter_app/views/widgets/horizontal_list_view.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class Home extends StatelessWidget {
  ValueKey carouselKey = ValueKey("carousel");
  ValueKey emptyKey = ValueKey("emptyContainer");

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
              duration: 0.5.seconds,
              child: context.watch<HomePageVM>().hideCarousel ? Container(key: emptyKey,) : Carousel(carouselKey)),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Kategoriler",
                  style: AppFonts.getMainFont(
                      color: AppColors.GREY, fontWeight: FontWeight.bold))),
          HorizontalList(),
          Padding(
              padding: EdgeInsets.all(4.0),
              child: Text("Yakın Zamanda Eklenen Firmalar",
                  style: AppFonts.getMainFont(
                      color: AppColors.GREY, fontWeight: FontWeight.bold))),
          Expanded(child: Companies())
        ],
      ),
    );
  }
}
