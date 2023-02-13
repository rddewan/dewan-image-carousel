part of dewan_image_carousel;


class BCTLImageCarousel extends StatefulWidget {
  final double? height;
  final List<String> images;
  final TextStyle positionTextStyle;
  final Color boxColor;
  final BoxFit boxFit;
  final bool autoPlay;
  final Duration? autoPlayInterval;
  final Cubic? curves;
  final Color dotColor;
  final bool showDot;
  final bool showCount;
  final DotType dotType;
  final bool isOutOfStock;
  final String outOfStockText;
  final TextStyle? outOfStockTextStyle;

  const BCTLImageCarousel({
    required this.images,
    this.height,
    required this.positionTextStyle,
    required this.boxColor,
    required this.boxFit,
    required this.autoPlay,
    required this.dotColor,
    this.showDot = true,
    this.showCount = true,   
    this.autoPlayInterval,
    this.curves,
    this.dotType = DotType.circular,
    this.isOutOfStock = false,
    this.outOfStockText = '',
    this.outOfStockTextStyle,
    Key? key,
  }) : super(key: key);

  @override
  State<BCTLImageCarousel> createState() =>
      _BCTLImageCarouselState();
}

class _BCTLImageCarouselState extends State<BCTLImageCarousel> {
  int position = 1;


  @override
  Widget build(BuildContext context) {
    return widget.images.isEmpty ? const SizedBox() : Container(
      color: kBackground,
      alignment: Alignment.center,  
      child: Stack(            
        children: [
          CarouselSlider(                
            options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              height: widget.height,
              autoPlay: widget.autoPlay,
              autoPlayInterval: widget.autoPlayInterval ?? const Duration(seconds: 3),
              autoPlayCurve: widget.curves ?? Curves.fastOutSlowIn,
              onPageChanged: (index, reason) {
                // Update the state for current image position
                setState(() {
                  position = index + 1;
                });
              },
            ),
            items: widget.images.map(
              (item) {
                return MCacheImage(
                  imageUrl: item,
                  height: widget.height,
                  boxFit: widget.boxFit,
                );
              },
            ).toList(),
          ),

          // show out of stock 
          if (widget.isOutOfStock) ... [        

            /// Out of stock text
            Container(
              decoration: BoxDecoration(
                color: Colors.black54.withOpacity(0.5),
                borderRadius:
                  const BorderRadius.all(
                    Radius.circular(kMedium),
                  ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: kLarge,
                  right: kLarge,
                  top: kXSmall,
                  bottom: kXSmall,
                ),
                child: Text(
                  widget.outOfStockText,
                  style: widget.outOfStockTextStyle,
                ),
              ),
            )

          ],

          if (widget.showCount)
            Positioned(  
              top: kSmall,   
              left: kSmall,           
              child: Container(
                padding: const EdgeInsets.only(left: kXSmall, right: kXSmall),
                decoration: BoxDecoration(
                  color: widget.boxColor,
                  borderRadius: BorderRadius.circular(kMedium),
                ),
                child: Text(
                  '$position/${widget.images.length}',
                  style: widget.positionTextStyle,
                ),
              ),                  
            ),
              

          if (widget.showDot)  
            if (widget.dotType == DotType.rounded) ...[
                Positioned(
                  bottom: kXXSmall , 
                  right: kSmall, 
                  left: kSmall,                                                   
                  child: MDotIndicator(
                    count: widget.images.length ,
                    position: position.toDouble() - 1,
                    dotColor: widget.dotColor,
                  ),
                ),
            ]
            else ...[ 
              Positioned(
                bottom: kXXSmall , 
                right: kSmall, 
                left: kSmall,                                        
                child: Row(  
                    mainAxisAlignment: MainAxisAlignment.center,                   
                    children: widget.images.asMap().entries.map((entry) {
                      return Container(
                        width: kSMedium,
                        height: kSMedium,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (
                              Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : widget.dotColor
                              ).withOpacity(position == entry.key +1 ? 0.9 : 0.4),
                            ),
                      );
                    }).toList(),                
                  ),
                ),
            ]
        ],          
      ),
    );  
  }
}
