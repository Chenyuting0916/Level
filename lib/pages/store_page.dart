import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:level/components/my_appbar.dart';
import 'package:localization/localization.dart';

const List<String> _projectIds = <String>[
  'premium_level',
  "premium_level2",
  "premium monthly"
];

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  bool _isAvailable = false;
  String? _notice;
  List<ProductDetails> _products = [];

  @override
  void initState() {
    super.initState();
    initStoreInfo();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    setState(() {
      _isAvailable = isAvailable;
    });
    if (!_isAvailable) {
      setState(() {
        _notice = "There is no upgrades at this time";
      });
      return;
    }

    setState(() {
      _notice = "There is a connection to the store";
    });

    ProductDetailsResponse productDetailsResponse =
        await _inAppPurchase.queryProductDetails(_projectIds.toSet());
    setState(() {
      _products = productDetailsResponse.productDetails;
    });

    if (productDetailsResponse.error != null) {
      setState(() {
        _notice = "There was a problem connecting to store.";
      });
    } else if (productDetailsResponse.productDetails.isEmpty) {
      setState(() {
        _notice = "There is no products at this time";
      });
    }
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
          child: Column(
        children: [
          if (_notice != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_notice!),
            ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              final ProductDetails productDetails = _products[index];

              return Card(
                child: Column(
                  children: [
                    Text(
                      productDetails.title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(productDetails.description)
                  ],
                ),
              );
            },
            itemCount: _products.length,
          )),
        ],
      )),
    );
  }

  Widget _getIAPIcon(productId) {
    if (productId == "") {
      return Icon(Icons.brightness_7_outlined);
    }
    else{
      return Icon(Icons.brightness_7_outlined);
    }
  }
}
