import 'package:flutter/material.dart';
import 'package:flutter_learn/helpers/api.dart';
import 'package:flutter_learn/screens/new_product_screenv2.dart';

import '../models/product_model.dart';

class HomeScreenV2 extends StatefulWidget {
  const HomeScreenV2({Key? key}) : super(key: key);

  @override
  _HomeScreenV2State createState() => _HomeScreenV2State();
}

class _HomeScreenV2State extends State<HomeScreenV2> {
  List<ProductModel> _list = [];
  Api api = Api();

  @override
  void initState() {
    getDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen v2"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var item = _list[index];
          return Card(
            child: ListTile(
              title: Text("${item.name}"),
              subtitle: Text("${item.description}"),
              leading: Text("${item.price} TL"),
            ),
          );
        },
        itemCount: _list.length,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_)=> NewProductScreenV2())).then((value) async {
          print('value : $value');
            if(value != null){
            setState(() {
              _list.add(value);
            });
          }
        });
        },child: Icon(Icons.add),),
    );
  }

  Future<void> getDatas() async {
    final result = await api.dioGet(url: 'product', useToken: false);
    if (result?.statusCode == 200) {
      var _datas = <ProductModel>[];
      Iterable _iterable = result?.data;
      _datas = _iterable.map((e) => ProductModel.fromJson(e)).toList();
      setState(() {
        _list = _datas;
      });
    }
  }
}
