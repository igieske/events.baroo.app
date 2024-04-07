import 'package:flutter/material.dart';

class BarsPage extends StatefulWidget {
  const BarsPage({super.key});

  @override
  State<BarsPage> createState() => _BarsPageState();
}

class _BarsPageState extends State<BarsPage> with AutomaticKeepAliveClientMixin<BarsPage> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Center(child: Text('bars'));
  }
}
