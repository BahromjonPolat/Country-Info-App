import 'package:countries/components/colors.dart';
import 'package:flutter/material.dart';

BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
    unselectedItemColor: colorGrey,
    selectedItemColor: colorGreen,
    currentIndex: 0,
    showUnselectedLabels: false,
    showSelectedLabels: false,
    type: BottomNavigationBarType.fixed,
    items: _bottomNavigationBarItems);

BottomNavigationBar get bottomNavigationBar => _bottomNavigationBar();

List<BottomNavigationBarItem> _bottomNavigationBarItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: "Home",
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.search),
    label: "Search",
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.insert_chart_rounded),
    label: "Rating",
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.golf_course),
    label: "Golf",
  ),
];
