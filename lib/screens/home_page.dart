import 'package:countries/data/country_api.dart';
import 'package:countries/models/country_model.dart';
import 'package:countries/screens/weather_page.dart';
import 'package:countries/widgets/bottom_navigation_bar_items.dart';
import 'package:countries/widgets/circular_indicator.dart';
import 'package:countries/widgets/set_icon_widget.dart';
import 'package:countries/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:countries/components/colors.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  double? _height;
  double? _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _buildBody(),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: colorTransparent,
        elevation: 0.0,
        toolbarHeight: _height! * 0.06,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: SizedBox(
          height: _height! * 0.06,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: _height! * 0.01),
              setBoldText("Countries", size: 24.0),
              const Spacer(),
              setLightText("Find a place to travel"),
            ],
          ),
        ),
      );

  _buildBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24.0),
          _searchBox(),
          _setCategoryTitle("Nearby Courses"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: setLightText("Near from Tashkent, Chorsu"),
          ),
          _setList(),
          _setCategoryTitle("Top Rated"),
          _setList(),
        ],
      );

  _searchBox() => Column(
        children: [
          TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: setIcon(Icons.search),
                hintText: "Type to search...",
                border: _getBorder(),
                enabledBorder: _getBorder(),
                focusedBorder: _getBorder()),
          ),
          const Divider(height: 1.0, thickness: 1.0),
        ],
      );

  SizedBox _setList() => SizedBox(
        height: _height! * 0.3,
        width: _width,
        child: FutureBuilder(
          future: getCountryData,
          builder: (context, AsyncSnapshot<List<Country>> snap) {
            return snap.hasData
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 8.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) {
                      Country country = snap.data![index];
                      return InkWell(
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 16, left: 12),
                          margin: const EdgeInsets.symmetric(horizontal: 12.0),
                          height: _height! * 0.3,
                          width: _width! * 0.4,
                          decoration: BoxDecoration(
                            color: colorGreen,
                            borderRadius: _setBorderRadius(),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://source.unsplash.com/random/$index"),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              setBoldText(country.name!.common!,
                                  textColor: colorWhite),
                              Row(
                                children: [
                                  setIcon(Icons.star,
                                      color: colorAmber, size: 16.0),
                                  setLightText(
                                    "4.2 - 0.3 mil",
                                    textColor: colorGrey,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WeatherPage(country),
                            ),
                          );
                        },
                      );
                    })
                : showCircularIndicator;
          },
        ),
      );

  Padding _setCategoryTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            setBoldText(title),
            TextButton(
              onPressed: () {},
              child: setBoldText(
                "View All",
                textColor: colorGreen,
              ),
            ),
          ],
        ),
      );

  OutlineInputBorder _getBorder() => const OutlineInputBorder(
        borderSide: BorderSide(style: BorderStyle.none),
      );

  BorderRadius _setBorderRadius({double? radius}) =>
      BorderRadius.circular(radius ?? 12);
}
