import 'dart:convert';

import 'package:fake_store/models/api_response/api_response.dart';
import 'package:fake_store/models/product.dart';
import 'package:http/http.dart' as http;

class APIService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<String> login(String username, String password) {
    return http.post(Uri.parse('${baseUrl}auth/login'),
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
      debugprint(data);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final products = <Product>[];
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
      debugprint(data);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final products = <Product>[];
        for (var item in jsonData) {
          products.add(Product.fromJson(item));
        }
        return products;
      } else {
        return [];
      }
    });
  }

  Future<List> getAllCategories() {
    return http.get(Uri.parse('$baseUrl/products/categories')).then((data) {
      debugprint(data);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final List<String> categories = [];
        for (var item in jsonData) {
          categories.add(item.toString());
        }
        return categories;
      } else {
        return [];
      }
    });
  }

  Future <Product> getProduct(id) {
    return http.get(Uri.parse('$baseUrl/products/$id')).then((data) {
      debugprint(data);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final Product product = Product.fromJson(jsonData);

        return product;
      }
      return Product(id: 0,title:'null',description:'null',price:0.0,image:'null',category: 'null'); 
    });
  }

  Future <bool> updateCart (int cartNo, int prodId){
    
  }

  //debug printer function
  void debugprint(var data) {
    print(data);
  }
}
