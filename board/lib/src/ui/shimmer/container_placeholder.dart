// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContainerPlaceholder extends StatelessWidget {
  const ContainerPlaceholder({
    super.key,
    this.width,
    this.heigth,
  });

  final double? width;
  final double? heigth;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 235, 235, 235),
      highlightColor: const Color.fromARGB(255, 205, 204, 204),
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        width: width,
        height: heigth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
