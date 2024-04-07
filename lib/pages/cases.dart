import 'package:flutter/material.dart';

class CasesPage extends StatefulWidget {
  const CasesPage({super.key});

  @override
  State<CasesPage> createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> with AutomaticKeepAliveClientMixin<CasesPage> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Center(child: Text('cases'));
  }
}
