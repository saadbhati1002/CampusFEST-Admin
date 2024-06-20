class DashboardRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  DashboardData? dashboardData;

  DashboardRes({responseCode, result, responseMsg, data});

  DashboardRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    dashboardData =
        json['Counts'] != null ? DashboardData.fromJson(json['Counts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (dashboardData != null) {
      data['Counts'] = dashboardData!.toJson();
    }
    return data;
  }
}

class DashboardData {
  int? totalCategories;
  int? totalEvent;
  int? totalPages;
  int? totalFaqCategories;
  int? totalFaqs;
  int? totalUsers;
  int? totalOffers;
  int? totalTickets;
  int? totalAdmins;
  int? totalGalleryImages;

  DashboardData(
      {totalCategories,
      totalEvent,
      totalPages,
      totalFaqCategories,
      totalFaqs,
      totalUsers,
      totalOffers,
      totalTickets,
      totalAdmins,
      totalGalleryImages});

  DashboardData.fromJson(Map<String, dynamic> json) {
    totalCategories = json['total_categories'];
    totalEvent = json['total_event'];
    totalPages = json['total_pages'];
    totalFaqCategories = json['total_faq_categories'];
    totalFaqs = json['total_faqs'];
    totalUsers = json['total_users'];
    totalOffers = json['total_offers'];
    totalTickets = json['total_tickets'];
    totalAdmins = json['total_admins'];
    totalGalleryImages = json['total_gallery_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_categories'] = totalCategories;
    data['total_event'] = totalEvent;
    data['total_pages'] = totalPages;
    data['total_faq_categories'] = totalFaqCategories;
    data['total_faqs'] = totalFaqs;
    data['total_users'] = totalUsers;
    data['total_offers'] = totalOffers;
    data['total_tickets'] = totalTickets;
    data['total_admins'] = totalAdmins;
    data['total_gallery_images'] = totalGalleryImages;
    return data;
  }
}
