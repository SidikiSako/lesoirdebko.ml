import 'package:flutter/material.dart';
import 'package:lesoirdebko/models/category.dart';

List<Category> kCategoryList = [
  Category(id: 41, name: 'À la une', color: Colors.red),
  Category(id: 4, name: 'Actualité', color: Colors.purple[900]),
  Category(id: 6, name: 'Actualité nationnale', color: Color(0xffC32688)),
  Category(id: 7, name: 'Actualité régionale', color: Color(0xff0A6CBA)),
  Category(id: 1298, name: 'Afrique', color: Colors.brown),
  Category(id: 10, name: 'Agriculture', color: Color(0xff26C39A)),
  Category(id: 8, name: 'Analyse', color: Colors.blue[300]),
  Category(id: 27, name: 'Banque', color: Colors.yellow[600]),
];

Category kActualitesRegionaleCategory =
    Category(id: 7, name: 'Actualité régionale', color: Color(0xff0A6CBA));
Category kActualitesNationnaleCategory =
    Category(id: 6, name: 'Actualité nationnale', color: Color(0xffC32688));
