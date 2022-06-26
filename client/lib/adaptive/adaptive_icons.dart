import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptiveIcons {
  static IconData home = Platform.isAndroid? Icons.home : CupertinoIcons.home;
  static IconData mic = Platform.isAndroid? Icons.mic : CupertinoIcons.mic_fill;
  static IconData library = Platform.isAndroid? Icons.graphic_eq : CupertinoIcons.waveform;
  static IconData info = Platform.isAndroid? Icons.info : CupertinoIcons.info;
  static IconData book = Platform.isAndroid? Icons.book : CupertinoIcons.book;
  static IconData check = Platform.isAndroid? Icons.check : CupertinoIcons.check_mark;
  static IconData scissors = Platform.isAndroid? Icons.cut : CupertinoIcons.scissors;
  static IconData edit = Platform.isAndroid? Icons.edit : CupertinoIcons.pencil;
  static IconData play = Platform.isAndroid? Icons.play_arrow : CupertinoIcons.play_arrow_solid;
  static IconData pause = Platform.isAndroid? Icons.pause : CupertinoIcons.pause_fill;
  static IconData settings = Platform.isAndroid? Icons.settings : CupertinoIcons.settings;
}