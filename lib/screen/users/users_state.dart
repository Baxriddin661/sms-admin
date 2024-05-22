class UsersState {
  final String viewKey;

  UsersState({required this.viewKey});



  UsersState init() {
    return UsersState(viewKey: "key");
  }

  UsersState clone() {
    return UsersState(viewKey: viewKey);
  }
  UsersState refreshListing(String newKey) {
    return UsersState(viewKey: newKey);
  }
}
