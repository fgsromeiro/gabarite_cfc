import 'package:flutter/material.dart';
import 'package:gabarite_board_cfc/src/shared/extension/extension_context.dart';

class AppLoadingIndicator extends StatelessWidget {
  AppLoadingIndicator({
    super.key,
    this.description = 'Preparando tudo para você, por favor aguarde...',
  });

  String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Center(
        child: SizedBox(
          height: context.sz.height * 0.4,
          width: context.sz.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: context.colorScheme.primary,
                ),
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.sz.height * 0.021,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
