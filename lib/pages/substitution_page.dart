import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets/drawer.dart';

class SubstitutionPlan extends StatelessWidget {
  const SubstitutionPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: MCGAppBar(title: "MCG App"),
        drawer: const MCGDrawer(),
        body: const Center(
            child: Text("Vertretungsplan")
        ),
      ),
    );
  }
}