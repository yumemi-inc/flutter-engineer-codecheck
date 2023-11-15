import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GreyShimmer extends StatelessWidget {
  const GreyShimmer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: child,
    );
  }
}
