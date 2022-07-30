import 'package:flutter/material.dart';
import 'package:flutter_learn/models/product_model.dart';
import 'package:flutter_learn/providers/product_provider.dart';

class NewProduct extends StatelessWidget {
  const NewProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = ProductModel();
    final _saveKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("New product"),
      ),
      body: Form(
        key: _saveKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text("Name")),
                validator: (v) {
                  var value = v ?? "";
                  if (value.length < 2) {
                    return "Min 2 hane";
                  }
                },
                onSaved: (v) {
                  productModel.name = v;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: const Text("Description")),
                onSaved: (v) {
                  productModel.description = v;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: const Text("Price")),
                onSaved: (v) {
                  productModel.price = double.tryParse(v ?? "0");
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    _saveKey.currentState!.save();
                    if (_saveKey.currentState!.validate()) {
                      ProductProvider().newProduct(productModel).then((value) {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: const Text("Save product"))
            ],
          ),
        ),
      ),
    );
  }
}
