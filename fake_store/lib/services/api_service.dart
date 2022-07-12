import 'dart:convert';

import 'package:fake_store/models/cart.dart';
import 'package:fake_store/models/product.dart';
import 'package:http/http.dart' as http;

class APIService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<String> login(String username, String password) {
    return http.post(Uri.parse('$baseUrl/auth/login'),
        body: {'username': username, 'password': password}).then((data) {
      debugprint(data);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        debugprint(jsonData);
        return jsonData['token'];
      }
      return '';
    });
  }

  Future<List<Product>> getAllProducts() {
    return http.get(Uri.parse('$baseUrl/products')).then((data) {
      debugprint(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final List<Product> products = [];
        debugprint(jsonData);

        for (var item in jsonData) {
          products.add(Product.fromJson(item));
        }

        return products;
      } else {
        return [];
      }
    });
  }

  Future<List<Product>> getProductsByCategory(String categoryName) {
    return http
        .get(Uri.parse('$baseUrl/products/category/$categoryName'))
        .then((data) {
      debugprint(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final products = <Product>[];
        debugprint(jsonData);

        for (var item in jsonData) {
          products.add(Product.fromJson(item));
        }
        debugprint(products);

        return products;
      } else {
        return [];
      }
    });
  }

  Future<List> getAllCategories() {
    return http.get(Uri.parse('$baseUrl/products/categories')).then((data) {
      debugprint(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final List<String> categories = [];
        debugprint(jsonData);

        for (var item in jsonData) {
          categories.add(item.toString());
        }
        debugprint(categories);

        return categories;
      } else {
        return [];
      }
    });
  }

  Future<Product> getProduct(id) {
    return http.get(Uri.parse('$baseUrl/products/$id')).then((data) {
      debugprint(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        debugprint(jsonData);

        final Product product = Product.fromJson(jsonData);
        debugprint(product);

        return product;
      }
      return Product(
          id: 0,
          title: 'null',
          description: 'null',
          price: 0.0,
          image: 'null',
          category: 'null');
    });
  }

  Future<bool> updateCart(var cartNo, var prodId) {
    return http.patch(Uri.parse('$baseUrl/carts/$cartNo.toString()'), body: {
      'userId': '1',
      'date': formatDateTime(DateTime.now()).toString(),
      'products': json.encode([
        {'productId': prodId, 'quantity': 1}
      ]),
    }).then((data) {
      debugprint(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        if (jsonData.hasData) {
          debugprint(jsonData.data);
          return true;
        } else {
          debugprint(jsonData);
          return false;
        }
      }
      return false;
    });
  }

  Future<Cart> getCart(String id) {
    return http.get(Uri.parse('$baseUrl/carts/$id')).then((data) {
      debugprint(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final Cart cart = Cart.fromJson(jsonData);

        return cart;
      }
      return Cart(id: 0, userId: 0, date: DateTime.now(), products: []);
    });
  }

  Future<bool> deleteCart(String cartId) {
    return http.delete(Uri.parse('$baseUrl/carts/$cartId')).then((data) {
      debugprint(data.statusCode);

      if (data.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    });
  }

  //dateTime Formatter
  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  //debug printer function
  void debugprint(var data) {
    print(data);
  }
}
