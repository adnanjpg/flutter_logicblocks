import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_logicblocks/block.dart';
import 'package:flutter_logicblocks/modern/block.dart';
import 'package:flutter_logicblocks/modern/canvas.dart';
import 'package:flutter_logicblocks/modern/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: ExampleBlockWidget(
        id: "example",
        data: 'adnanan',
        mode: BlockRenderMode.DragOriginal,
      ),
    );
  }
}

class ExampleBlockWidget extends StatelessWidget {
  final String id;
  final /* Some state type */ data;
  final BlockRenderMode mode;

  ExampleBlockWidget({
    this.id,
    this.data,
    this.mode,
  });

  @override
  Widget build(BuildContext context) {
    var userData = ModernBlockCanvasContext.getUserData<String>(context);

    return ModernBlock(
      isStartBlock: false, // Whether to have a notch or circle on top
      theme: ModernBlockThemes.orange, // The color of the block background
      nextBlock:
          data.nextChild, // The block to render after this block, as an id
      nextBlockDropped: (id, pos) {
        // Callback to handle when a new block is dropped onto the end of this block
        return true;
      },
      nextBlockRemoved: () {
        // Callback to handle when the following block is removed
      },
      elements: <ModernBlockElement>[
        MaterialBlockContentElement(
          content: Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 58, 4),
            child: Text("Example block"),
          ),
        ),
        MaterialBlockChildBlockElement(
          block: data.ifChild,
          blockDropped: (id, pos) {
            return true;
          },
          blockRemoved: () {},
        ),
        MaterialBlockContentElement(
          content: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
          ),
        ),
        MaterialBlockChildBlockElement(
            block: data.elseChild,
            blockDropped: (id, pos) {
              return true;
            },
            blockRemoved: () {}),
        MaterialBlockContentElement(
          content: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
          ),
        ),
      ],
    );
  }
}
