import "dart:convert";

import "package:http/http.dart" as http;
import "package:kermanager/api/api_constants.dart";
import "package:stripe_checkout/stripe_checkout.dart";

class StripeService {
  Future<dynamic> createCheckoutSession(
    int userId,
    int credit,
  ) async {
    final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");

    String lineItems = "";
    lineItems += "&line_items[0][price_data][product_data][name]=Credit";
    lineItems +=
        "&line_items[0][price_data][unit_amount]=${(credit * 100).round()}";
    lineItems += "&line_items[0][price_data][currency]=EUR";
    lineItems += "&line_items[0][quantity]=1";

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer ${ApiConstants.stripeScretKey}",
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body:
          "success_url=https://example.com/success&mode=payment$lineItems&metadata[user_id]=$userId&metadata[credit]=$credit",
    );

    return json.decode(response.body)["id"];
  }

  Future<dynamic> stripePaymentCheckout(
    userId,
    credit,
    context, {
    onSuccess,
    onCancel,
    onError,
  }) async {
    final String checkoutId = await createCheckoutSession(
      userId,
      credit,
    );

    final result = await redirectToCheckout(
      context: context,
      sessionId: checkoutId,
      publishableKey: ApiConstants.stripePublishableKey,
      successUrl: "https://example.com/success",
      canceledUrl: "https://example.com/cancel",
    );

    final text = result.when(
      redirected: () => "Redirected to checkout",
      success: () => onSuccess(),
      canceled: () => onCancel(),
      error: (e) => onError(e),
    );

    return text;
  }
}
