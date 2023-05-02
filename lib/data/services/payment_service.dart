import 'package:flutter_paystack_payment/flutter_paystack_payment.dart';
import 'package:untitled/data/providers/config_provider.dart';


class PaymentService{
   static late PaymentService instance;
  final paystack = PaystackPayment();
  static Future initialize()async{
    instance = PaymentService();
    await instance.paystack.initialize(publicKey: Config.PAYSTACK_PUBLIC_KEY);

  }
  Future <CheckoutResponse> fundWalletWithPaystack(context, amount, email, ref)async{
    await instance.paystack.initialize(publicKey: Config.PAYSTACK_PUBLIC_KEY);
    Charge charge = Charge()
      ..amount = amount * 100
      ..reference = ref
    // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = email;
    CheckoutResponse response = await paystack.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    return response;
  }
}