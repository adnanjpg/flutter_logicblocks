import 'package:flutter/widgets.dart';

import 'block.dart';
import 'block_canvas.dart';

class FixedBlock extends StatelessWidget {
  final String id;
  final BlockRenderMode mode;
  final bool isRoot;

  FixedBlock({
    required this.id,
    required this.mode,
    required this.isRoot,
  });

  @override
  Widget build(BuildContext context) {
    var canvas = CanvasContext.of(context);

    return BlockContext(
      id: id,
      mode: mode,
      isRoot: isRoot,
      child: Transform.scale(
        scale: 1,
        // scale: isRoot && mode != BlockRenderMode.DragSilhouette ? 3: 1,
        child: Builder(
          builder: (BuildContext context) {
            return canvas!.blockProvider(
              context,
              BlockContext.of(context)!,
            );
          },
        ),
      ),
    );
  }
}
