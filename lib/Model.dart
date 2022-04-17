class Model{
  String username, workspace_ID, workspace_name;
  Model({required this.username, required this.workspace_ID, required this.workspace_name});

  void setter(String username, String workspace_ID, String workspace_name) {

    this.workspace_name = workspace_name;
    this.workspace_ID = workspace_ID;
    this.username = username;
  }

  String getUsername() {
    return username;
  }
  String getWorkspace_ID() {
    return workspace_ID;
  }
  String getWorkspace_name() {
    return workspace_name;
  }
}