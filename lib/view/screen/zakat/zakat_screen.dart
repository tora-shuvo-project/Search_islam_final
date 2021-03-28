import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/zakat_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/numberformatutil.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';
import 'package:search_islam/view/widget/custom_button.dart';
import 'package:search_islam/view/widget/custom_text_field.dart';

// ignore: must_be_immutable
class ZakatScreen extends StatelessWidget {
  TextEditingController handCostController = TextEditingController();
  TextEditingController bankColtiController = TextEditingController();
  TextEditingController bankFixedDepositController = TextEditingController();
  TextEditingController shareBenefitController = TextEditingController();
  TextEditingController goldQuantityController = TextEditingController();
  TextEditingController goldPriceController = TextEditingController();
  TextEditingController silverQuantityController = TextEditingController();
  TextEditingController silverPriceController = TextEditingController();
  TextEditingController assetsController = TextEditingController();
  TextEditingController dueCostController = TextEditingController();
  TextEditingController otherGetMoneyController = TextEditingController();
  TextEditingController serviceBoyController = TextEditingController();
  TextEditingController kurenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusNode handFocusNode = FocusNode();
    FocusNode bankColtiFocusNode = FocusNode();
    FocusNode bankFixedDepositFocusNode = FocusNode();
    FocusNode shareBenefitFocusNode = FocusNode();
    FocusNode goldQuantityFocusNode = FocusNode();
    FocusNode goldPriceFocusNode = FocusNode();
    FocusNode silverQuantityFocusNode = FocusNode();
    FocusNode silverPriceFocusNode = FocusNode();
    FocusNode assetsFocusNode = FocusNode();
    FocusNode dueCostFocusNode = FocusNode();
    FocusNode otherGetMoneyFocusNode = FocusNode();
    FocusNode serviceBoyFocusNode = FocusNode();
    FocusNode kurenFocusNode = FocusNode();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CustomAppBar(title: Strings.zakat_calculator), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        body: Consumer<ZakatProvider>(
          builder: (context, zakatProvider, child) => Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  physics: BouncingScrollPhysics(),
                  children: [
                    CustomTextField(
                        hintText: Strings.hand_cost,
                        inputType: TextInputType.number,
                        controller: handCostController,
                        focusNode: handFocusNode,
                        nextFocus: bankColtiFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                        hintText: Strings.bank_colti_hisab,
                        inputType: TextInputType.number,
                        controller: bankColtiController,
                        focusNode: bankColtiFocusNode,
                        nextFocus: bankFixedDepositFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                        hintText: Strings.bank_fixed_deposit,
                        inputType: TextInputType.number,
                        controller: bankFixedDepositController,
                        focusNode: bankFixedDepositFocusNode,
                        nextFocus: shareBenefitFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                        hintText: Strings.shareBenefit,
                        inputType: TextInputType.number,
                        controller: shareBenefitController,
                        focusNode: shareBenefitFocusNode,
                        nextFocus: goldQuantityFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                        hintText: Strings.goldQuantity,
                        inputType: TextInputType.number,
                        controller: goldQuantityController,
                        focusNode: goldQuantityFocusNode,
                        nextFocus: goldPriceFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                        hintText: Strings.goldCost,
                        inputType: TextInputType.number,
                        controller: goldPriceController,
                        focusNode: goldPriceFocusNode,
                        nextFocus: silverQuantityFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                        hintText: Strings.silverQuantity,
                        inputType: TextInputType.number,
                        controller: silverQuantityController,
                        focusNode: silverQuantityFocusNode,
                        nextFocus: silverPriceFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                        hintText: Strings.silverCost,
                        inputType: TextInputType.number,
                        controller: silverPriceController,
                        focusNode: silverPriceFocusNode,
                        nextFocus: assetsFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                        hintText: Strings.bikreoggo_mojider_mullo,
                        inputType: TextInputType.number,
                        controller: assetsController,
                        focusNode: assetsFocusNode,
                        nextFocus: dueCostFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                        hintText: Strings.bakite_bikroy_theke,
                        inputType: TextInputType.number,
                        controller: dueCostController,
                        focusNode: dueCostFocusNode,
                        nextFocus: otherGetMoneyFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                        hintText: Strings.onnoer_kace_prappo,
                        inputType: TextInputType.number,
                        controller: otherGetMoneyController,
                        focusNode: otherGetMoneyFocusNode,
                        nextFocus: serviceBoyFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                        hintText: Strings.sorborahProdey,
                        inputType: TextInputType.number,
                        controller: serviceBoyController,
                        focusNode: serviceBoyFocusNode,
                        nextFocus: kurenFocusNode),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                      hintText: Strings.kurin,
                      inputType: TextInputType.number,
                      controller: kurenController,
                      focusNode: kurenFocusNode,
                      inputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
              CustomButton(
                buttonText: Strings.calculator,
                onTap: () {
                  zakatProvider.calculateZakat(
                    cash: double.parse(handCostController.text ?? 0.0),
                    bankColti: double.parse(bankColtiController.text ?? 0.0),
                    bankDeposit: double.parse(bankFixedDepositController.text ?? 0.0),
                    shareBenefit: double.parse(shareBenefitController.text ?? 0.0),
                    gold: double.parse(goldQuantityController.text ?? 0.0),
                    goldMarketPrice: double.parse(goldPriceController.text ?? 0.0),
                    silver: double.parse(silverQuantityController.text ?? 0.0),
                    silverMarketPrice: double.parse(silverPriceController.text ?? 0.0),
                    assets: double.parse(assetsController.text ?? 0.0),
                    dueGetMoney: double.parse(dueCostController.text ?? 0.0),
                    otherGetMoney: double.parse(otherGetMoneyController.text ?? 0.0),
                    serviceCostMoney: double.parse(serviceBoyController.text ?? 0.0),
                    badCredit: double.parse(kurenController.text ?? 0.0),
                  );

                  openBottomSheet(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
            return SingleChildScrollView(
                child: Consumer<ZakatProvider>(
              builder: (context, zakatProvider, child) => Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('হিসাব', style: kalpurus.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('মোট সম্পদঃ', style: kalpurus.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, fontWeight: FontWeight.w400)),
                          Text('${NumberFormatUtil.currencyFormat(zakatProvider.totalAssets.ceil() + zakatProvider.onadoyjoggo.ceil())} ৳',
                              style: kalpurus.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('অনাদায়যোগ্য (-)', style: kalpurus.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, fontWeight: FontWeight.w400)),
                          Text('${NumberFormatUtil.currencyFormat(zakatProvider.onadoyjoggo.ceil())} ৳',
                              style: kalpurus.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('মোট', style: kalpurus.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, fontWeight: FontWeight.w400)),
                          Text('${NumberFormatUtil.currencyFormat(zakatProvider.totalAssets.ceil() - zakatProvider.onadoyjoggo.ceil())} ৳',
                              style: kalpurus.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.w400)),
                        ],
                      ),
                     SizedBox(height: 20),
                      Text(
                        'শতকরা ২.৫% টাকা হিসাবে ১ লক্ষ টাকায় জাকাত আসে ২৫০০৳\n${NumberFormatUtil.currencyFormat(zakatProvider.totalAssets.ceil() - zakatProvider.onadoyjoggo.ceil())} টাকায় জাকাত হবেঃ\n${NumberFormatUtil.currencyFormat(zakatProvider.totalAssets.ceil() - zakatProvider.onadoyjoggo.ceil())}/100000\n=${NumberFormatUtil.currencyFormat(((zakatProvider.totalAssets.ceil() - zakatProvider.onadoyjoggo.ceil()) / 100000).toInt())} x 2500\n=${zakatProvider.totalZakat} ৳(মাত্র)',
                        style: kalpurus.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  )),
            ));
          });
        });
  }
}
