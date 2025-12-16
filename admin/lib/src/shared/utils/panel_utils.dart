// import 'dart:developer';

// import '../export/app_export.dart';

// enum ResponsiveScreen {
//   largeFullScreen,
//   largeBar,
//   large,
//   medium,
//   mediumBar,
//   mediumFullScreen,
// }

// class PanelUtils {
//   // static double responsiveWidth(
//   //   BuildContext context, {
//   //   required double sizeWidth,
//   // }) {
//   //   switch (getTypeDeviceResponsive(SizeConstants.mediaHeigth(context))) {
//   //     case ResponsiveScreen.large:
//   //       return sizeWidth * 0.37;
//   //     case ResponsiveScreen.largeBar:
//   //       return sizeWidth * 0.37;
//   //     case ResponsiveScreen.largeFullScreen:
//   //       return sizeWidth * 0.40;
//   //     case ResponsiveScreen.medium:
//   //       return sizeWidth * 0.35;
//   //     case ResponsiveScreen.mediumBar:
//   //       return sizeWidth * 0.35;
//   //     case ResponsiveScreen.mediumFullScreen:
//   //       return sizeWidth * 0.40;
//   //   }
//   // }

//   // static double responsiveHeigth(
//   //   BuildContext context, {
//   //   required double sizeHeigth,
//   // }) {
//   //   switch (getTypeDeviceResponsive(SizeConstants.mediaHeigth(context))) {
//   //     case ResponsiveScreen.largeFullScreen:
//   //       return sizeHeigth * 0.75;
//   //     case ResponsiveScreen.large:
//   //       return sizeHeigth * 0.80;
//   //     case ResponsiveScreen.largeBar:
//   //       return sizeHeigth * 0.77;
//   //     case ResponsiveScreen.medium:
//   //     case ResponsiveScreen.mediumBar:
//   //     case ResponsiveScreen.mediumFullScreen:
//   //       return sizeHeigth * 0.7;
//   //   }
//   // }

//   // static double responsiveScroll(int index) {
//   //   if (index <= 5) return 0.28;
//   //   if (index <= 10) return 0.30;
//   //   if (index <= 15) return 0.31;
//   //   if (index <= 20) return 0.315;
//   //   if (index <= 30) return 0.315;
//   //   if (index <= 40) return 0.315;

//   //   return 0.315;
//   // }

//   // static int responsiveColumn(BuildContext context) {
//   //   switch (getTypeDeviceResponsive(SizeConstants.mediaHeigth(context))) {
//   //     case ResponsiveScreen.large:
//   //       return (SizeConstants.mediaHeigth(context) * 0.0065).toInt();
//   //     case ResponsiveScreen.largeBar:
//   //       return (SizeConstants.mediaHeigth(context) * 0.0065).toInt();
//   //     case ResponsiveScreen.largeFullScreen:
//   //       return (SizeConstants.mediaHeigth(context) * 0.0068).toInt();
//   //     case ResponsiveScreen.medium:
//   //       return (SizeConstants.mediaHeigth(context) * 0.009).toInt();
//   //     case ResponsiveScreen.mediumBar:
//   //       return (SizeConstants.mediaHeigth(context) * 0.01).toInt();
//   //     case ResponsiveScreen.mediumFullScreen:
//   //       return (SizeConstants.mediaHeigth(context) * 0.0086).toInt();
//   //   }
//   // }

//   static SliverGridDelegateWithFixedCrossAxisCount responsiveGrid(
//     BuildContext context, {
//     bool isSimulated = false,
//   }) {
//     if (isSimulated) {
//       return responsiveGridAdaptative(context);
//     }

//     switch (getTypeDeviceResponsive(SizeConstants.mediaHeigth(context))) {
//       case ResponsiveScreen.largeFullScreen:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 8,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.077,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.0053,
//         );
//       case ResponsiveScreen.largeBar:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 9,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.076,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.003,
//         );
//       case ResponsiveScreen.large:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 9,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.077,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.007,
//         );
//       case ResponsiveScreen.mediumFullScreen:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 8,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.075,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.004,
//         );
//       case ResponsiveScreen.mediumBar:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 5,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.085,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.005,
//         );
//       case ResponsiveScreen.medium:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 5,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.08,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.007,
//         );
//     }
//   }

//   static SliverGridDelegateWithFixedCrossAxisCount responsiveGridAdaptative(
//     BuildContext context,
//   ) {
//     switch (getTypeDeviceResponsive(SizeConstants.mediaHeigth(context))) {
//       case ResponsiveScreen.largeFullScreen:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 20,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.11,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.012,
//         );

//       case ResponsiveScreen.largeBar:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 15,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.12,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.012,
//         );
//       case ResponsiveScreen.large:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 20,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.112,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.015,
//         );

//       case ResponsiveScreen.mediumFullScreen:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 12,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.105,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.014,
//         );
//       case ResponsiveScreen.mediumBar:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 10,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.115,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.012,
//         );
//       case ResponsiveScreen.medium:
//         return SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 10,
//           crossAxisSpacing: 10,
//           mainAxisExtent: SizeConstants.mediaHeigth(context) * 0.11,
//           mainAxisSpacing: SizeConstants.mediaHeigth(context) * 0.012,
//         );
//     }
//   }

//   static ResponsiveScreen getTypeDeviceResponsive(double value) {
//     log('HEIGHT -> $value');

//     if (value >= 1080) return ResponsiveScreen.largeFullScreen;
//     if (value >= 945) return ResponsiveScreen.large;
//     if (value >= 911) return ResponsiveScreen.largeBar;
//     if (value >= 860) return ResponsiveScreen.mediumFullScreen;
//     if (value >= 700) return ResponsiveScreen.medium;
//     if (value >= 695) return ResponsiveScreen.mediumBar;

//     return ResponsiveScreen.largeFullScreen;
//   }
// }
