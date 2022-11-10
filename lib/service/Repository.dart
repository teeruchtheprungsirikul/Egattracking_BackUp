class Repository {
  static String url = "https://egat-dev-pxujjnk2ra-an.a.run.app";
  static String register = url + "/api/auth/register";
  static String login = url + "/api/auth/login";
  static String report = url + "/api/reports";
  static String tower = url + "/api/towers";
  static String towerInRange = url + "/api/towers/inrange";
  static String attachment = url + "/api/attachments";

  static String getReport(String userId) {
    return report + "?userid=" + userId;
  }

  static String attachmentById(String parentId) {
    return attachment + "?parentid=$parentId";
  }

  static String putReport(String reportId) {
    return report + "/" + reportId;
  }

  static String profile(String userId) {
    return url + "/api/users/" + userId;
  }

  static String uploadImage(String userId) {
    return url + "/api/users/" + userId + "/image";
  }

  static String getTowerPaging(int limit, int page) {
    return tower + '?limit=$limit&page=$page';
  }

  static String getTowerInRange(int radius, double latitude, double longitude) {
    return towerInRange +
        '?radius=$radius&latitude=$latitude&longitude=$longitude';
  }

  static String getReportByType(String type) {
    return report + "?type=$type";
  }
}
