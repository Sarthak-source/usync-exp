import 'package:flutter/material.dart';

import 'package:usync/utils/place_holder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoGrid extends StatefulWidget {
  const PhotoGrid({super.key});

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  photo(index) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: FadeInImage.memoryNetwork(
          height: 250,
          placeholder: kTransparentImage,
          image: imageList[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  double photoHeight = (imageList.length * 250) + 15;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: photoHeight,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: MasonryGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            return photo(index);
          },
        ),
      ),
    );
  }
}
