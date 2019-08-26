class SharedLinkLogoEntity {
	String code;
	List<SharedLinkLogoData> data;

	SharedLinkLogoEntity({this.code, this.data});

	SharedLinkLogoEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<SharedLinkLogoData>();(json['data'] as List).forEach((v) { data.add(new SharedLinkLogoData.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SharedLinkLogoData {
	int x;
	int y;
	int nw;
	int id;
	String picUrl;
	int type;
	String picDesc;
	int brandId;

	SharedLinkLogoData({this.x, this.y, this.nw, this.id, this.picUrl, this.type, this.picDesc, this.brandId});

	SharedLinkLogoData.fromJson(Map<String, dynamic> json) {
		x = json['x'];
		y = json['y'];
		nw = json['nw'];
		id = json['id'];
		picUrl = json['pic_url'];
		type = json['type'];
		picDesc = json['pic_desc'];
		brandId = json['brand_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['x'] = this.x;
		data['y'] = this.y;
		data['nw'] = this.nw;
		data['id'] = this.id;
		data['pic_url'] = this.picUrl;
		data['type'] = this.type;
		data['pic_desc'] = this.picDesc;
		data['brand_id'] = this.brandId;
		return data;
	}
}
