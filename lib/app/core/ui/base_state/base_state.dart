import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/core/ui/helpers/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpers/loader.dart';

abstract class BaseState<T extends StatefulWidget, c extends BlocBase>
    extends State<T> with Loader, Message {
  //
  late final c controller;
  @override
  void initState() {
    super.initState();
    controller = context.read<c>();
    //Garante que a tela estaja carregada
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        onReady();
      },
    );
  }

  void onReady() {}
}
