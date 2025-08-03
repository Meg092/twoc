import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dial_edit_logic.dart';

class DialEditView extends GetView<DialEditLogic> {
  const DialEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.denesik.value
              ? const CircularProgressIndicator(color: Colors.white)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.movndzu();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
