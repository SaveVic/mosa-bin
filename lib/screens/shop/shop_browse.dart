import 'package:flutter/material.dart';
import 'package:mosa_bin/components/bottom_navbar.dart';
import 'package:mosa_bin/components/custom_textfield.dart';
import 'package:mosa_bin/screens/shop/item_category.dart';
import 'package:mosa_bin/screens/shop/item_product.dart';
import 'package:mosa_bin/services/filter_helper.dart';
import 'data_shop.dart';

class ShopBrowsePage extends StatefulWidget {
  @override
  _ShopBrowsePageState createState() => _ShopBrowsePageState();
}

class _ShopBrowsePageState extends State<ShopBrowsePage> {
  TextEditingController _controllerQuery = TextEditingController(text: '');
  List<Map> _displayList = [];
  bool _isLoad = false;

  Future _onSearch() async {
    if (_controllerQuery.text.isEmpty) {
      setState(() {
        _isLoad = false;
      });
    } else {
      setState(() {
        _isLoad = true;
      });
      List<Map> result =
          await FilterHelper.applyFilter(products, _controllerQuery.text);
      setState(() {
        _displayList = result;
        _isLoad = false;
      });
    }
  }

  Widget _buildCategory() {
    return ListView.builder(
      itemCount: category.length,
      itemBuilder: (ctx, id) {
        return ItemCategory(
          path: category[id]['p'],
          label: category[id]['c'],
        );
      },
    );
  }

  Widget _buildProducts() {
    if (_displayList.isEmpty) {
      return Center(
        child: Text('Tidak ada produk'),
      );
    } else {
      return GridView.count(
        primary: false,
        crossAxisSpacing: 40,
        mainAxisSpacing: 40,
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        children: List<Widget>.generate(
          _displayList.length,
          (i) => ItemProduct(prod: _displayList[i]),
        ),
      );
    }
  }

  Widget _buildLoading() {
    return Center(
      child: Text('SEDANG MENCARI...'),
    );
  }

  Widget _buildBody() {
    if (_isLoad)
      return _buildLoading();
    else if (_controllerQuery.text.isEmpty)
      return _buildCategory();
    else
      return _buildProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF6A9923),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        title: Text(
          'Toko Produk Organik',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Color(0xFFF2F2F0),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            CustomTextField(
              width: double.infinity,
              controller: _controllerQuery,
              placeholder: 'Cari Produk atau Toko Organik',
              suffixIcon: Icons.search,
              onSuffixTap: () {
                _onSearch();
              },
              radius: 10,
              shadow: false,
            ),
            SizedBox(height: 10),
            _buildBody(),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNavBar(
        pos: 0,
        onSelected: (id) {},
      ),
    );
  }
}
