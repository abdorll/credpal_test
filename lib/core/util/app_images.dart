/// ============================[BASICALLY DEFINES PATHS TO IMAGE FOLDER]
enum ImagePath { usual, svg, icon, gif }

/// ============================[IMAGE COOCKER]
String image(String imageName, {ImagePath imagePath = ImagePath.usual}) {
  /// ============================[DETERMINES PATH TO IMAGE FOLDER]
  String folderName = switch (imagePath) {
    ImagePath.svg => "svgs",
    ImagePath.icon => "icons",
    ImagePath.gif => "gifs",
    _ => "images",
  };
  return 'assets/$folderName/$imageName.${folderName.contains("svg")
      ? "svg"
      : folderName.contains("gif")
      ? "gif"
      : "png"}';
}

/// ============================[CLASS OF ALL IMAGES]
class ImageOf {
  /// =====================================[App Logo]========================
  static String logo = image("logo", imagePath: ImagePath.svg);

  // ====================================== Displays =======================
  static String flier = image("flier", imagePath: ImagePath.svg);

  /// =====================================[App Icons]=======================
  static String iconSettings = image("settings", imagePath: ImagePath.icon);
  static String iconNotification = image(
    "notification",
    imagePath: ImagePath.icon,
  );
  static String iconSearch = image("search", imagePath: ImagePath.icon);
  static String iconHome = image("home", imagePath: ImagePath.icon);
  static String iconCompass = image("compass", imagePath: ImagePath.icon);
  static String iconInbox = image("inbox", imagePath: ImagePath.icon);
  static String iconPerson = image("person", imagePath: ImagePath.icon);
  static String fab = image("Fab", imagePath: ImagePath.svg);
  static String iconBadge = image("badge", imagePath: ImagePath.icon);
  static String iconShare = image("share", imagePath: ImagePath.icon);
  static String iconThumsUp = image("thums_up", imagePath: ImagePath.icon);
  static String iconClap = image("clap", imagePath: ImagePath.icon);
  static String iconLove = image("love", imagePath: ImagePath.icon);
  static String iconStar = image("star", imagePath: ImagePath.icon);
  static String iconChat = image("chat", imagePath: ImagePath.icon);
  static String iconChange = image("change", imagePath: ImagePath.icon);
  static String iconPeople = image("people", imagePath: ImagePath.icon);
  static String thUp = image("thUp", imagePath: ImagePath.svg);
  static String circleright = image("circleright", imagePath: ImagePath.svg);
  static String iconBookmark = image("bookmark", imagePath: ImagePath.icon);
}
