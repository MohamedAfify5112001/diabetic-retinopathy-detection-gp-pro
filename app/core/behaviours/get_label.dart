String getLabel(String label) {
  String classLabel = "";
  for (int i = 2; i < label.length; i++) {
    classLabel += label[i];
  }
  return classLabel;
}
