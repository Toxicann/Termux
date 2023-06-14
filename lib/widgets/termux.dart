import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/widgets/active_line.dart';

import '../controller/termux.controller.dart';

class Termux extends ConsumerStatefulWidget {
  const Termux({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TermuxState();
}

class _TermuxState extends ConsumerState<Termux> {
  final TextEditingController _cmdController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(termuxProvider.notifier).initWidget(
            ActiveLine(
              key: _key,
              focusNode: _focusNode,
              textFieldController: _cmdController,
            ),
          );
    });

    _focusNode.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
        Scrollable.ensureVisible(
          _key.currentContext!,
          alignment: 0.5,
          duration: const Duration(milliseconds: 300),
        );
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cmdController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    var _termuxProvider = ref.watch(termuxProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      // child: ListView.builder(
      //   physics: const ScrollPhysics(),
      //   controller: _scrollController,
      //   itemCount: _termuxProvider.commandHistory.length,
      //   itemBuilder: (context, index) => _termuxProvider.commandHistory[index],
      // ),
      child: SingleChildScrollView(
        child: Column(children: _termuxProvider.commandHistory),
      ),
    );
  }
}
