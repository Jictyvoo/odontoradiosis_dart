import 'package:flutter/material.dart';

enum CephalometricLateralActions {
  openRadiography,
  semiautomaticLandmark,
  save
}

class ToolbarWidget extends StatelessWidget {
  const ToolbarWidget({Key? key}) : super(key: key);

  void _onSelected(CephalometricLateralActions result) {
    switch (result) {
      case CephalometricLateralActions.openRadiography:
        // TODO: Handle this case.
        break;
      case CephalometricLateralActions.semiautomaticLandmark:
        // TODO: Handle this case.
        break;
      case CephalometricLateralActions.save:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CephalometricLateralActions>(
      onSelected: _onSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      itemBuilder: (BuildContext context) =>
          const <PopupMenuEntry<CephalometricLateralActions>>[
        PopupMenuItem<CephalometricLateralActions>(
          value: CephalometricLateralActions.openRadiography,
          child: ListTile(
            leading: Icon(Icons.folder_open),
            title: Text('Open/Edit Radiography'),
          ),
        ),
        PopupMenuItem<CephalometricLateralActions>(
          value: CephalometricLateralActions.save,
          child: ListTile(
            leading: Icon(Icons.developer_board),
            title: Text('Semiautomatic-Marking'),
          ),
        ),
        PopupMenuItem<CephalometricLateralActions>(
          value: CephalometricLateralActions.semiautomaticLandmark,
          child: ListTile(
            leading: Icon(Icons.save),
            title: Text('Export Radiography'),
          ),
        ),
      ],
    );
  }
}
