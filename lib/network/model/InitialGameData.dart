class InitialGameData {
  final String assignedLabel;

  InitialGameData({required this.assignedLabel});

  factory InitialGameData.fromJson(Map<String, dynamic> json) {
    return InitialGameData(
      assignedLabel: json['AssignedLable'] as String,
    );
  }
}
