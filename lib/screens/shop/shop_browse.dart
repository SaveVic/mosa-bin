import 'package:flutter/material.dart';
import 'package:mosa_bin/components/bottom_navbar.dart';
import 'package:mosa_bin/components/custom_textfield.dart';
import 'package:mosa_bin/screens/shop/item_category.dart';
import 'package:mosa_bin/screens/shop/item_product.dart';
import 'package:mosa_bin/screens/shop/shop_product_detail.dart';
import 'package:mosa_bin/services/filter_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'data_shop.dart';

class ShopBrowsePage extends StatefulWidget {
  @override
  _ShopBrowsePageState createState() => _ShopBrowsePageState();
}

class _ShopBrowsePageState extends State<ShopBrowsePage> {
  TextEditingController _controllerQuery = TextEditingController(text: '');
  List<Map> _displayList = [];
  bool _isLoad = false;

  Future _onSearch(BuildContext context) async {
    _hideKey(context);
    if (_controllerQuery.text.isEmpty) {
      setState(() {
        _isLoad = false;
      });
    } else {
      setState(() {
        _isLoad = true;
      });
      List<Map> result = await FilterHelper.applyFilter(
          products, category, _controllerQuery.text);
      setState(() {
        _displayList = result;
        _isLoad = false;
      });
    }
  }

  Widget _buildCategory(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: category.length,
        itemBuilder: (ctx, id) {
          return GestureDetector(
            onTap: () {
              final _newValue = category[id]['c'];
              _controllerQuery.value = TextEditingValue(
                text: _newValue,
              );
              _onSearch(context);
            },
            child: ItemCategory(
              path: category[id]['p'],
              label: category[id]['c'],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProducts() {
    if (_displayList.isEmpty) {
      return Center(
        child: Text('Tidak ada produk'),
      );
    } else {
      return Expanded(
        child: GridView.count(
          primary: false,
          crossAxisSpacing: 40,
          mainAxisSpacing: 40,
          crossAxisCount: 2,
          padding: EdgeInsets.all(20),
          childAspectRatio: 0.7,
          children: List<Widget>.generate(
            _displayList.length,
            (i) => GestureDetector(
              onTap: () async {
                int res = await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: ProductDetailPage(prod: _displayList[i]),
                      ),
                    ) ??
                    -1;
                if (res >= 0) Navigator.pop(context, res);
              },
              child: ItemProduct(prod: _displayList[i]),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildLoading() {
    return Center(
      child: Text('SEDANG MENCARI...'),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoad)
      return _buildLoading();
    else if (_controllerQuery.text.isEmpty)
      return _buildCategory(context);
    else
      return _buildProducts();
  }

  void _hideKey(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);
    if (focus.hasPrimaryFocus) focus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF6A9923),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
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
                _onSearch(context);
              },
              radius: 10,
              shadow: false,
            ),
            SizedBox(height: 10),
            _buildBody(context),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNavBar(
        pos: 0,
        onSelected: (id) {
          Navigator.pop(context, id);
        },
      ),
    );
  }
}
