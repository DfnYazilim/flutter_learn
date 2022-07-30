import 'package:flutter/material.dart';
import 'package:flutter_learn/helpers/api.dart';
import 'package:flutter_learn/models/product_model.dart';

class NewProductScreenV2 extends StatefulWidget {
  const NewProductScreenV2({Key? key}) : super(key: key);

  @override
  _NewProductScreenV2State createState() => _NewProductScreenV2State();
}

class _NewProductScreenV2State extends State<NewProductScreenV2> {
  Api api = Api();
  ProductModel productModel = ProductModel();
final _saveKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("new Product Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _saveKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text("Name")),
                onSaved: (v) {
                  productModel.name = v;
                },
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Description")),
                onSaved: (v) {
                  productModel.description = v;
                },
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Price")),
                onSaved: (v) {
                  productModel.price = double.tryParse(v ?? "0");
                },
              ),
              ElevatedButton(onPressed: () {
                _saveKey.currentState!.save();
                if(_saveKey.currentState!.validate()){
                  _saveFn();
                }
              }, child: Text("Save New Product"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveFn() async {
    final result = await api.dioPost(url: 'product',obj: productModel.toJson(),useToken: false);
    if(result?.statusCode == 200){
      ProductModel resultModel = ProductModel.fromJson(result?.data);
      Navigator.pop(context, resultModel);

    } else {
      print('hata var');
    }
  }
}
