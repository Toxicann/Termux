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
  final FocusNode _myFocusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(termuxProvider.notifier).initWidget(
            ActiveLine(
              textFieldController: _cmdController,
            ),
          );
    });
    super.initState();
  }

  @override
  void dispose() {
    _cmdController.dispose();
    _myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    var _termuxProvider = ref.watch(termuxProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        primary: true,
        physics: const ScrollPhysics(),
        itemCount: _termuxProvider.commandHistory.length,
        itemBuilder: (context, index) => _termuxProvider.commandHistory[index],
      ),
    );
  }
}
