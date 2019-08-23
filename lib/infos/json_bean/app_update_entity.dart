class AppUpdateEntity {
	String constraintUpdate;
	String msg;
	String downAndroid;
	String downUrl;
	String updateContent;
	String versionNumber;

	AppUpdateEntity({this.constraintUpdate, this.msg, this.downAndroid, this.downUrl, this.updateContent, this.versionNumber});

	AppUpdateEntity.fromJson(Map<String, dynamic> json) {
		constraintUpdate = json['constraint_update'];
		msg = json['msg'];
		downAndroid = json['down_android'];
		downUrl = json['down_url'];
		updateContent = json['update_content'];
		versionNumber = json['version_number'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['constraint_update'] = this.constraintUpdate;
		data['msg'] = this.msg;
		data['down_android'] = this.downAndroid;
		data['down_url'] = this.downUrl;
		data['update_content'] = this.updateContent;
		data['version_number'] = this.versionNumber;
		return data;
	}
}
