import 'package:flutter/material.dart';
import 'package:mosa_bin/components/bottom_navbar.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/screens/shop/data_testi.dart';
import 'package:mosa_bin/screens/shop/item_testi.dart';
import 'package:mosa_bin/screens/shop/shop_invoice.dart';
import 'package:page_transition/page_transition.dart';

class ProductDetailPage extends StatefulWidget {
  final Map prod;
  final double prodWidth;

  const ProductDetailPage({Key key, @required this.prod, this.prodWidth = 200})
      : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  BoxDecoration _outerBox = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        offset: Offset(0, 2),
        spreadRadius: 2.0,
        blurRadius: 2.0,
      ),
    ],
    color: Colors.white,
  );

  int counter = 1;

  void incrementCounter() {
    setState(() {
      if (counter == 99) {
        return null;
      }
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter == 0) {
        return null;
      }
      counter--;
    });
  }

  void addToCart() {}

  void toInvoicePage() {
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: InvoicePage(),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F0),
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
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              decoration: _outerBox,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildProductInfo(),
                  buildProductAction(),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: _outerBox,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                children: List<Widget>.generate(
                  testi.length,
                  (i) => ItemTestimoni(
                      user: testi[i]['user'], msg: testi[i]['msg']),
                ),
              ),
            ),
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

  Container buildProductAction() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: GestureDetector(
                  onTap: decrementCounter,
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 6, right: 6),
                child: Text(
                  '$counter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: GestureDetector(
                  onTap: incrementCounter,
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: addToCart,
                child: Icon(
                  Icons.add_shopping_cart,
                  color: Color(0xFF6A9923),
                  size: 50,
                ),
              ),
              SizedBox(width: 30),
              CustomButton(
                height: 50,
                width: double.infinity,
                color: Color(0xFFF9B915),
                text: Text(
                  'Beli\nSekarang',
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.white,
                  ),
                ),
                onPressed: toInvoicePage,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildProductInfo() {
    return Container(
      width: widget.prodWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.prodWidth,
            height: widget.prodWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.prod['path']),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.prod['label'],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            widget.prod['owner'],
            style: TextStyle(
              fontSize: 9,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.prod['price']} / ${widget.prod['unit']}',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.black,
                ),
              ),
              Text(
                '${widget.prod['rating']}}',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${widget.prod['point']} poin',
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                '${widget.prod['sold']}} terjual',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 20),
              Text(
                '${widget.prod['stock']}} stok',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
