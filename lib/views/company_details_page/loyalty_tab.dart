import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/views/company_details_page/active_loyalty_card.dart';
import 'package:provider/provider.dart';

class LoyaltyTab extends StatefulWidget {
  int index;

  LoyaltyTab(this.index);

  @override
  _LoyaltyTabState createState() => _LoyaltyTabState();
}

class _LoyaltyTabState extends State<LoyaltyTab> {

  var myFuture;
  @override
  void initState() {
    super.initState();
    myFuture = context.read<HomePageVM>().getClientSideLoyaltyCard(context.read<CompanyDetailsPageVM>().currentCompany.company_id);
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 200,
              width: double.infinity,
              child: Hero(
                  tag: "${widget.index}",
                  child:
                  Image.network(context.watch<CompanyDetailsPageVM>().currentCompany.logo, fit: BoxFit.cover))),
          SizedBox(
            height: 2.hb,
          ),
          Text(
            context.watch<CompanyDetailsPageVM>().currentCompany.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.GREY),
          ),
          Text(
            context.watch<CompanyDetailsPageVM>().currentCompany.slogan,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: AppColors.GREY),
          ),
          SizedBox(
            height: 3.hb,
          ),
          FutureBuilder(
            future:  myFuture,
            builder: (BuildContext context, AsyncSnapshot<LoyaltyCard> snapshot) => renderLoyalties(context, snapshot)
          ),
        ],
      ),
    );
  }

  renderLoyalties(BuildContext context,AsyncSnapshot<LoyaltyCard> snapshot){
    if(snapshot.connectionState== ConnectionState.done && !snapshot.hasData){
      return Container(
          width: 346,
          height: 136,
          color: Colors.red,
        child: Center(
          child: Text(
            "Loyalty Kart Bulunamadı",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.WHITE,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      );
    }else if(snapshot.hasData){
      return ActiveLoyaltyCard(snapshot.data);
    }else if(snapshot.connectionState== ConnectionState.waiting){
      return CircularProgressIndicator(backgroundColor: AppColors.PRIMARY_COLOR,);
    }
  }

}
