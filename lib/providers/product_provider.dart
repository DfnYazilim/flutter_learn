import 'package:flutter/material.dart';
import 'package:flutter_learn/helpers/api.dart';

import '../models/product_model.dart';

class ProductProvider with ChangeNotifier{
  List<ProductModel> _list = [];

  List<ProductModel> get list => _list;

  Future<bool> getProducts () async {
    final result = await Api().dioGet(url: 'product',useToken: false);
    if(result?.statusCode == 200){
      var _datas = <ProductModel>[];
      Iterable _iterable = result?.data;
      _datas = _iterable.map((e) => ProductModel.fromJson(e)).toList();
      _list = _datas;
      print("qwew : ${_list.length}");
      notifyListeners();
    }
    return false;
  }

  Future<void> newProduct(ProductModel productModel) async {
    final result = await Api().dioPost(url: 'product',useToken: false,obj: productModel.toJson());

  }
}