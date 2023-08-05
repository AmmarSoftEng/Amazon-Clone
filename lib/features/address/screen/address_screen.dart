// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/address/services/address_service.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:amazon_clone_flutter/provider/user_provider.dart';

import '../../../common/widgets/custometextfiled.dart';
import '../../../constants/globalVariables.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);
  static const String routeName = '/address';
  final String totalAmount;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController faltBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = '';
  final AddressServicse addressServicse = AddressServicse();

  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    faltBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void onAppleResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServicse.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServicse.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void onPaymentResult(res) {}

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';
    bool isForm = faltBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${faltBuildingController.text},${areaController.text},${pincodeController.text},${cityController.text}';
      } else {
        throw Exception('Plese enter all the value');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black12,
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'OR',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomeTextField(
                        controller: faltBuildingController,
                        hintText: 'Flat, House no Building'),
                    SizedBox(
                      height: 10,
                    ),
                    CustomeTextField(
                        controller: areaController, hintText: 'Area Stree'),
                    SizedBox(
                      height: 10,
                    ),
                    CustomeTextField(
                        controller: pincodeController, hintText: 'PinCode'),
                    SizedBox(
                      height: 10,
                    ),
                    CustomeTextField(
                        controller: cityController, hintText: 'Town/City'),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              ApplePayButton(
                  onPressed: () => payPressed(address),
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.only(top: 15),
                  style: ApplePayButtonStyle.whiteOutline,
                  type: ApplePayButtonType.buy,
                  paymentConfigurationAsset: 'applepay.json',
                  onPaymentResult: onAppleResult,
                  paymentItems: paymentItems),
              SizedBox(
                height: 10,
              ),
              GooglePayButton(
                  paymentConfigurationAsset: 'gpay.json',
                  onPaymentResult: onPaymentResult,
                  paymentItems: paymentItems),
            ],
          ),
        ),
      ),
    );
  }
}
