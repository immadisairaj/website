import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:website/constants/constants.dart';
import 'package:website/widgets/project_widget.dart';

class Projects extends StatelessWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
      child: StaggeredGrid.extent(
        maxCrossAxisExtent: 350,
        children: AppConstants.projects
            .map((project) => ProjectWidget(project: project))
            .toList(),
      ),
    );
  }
}
