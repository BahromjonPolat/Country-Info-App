import 'package:flutter/cupertino.dart';

Center _showCircularIndicator() => const Center(
      child: CupertinoActivityIndicator(radius: 24.0),
    );

Center get showCircularIndicator => _showCircularIndicator();