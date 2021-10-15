import 'package:countries/components/colors.dart';
import 'package:countries/data/weather_api.dart';
import 'package:countries/models/country_model.dart';
import 'package:countries/models/weather_model.dart';
import 'package:countries/screens/details_page.dart';
import 'package:countries/widgets/buttons.dart';
import 'package:countries/widgets/circular_indicator.dart';
import 'package:countries/widgets/set_icon_widget.dart';
import 'package:countries/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  Country country;

  WeatherPage(this.country, {Key? key}) : super(key: key);

  double? _height;
  double? _width;
  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _buildBody(),
    );
  }

  Container _buildBody() => Container(
        height: _height,
        width: _width,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage("https://source.unsplash.com/random/45"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            setIconButton(Icons.arrow_back_outlined, () {}),
            const Spacer(),
            _showWeatherInfo(),
            const SizedBox(height: 24.0),
            setBoldText(
              country.name!.common!,
              size: 27.0,
              textColor: colorWhite,
            ),
            const SizedBox(height: 16.0),
            setLightText(
              "${country.capital}, ${country.name!.common}",
              textColor: colorWhite,
            ),
            const SizedBox(height: 24.0),
            _showButtonPanel(),
            const SizedBox(height: 24.0),
            _showMoreDetail(),
          ],
        ),
      );

  _showWeatherInfo() => SizedBox(
        height: _height! * 0.055,
        child: FutureBuilder(
            future: getWeatherData(country.capital![0]),
            builder: (context, AsyncSnapshot<Weather> snap) {
              return snap.hasData
                  ? Row(
                      children: [
                        setIcon(
                          Icons.wb_sunny_outlined,
                          color: colorAmber,
                          size: 48.0,
                        ),
                        const SizedBox(width: 12.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            setBoldText(
                              snap.data!.temperature,
                              textColor: colorWhite,
                              size: 24.0,
                            ),
                            setLightText(
                              "Wind: ${snap.data!.wind}",
                              textColor: colorWhite,
                            ),
                          ],
                        ),
                      ],
                    )
                  : showCircularIndicator;
            }),
      );

  Row _showButtonPanel() => Row(
        children: [
          Expanded(
              child: setOutlinedButton(() {
            Navigator.push(_context!,
                MaterialPageRoute(builder: (_) => DetailsPage(country)));
          }, "Preview")),
          const SizedBox(width: 16.0),
          Expanded(child: setElevatedButton(() {}, "Start Round")),
        ],
      );

  _showMoreDetail() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          setIcon(CupertinoIcons.arrow_up_circle_fill, color: colorWhite),
          setBoldText("Swipe for detail", textColor: colorWhite),
        ],
      );
}
