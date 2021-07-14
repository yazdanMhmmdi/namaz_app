import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    if (!kIsWeb) {
      connectivity.onConnectivityChanged.listen((connectivityResult) {
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          emitInternetConnected();
          print('internet Connected');
        } else {
          emitInternetDisconnected();
          print('internet Disconnected');
        }
      });
    } else {
      emitInternetConnected();
    }
  }

  void emitInternetConnected() {
    emit(InternetConnected());
  }

  void emitInternetDisconnected() {
    emit(InternetDisconnected());
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
