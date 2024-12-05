import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:salon_reservation/core/widget/base_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/model/salon_model.dart';
import '../widget/salon_card.dart';

class ProductsPage extends StatefulWidget {
  final List<SalonModel> products; // Replace Product with your actual product model

  const ProductsPage({super.key, required this.products});

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  List<SalonModel> filteredProducts = [];
  bool isGrid = false;

  @override
  void initState() {
    filteredProducts = widget.products;
    super.initState();
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = widget.products
          .where((product) =>
          product.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        title: TextField(
          onChanged: _filterProducts,
          decoration: InputDecoration(
            hintText: 'search medicines...'.tr(),
            border: InputBorder.none,
            hintStyle: AppStyles.title
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Handle filter icon click here
            },
          ),
        ],
      ),
      isScrollable: false,
      content:
          isGrid ?
          Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: /*filteredProducts.length*/ 20,
                  itemBuilder: (context, index) {
                    return SalonCard(
                      salon: filteredProducts[index],
                    );
                  },
                ),
              ),
            ],
          ) :
      SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.separated(
          separatorBuilder: (context, index) {
             return Height.v12;
          },
          itemCount: /*filteredProducts.length*/ 20,
          itemBuilder: (context, index) {
            return SalonCard(
              salon: filteredProducts[index],
            );
          },
        ),
      ),
    );
  }
}
