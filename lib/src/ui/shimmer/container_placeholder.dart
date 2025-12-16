import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class ContainerPlaceholder extends StatelessWidget {
  const ContainerPlaceholder({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 70, 70, 70),
      highlightColor: const Color.fromARGB(255, 205, 204, 204),
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
