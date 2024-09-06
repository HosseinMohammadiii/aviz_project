// import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
// import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_event.dart';
// import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_state.dart';
// import 'package:aviz_project/widgets/price_widget.dart';
// import 'package:aviz_project/widgets/text_widget.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shimmer/shimmer.dart';

// import '../DataFuture/home/Data/model/advertising.dart';
// import '../class/colors.dart';
// import '../screen/information_recentlyAdvertising.dart';

// // ignore: must_be_immutable
// class AdvertisingHomeWidget extends StatefulWidget {
//   AdvertisingHomeWidget({
//     super.key,
//     required this.adHome,
//   });
//   AdvertisingHome adHome;

//   @override
//   State<AdvertisingHomeWidget> createState() => _AdvertisingHomeWidgetState();
// }

// class _AdvertisingHomeWidgetState extends State<AdvertisingHomeWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => InformationRecentlyAdvertising(
//                 advertisingHome: widget.adHome,
//               ),
//             ));
//       },
//       child: Container(
//         width: double.maxFinite,
//         height: 140,
//         margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4),
//           color: CustomColor.white,
//           boxShadow: const [
//             BoxShadow(
//               color: CustomColor.black,
//               blurRadius: 40,
//               spreadRadius: -50,
//               offset: Offset(0, 8),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 107,
//                   width: 111,
//                   child: ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: displayImageAdvertising(
//                             advertisingHome: widget.adHome),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       textWidget(
//                         widget.adHome.title,
//                         CustomColor.black,
//                         14,
//                         FontWeight.w700,
//                       ),
//                       textWidget(
//                         widget.adHome.description,
//                         CustomColor.black,
//                         12,
//                         FontWeight.w400,
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       PriceWidget(
//                         context: context,
//                         adHome: widget.adHome,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class displayImageAdvertising extends StatelessWidget {
//   const displayImageAdvertising({
//     super.key,
//     required this.advertisingHome,
//   });

//   final AdvertisingHome advertisingHome;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AdvertisingImagesBloc, AdImagesState>(
//       builder: (context, state) {
//         BlocProvider.of<AdvertisingImagesBloc>(context)
//             .add(AdImageListHomeEvent(advertisingHome.idGallery));
//         return ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             return Column(
//               children: [
//                 if (state is AdImageDataState) ...[
//                   state.displayImageAdvertising.fold(
//                     (l) => Text(l),
//                     (r) {
//                       return CachedNetworkImage(
//                         imageUrl: r.images.first,
//                         height: 107,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         errorWidget: (context, url, error) => const Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                         placeholder: (context, url) => Center(
//                           child: Shimmer.fromColors(
//                             baseColor: const Color(0xffE1E1E1),
//                             highlightColor: const Color(0xffF3F3F2),
//                             child: Container(
//                               height: 110,
//                               width: double.infinity,
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
