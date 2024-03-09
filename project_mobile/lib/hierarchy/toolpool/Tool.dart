//materiale standard
import 'package:flutter/material.dart';

abstract class Tool {

  late String toolTitle; //keyword LATE si usa per dichiarare senza inizializzare

  Tool(String newToolTitle) {
    this.toolTitle = newToolTitle;
  }

  String getToolTitle() {return this.toolTitle;}
  void setToolTitle(String input) {this.toolTitle = input;}

}