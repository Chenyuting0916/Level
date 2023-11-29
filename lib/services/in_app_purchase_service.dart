import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:level/services/user_service.dart';

class InAppPurchaseService {
  void listenToPurchaseUpdated(List<PurchaseDetails> productDetails) {
    // ignore: avoid_function_literals_in_foreach_calls
    productDetails.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        await _handleSuccessfulPurchase(purchaseDetails);
      }
      if (purchaseDetails.status == PurchaseStatus.error) {
        //error handle
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    });
  }

  Future _handleSuccessfulPurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID == "premium_level") {
      await UserService().updateUser({"premium": true});
    }
    if (purchaseDetails.productID == "premium_monthly") {
      await UserService().updateUser({"premium": true});
    }
  }
}
