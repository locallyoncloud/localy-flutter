import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/product.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/animated_menu_item.dart';
import 'package:provider/provider.dart';

class MenuTab extends StatefulWidget {


  @override
  _MenuTabState createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  var productListFuture;
  ScrollController categoryScrollController;
  ScrollController productsScrollController;
  List<String> filters;

  @override
  void initState() {
    super.initState();
    categoryScrollController = ScrollController();
    productsScrollController = ScrollController();
    productListFuture =  context.read<HomePageVM>().getAllProducts(context.read<CompanyDetailsPageVM>().currentCompany.company_id);
    filters = [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productListFuture,
      builder:
          (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.PRIMARY_COLOR,
            ),
          );
        } else {
          return Column(
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(top: 10),
                child: ListView.builder(
                  controller: categoryScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                  context.watch<HomePageVM>().categoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: ()=>addOrRemoveFilter(context.read<HomePageVM>().categoryList[index]),
                      child: Card(
                        elevation: 10,
                        color: filters.contains(context.watch<HomePageVM>().categoryList[index]) ? AppColors.PRIMARY_COLOR : AppColors.WHITE,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              context.watch<HomePageVM>().categoryList[index],
                              style: AppFonts.getMainFont(
                                  color: filters.contains(context.watch<HomePageVM>().categoryList[index]) ? AppColors.WHITE : AppColors.PRIMARY_COLOR,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  controller: productsScrollController,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        child: filters.length>0 && !filters.contains(snapshot.data[index].category) ?
                        null
                            :
                        AnimatedListItem(index: index, product: snapshot.data[index],)
                    );
                  },
                ),
              )
            ],
          );
        }
      },
    );
  }

  addOrRemoveFilter(String category) {
    setState(() {
    if(filters.indexOf(category)==-1){
        filters.add(category);
    }else{
      filters.removeAt(filters.indexOf(category));
    }
    });

  }
}
