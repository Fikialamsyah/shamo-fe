import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/cart_model.dart';

class TransactionService {
  String baseUrl = 'https://97f5-103-105-35-76.ap.ngrok.io/api';

  Future<bool> checkout(
    String token,
    List<CartModel> carts,
    double totalPrice,
  ) async {
    var url = '$baseUrl/checkout';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'address': 'My Home no.123',
      'items': carts
          .map(
            (cart) => {
              'id': cart.product.id,
              'quantity': cart.quantity,
            },
          )
          .toList(),
      'status': "PENDING",
      'total_price': totalPrice,
      'shipping_price': 0,
    });
    print(headers);

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed To Checkout!');
    }
  }
}
