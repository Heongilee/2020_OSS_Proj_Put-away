import 'package:flutter/material.dart';

class SelectedReservationInfoTC {
  static final SelectedReservationInfoTC _instance =
      SelectedReservationInfoTC._internal();

  factory SelectedReservationInfoTC() {
    return _instance;
  }

  SelectedReservationInfoTC._internal() {
    // 초기화 코드
  }

  final _address = TextEditingController();
  final _id = TextEditingController();
  final _reserveDate = TextEditingController();
  final _visitDate = TextEditingController();
  final _visitTime = TextEditingController();

  // getter
  get address => _address;
  get id => _id;
  get reserveDate => _reserveDate;
  get visitDate => _visitDate;
  get visitTime => _visitTime;
}

SelectedReservationInfoTC selectedreservationinfoTC =
    new SelectedReservationInfoTC();
