import 'package:countries/components/colors.dart';
import 'package:countries/models/country_model.dart';
import 'package:countries/widgets/buttons.dart';
import 'package:countries/widgets/set_icon_widget.dart';
import 'package:countries/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  Country country;

  DetailsPage(this.country, {Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  double? _height;
  double? _width;

  Country? _country;

  @override
  initState() {
    super.initState();
    _country = widget.country;
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _showFooterButtons(),
    );
  }

  SingleChildScrollView _buildBody() => SingleChildScrollView(
        child: Column(
          children: [
            _showImages(),
            _buildHeader(),
            const Divider(thickness: 1.0),
            _buildFooter(),
          ],
        ),
      );

  Padding _buildHeader() => Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            setBoldText("Meadow Spring Golf And Country Club", size: 24.0),
            const SizedBox(height: 16.0),
            setLightText(
                "${_country!.capital![0].toString()}, ${_country!.name!.common}"),
            const SizedBox(height: 16.0),
            _showHeaderButtons(),
            const SizedBox(height: 16.0),
          ],
        ),
      );

  Padding _buildFooter() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            setBoldText("Information"),
            const SizedBox(height: 24.0),
            _getInformation(),
            const SizedBox(height: 24.0),
            setLightText(_description),
            const SizedBox(height: 24.0),
            _getShowScoreCard(),
          ],
        ),
      );

  Stack _showImages() => Stack(
        children: [
          Container(
            height: _height! * 0.3,
            color: colorGreen,
            child: PageView(
              onPageChanged: (i) {
                setState(() {
                  _currentIndex = i;
                });
              },
              children: [
                _setImage("https://source.unsplash.com/random/1"),
                _setImage("https://source.unsplash.com/random/2"),
                _setImage("https://source.unsplash.com/random/3"),
                _setImage("https://source.unsplash.com/random/4"),
              ],
            ),
          ),
          _showSmoothIndicator(),
        ],
      );

  Image _setImage(imageUrl) => Image.network(
        imageUrl,
        fit: BoxFit.cover,
      );

  Positioned _showSmoothIndicator() => Positioned(
        left: 24.0,
        bottom: 16.0,
        child: Row(
          children: List.generate(
            4,
            (index) => Container(
              margin: const EdgeInsets.only(right: 6.0),
              width: _currentIndex == index ? 16.0 : 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: _currentIndex == index ? colorGreen : colorGrey,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
        ),
      );

  _getInformation() => SizedBox(
        height: 38.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _setInfoLayout(_country!.area.toString(), "Area"),
            const VerticalDivider(),
            _setInfoLayout(_country!.population.toString(), "Population"),
            const VerticalDivider(),
            _setInfoLayout(_country!.region.toString(), "Region"),
          ],
        ),
      );

  _setInfoLayout(String data, String title) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          setBoldText(data),
          setLightText(title),
        ],
      );

  ListTile _getShowScoreCard() => ListTile(
        tileColor: const Color(0xffdfdfdf),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: setLightText("Show scorecard"),
        trailing: setIcon(CupertinoIcons.chevron_right, size: 16.0),
      );

  Row _showHeaderButtons() => Row(
        children: [
          _setFloatingActionButton(
            CupertinoIcons.phone_fill,
            () {},
          ),
          _setFloatingActionButton(
            CupertinoIcons.location_north_fill,
            _onGpsButtonClicked,
          ),
          _setFloatingActionButton(
            CupertinoIcons.arrowshape_turn_up_right_fill,
            () {},
          ),
          _setFloatingActionButton(
            CupertinoIcons.calendar,
            () {},
          ),
          const SizedBox(width: 32.0),
          Expanded(
              child: setOutlinedButton(() {}, "Follow", color: colorGreen)),
        ],
      );

  Container _showFooterButtons() => Container(
        padding: const EdgeInsets.all(24.0),
        color: colorWhite,
        child: Row(
          children: [
            Expanded(
                child: setOutlinedButton(() {}, "Preview", color: colorGreen)),
            const SizedBox(width: 12.0),
            Expanded(child: setElevatedButton(() {}, "Start Rounded")),
          ],
        ),
      );

  FloatingActionButton _setFloatingActionButton(
          IconData iconData, VoidCallback onPressed) =>
      FloatingActionButton(
        mini: true,
        elevation: 0.0,
        backgroundColor: const Color(0xffcecece),
        onPressed: onPressed,
        child: setIcon(iconData, size: 16),

      );

  void _onGpsButtonClicked()  {
     launch(_country!.maps!.googleMaps!);
  }

  final String _description =
      'Tashkent was founded 2,200 years ago. Tashkent was settled by ancient people as an oasis on the Chirchik River, near the foothills of the West Tian Shan Mountains. In ancient times, this area contained Beitian, probably the summer "capital" of the Kangju confederacy.[7] Some scholars believe that a "Stone Tower" mentioned by Ptolemy and by other early accounts of travel on the Silk Road referred to this settlement ("Tashkent" means "stone city").';
}
