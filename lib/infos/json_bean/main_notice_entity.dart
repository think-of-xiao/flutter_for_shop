class MainNoticeEntity {
	String msg;
	String result;
	List<MainNoticeNlist> nList;

	MainNoticeEntity({this.msg, this.result, this.nList});

	MainNoticeEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		result = json['result'];
		if (json['nList'] != null) {
			nList = new List<MainNoticeNlist>();(json['nList'] as List).forEach((v) { nList.add(new MainNoticeNlist.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['result'] = this.result;
		if (this.nList != null) {
      data['nList'] =  this.nList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class MainNoticeNlist {
	String flag;
	String createTime;
	String author;
	String title;
	int type;
	String content;
	String picture;
	int sales;
	int brandId;
	String readState;
	String contentUrl;
	int id;
	int evaluate;

	MainNoticeNlist({this.flag, this.createTime, this.author, this.title, this.type, this.content, this.picture, this.sales, this.brandId, this.readState, this.contentUrl, this.id, this.evaluate});

	MainNoticeNlist.fromJson(Map<String, dynamic> json) {
		flag = json['flag'];
		createTime = json['create_time'];
		author = json['author'];
		title = json['title'];
		type = json['type'];
		content = json['content'];
		picture = json['picture'];
		sales = json['sales'];
		brandId = json['brand_id'];
		readState = json['read_state'];
		contentUrl = json['content_url'];
		id = json['Id'];
		evaluate = json['evaluate'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['flag'] = this.flag;
		data['create_time'] = this.createTime;
		data['author'] = this.author;
		data['title'] = this.title;
		data['type'] = this.type;
		data['content'] = this.content;
		data['picture'] = this.picture;
		data['sales'] = this.sales;
		data['brand_id'] = this.brandId;
		data['read_state'] = this.readState;
		data['content_url'] = this.contentUrl;
		data['Id'] = this.id;
		data['evaluate'] = this.evaluate;
		return data;
	}
}
