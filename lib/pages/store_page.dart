import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:level/components/my_appbar.dart';
import 'package:localization/localization.dart';

const List<String> _projectIds = <String>["premium_level"];

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  bool _isAvailable = false;
  String? _notice;

  // initState

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
            )
        ],
      )),
    );
  }
}
