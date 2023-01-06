
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dewan_image_carousel/core/custom_cache_manager.dart';
import 'package:flutter/material.dart';

class MCacheImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  const MCacheImage({
    Key? key,
    required this.imageUrl, 
    this.width, 
    this.height, 
    this.boxFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return const SizedBox();
    }
    
    return CachedNetworkImage(  
      key: UniqueKey(),       
      imageUrl: imageUrl.toString(), 
      width: width,
      height: height,
      fit: boxFit,
      placeholder: (context,url) => const Icon(Icons.image),
      errorWidget: (context,url,error) => const Icon(Icons.error),   
      cacheManager: CustomCacheManager.instance,
    ); 
    
  }
}