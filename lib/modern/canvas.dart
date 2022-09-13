import 'package:flutter/material.dart';

import '../block.dart';
import '../block_canvas.dart';

class ModernBlockCanvasContext extends StatelessWidget {
  final Key? key;
  final BlockProvider blockBuilder;
  final RootBlocksProvider rootBlocksProvider;
  final OnBlockMoved onBlockMoved;
  final double zoom;
  final Offset? offset;
  final dynamic userData;
  final Widget child;

  const ModernBlockCanvasContext({
    this.key,
    required this.blockBuilder,
    required this.onBlockMoved,
    required this.rootBlocksProvider,
    this.zoom = 1,
    this.offset,
    this.userData,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CanvasContext(
      rootBlocksProvider: rootBlocksProvider,
      blockProvider: _modernBlockProvider,
      onBlockMoved: onBlockMoved,
      zoom: zoom,
      extra: ModernBlockCanvasData(
        userData: userData,
      ),
      key: key,
      offset: offset,
      child: child,
    );
  }

  Widget _modernBlockProvider(BuildContext context, BlockContext blockContext) {
    switch (blockContext.mode) {
      case BlockRenderMode.Standard:
      case BlockRenderMode.DragPointer:
      case BlockRenderMode.DragPointerHovering:
        return blockBuilder(context, blockContext);

      case BlockRenderMode.DragOriginal:
        return Container();

      case BlockRenderMode.DragSilhouette:
        return Opacity(
          opacity: blockContext.isRoot ? 0.5 : 1,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.grey,
              BlendMode.srcIn,
            ),
            child: blockBuilder(context, blockContext),
          ),
        );
    }
    return Placeholder();
  }

  static ModernBlockCanvasData? of(BuildContext context) {
    if (CanvasContext.of(context) != null) {
      return CanvasContext.of(context)!.extra as ModernBlockCanvasData?;
    } else {
      return null;
    }
  }

  static T? getUserData<T>(BuildContext context) {
    if (of(context) != null) {
      return of(context)!.userData as T?;
    } else {
      return null;
    }
  }
}

class ModernBlockCanvasData {
  final dynamic userData;

  ModernBlockCanvasData({
    required this.userData,
  });
}
