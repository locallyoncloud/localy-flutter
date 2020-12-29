import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/product.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/checkbox_with_text.dart';
import 'package:locally_flutter_app/views/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

class ProductOption extends StatefulWidget {
  List<ProductOptions> options;

  ProductOption({this.options});

  @override
  _ProductOptionState createState() => _ProductOptionState();
}

class _ProductOptionState extends State<ProductOption> {
  List<ProductOptions> dropDownOptionsList;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dropDownOptionsList = widget.options.where((element) => element.optionType == "dropDown").toList();
      dropDownOptionsList.forEach((element) {
        context.read<CompanyDetailsPageVM>().setProductOption(element, element.options[0]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.options.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(

          children: [
            Text(widget.options[index].name,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                color: AppColors.PRIMARY_COLOR),
            ),
            renderContents(widget.options[index])
          ],
        );
      },
    );
  }

  Widget renderContents(ProductOptions productOption) {
    List<String> optionsArray = [];

    productOption.options.forEach((element) {
      optionsArray.add(element.optionName);
    });

    switch (productOption.optionType) {
      case "dropDown":
        return FractionallySizedBox(
          widthFactor:0.5 ,
          child: DropdownWidget(
            dropdownList: optionsArray,
            textColor: AppColors.PRIMARY_COLOR,
            onChange: (selectedOptionName) =>
                onDropDownSelected(selectedOptionName, productOption),
          ),
        );
      case "checkBox":
        return CheckboxWithTitle((value)=> onCheckboxSelected(value, productOption, productOption.options[0]), productOption.options[0]);
        break;
      case "checkboxList":
        return Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          children: List.generate(productOption.options.length,
              (index) => CheckboxWithTitle((value)=> onCheckboxSelected(value, productOption,productOption.options[index]),productOption.options[index]),
        ));
    }
  }

  onDropDownSelected(String selectedOptionName, ProductOptions productOption) {
    int selectedOptionIndex = productOption.options
        .indexWhere((element) => element.optionName == selectedOptionName);
    context
        .read<CompanyDetailsPageVM>()
        .setProductOption(productOption ,productOption.options[selectedOptionIndex]);
  }

  onCheckboxSelected(bool value,  ProductOptions productOption, Options option) {
    value
        ? context.read<CompanyDetailsPageVM>().addProductOption(productOption, option)
        : context.read<CompanyDetailsPageVM>().removeProductOption(productOption,option);
  }
}
