import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:level/components/my_appbar.dart';
import 'package:level/components/my_button.dart';
import 'package:level/services/in_app_purchase_service.dart';
import 'package:localization/localization.dart';

const List<String> _projectIds = <String>['premium_level', "premium_monthly"];

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  bool _isAvailable = false;
  List<ProductDetails> _products = [];

  @override
  void initState() {
    super.initState();
    initStoreInfo();
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;

    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      InAppPurchaseService().listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      _subscription.cancel();
    }) as StreamSubscription<List<PurchaseDetails>>;
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    setState(() {
      _isAvailable = isAvailable;
    });
    if (!_isAvailable) {
      return;
    }

    ProductDetailsResponse productDetailsResponse =
        await _inAppPurchase.queryProductDetails(_projectIds.toSet());
    setState(() {
      _products = productDetailsResponse.productDetails;
    });

    if (productDetailsResponse.error != null) {
    } else if (productDetailsResponse.productDetails.isEmpty) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
          appbarTitle: "Store".i18n(),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                final ProductDetails productDetails = _products[index];
                final PurchaseParam purchaseParam =
                    PurchaseParam(productDetails: productDetails);

                return Card(
                  child: Row(
                    children: [
                      _getIAPIcon(productDetails.id),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        productDetails.title.length > 15
                            ? productDetails.title.substring(0, 15)
                            : productDetails.title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyButton(
                            buttonChild: _buyText(productDetails),
                            onPressed: () {
                              if (productDetails.id == "premium_level") {
                                InAppPurchase.instance.buyNonConsumable(
                                    purchaseParam: purchaseParam);
                              } else {
                                InAppPurchase.instance.buyConsumable(
                                    purchaseParam: purchaseParam);
                              }
                            },
                            buttonBackgroundColor:
                                Theme.of(context).colorScheme.secondary),
                      )
                    ],
                  ),
                );
              },
              itemCount: _products.length,
            )),
            _buildRestoreButton(),
          ],
        ),
      )),
    );
  }

  Widget _getIAPIcon(productId) {
    if (productId == "premium_level") {
      return const Icon(Icons.brightness_7_outlined);
    } else if (productId == "premium_monthly") {
      return const Icon(Icons.brightness_5);
    } else {
      return const Icon(Icons.post_add_outlined);
    }
  }

  _buyText(ProductDetails productDetails) {
    if (productDetails.id == "premium_monthly") {
      return Text("${productDetails.price} / month");
    } else {
      return Text("buy for ${productDetails.price}");
    }
  }

  Widget _buildRestoreButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        TextButton(
            onPressed: () => _inAppPurchase.restorePurchases(),
            child: Text("RestorePurchase".i18n()))
      ],
    );
  }
}
