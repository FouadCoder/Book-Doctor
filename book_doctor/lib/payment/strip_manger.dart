import 'package:book_dctor/payment/strip_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentManger{

  // class to make a payment 
  static Future<bool> makePayment(int amount , String moneyCode) async {
    try{
      String clientSecret = await _getSecretPayment((amount*100).toString(), moneyCode);
      await _initialPayment(clientSecret);
      await Stripe.instance.presentPaymentSheet();
      return true;
    }
    catch(e){
      return false;
    }
  }
// send the secret key 
static Future<void> _initialPayment(String secertCluent) async {
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: secertCluent,
      merchantDisplayName: "Doctor"
    ));
}
// get the secert key
  static Future<String> _getSecretPayment(String amount, String moneyCode) async {
    Dio dio = Dio();
    var res = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${PaymentKeys.secretKeyPay}',
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      ),
      data: {
        'amount': amount,
        'currency': moneyCode
      }
    );
    return res.data["client_secret"];
  }
}