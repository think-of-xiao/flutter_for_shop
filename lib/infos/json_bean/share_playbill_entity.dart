class SharePlaybillEntity {
	String shareContent;
	String shareTitle;
	String shareImage;
	String shareLog;
	String url;
	String qrcodeUrl;

	SharePlaybillEntity({this.shareContent, this.shareTitle, this.shareImage, this.shareLog, this.url, this.qrcodeUrl});

	SharePlaybillEntity.fromJson(Map<String, dynamic> json) {
		shareContent = json['share_content'];
		shareTitle = json['share_title'];
		shareImage = json['share_image'];
		shareLog = json['share_log'];
		url = json['url'];
		qrcodeUrl = json['qrcodeUrl'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['share_content'] = this.shareContent;
		data['share_title'] = this.shareTitle;
		data['share_image'] = this.shareImage;
		data['share_log'] = this.shareLog;
		data['url'] = this.url;
		data['qrcodeUrl'] = this.qrcodeUrl;
		return data;
	}
}
