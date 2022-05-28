import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptiveIcons {
  static IconData home = Platform.isAndroid? Icons.home : CupertinoIcons.home;
  static IconData mic = Platform.isAndroid? Icons.mic : CupertinoIcons.mic;
  static IconData library = Platform.isAndroid? Icons.grid_3x3 : CupertinoIcons.waveform;
  static IconData book = Platform.isAndroid? Icons.book : CupertinoIcons.book;
  static IconData check = Platform.isAndroid? Icons.check : CupertinoIcons.check_mark;
}