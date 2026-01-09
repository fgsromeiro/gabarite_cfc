import '../../shared/export/app_export.dart';

class CirclePlaceholder extends StatelessWidget {
  const CirclePlaceholder({
    super.key,
    required this.width,
    required this.heigth,
  });

  final double width;
  final double heigth;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 235, 235, 235),
      highlightColor: const Color.fromARGB(255, 205, 204, 204),
      child: Container(
        width: width,
        height: heigth,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      ),
    );
  }
}
