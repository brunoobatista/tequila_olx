import 'package:flutter/cupertino.dart';

class AuxFunction extends Object {
  VoidCallback? voidCallback;
  AuxFunction({this.voidCallback});

  setNewFn(fn) => this.voidCallback = fn;
  get currentFn => this.voidCallback;
}
