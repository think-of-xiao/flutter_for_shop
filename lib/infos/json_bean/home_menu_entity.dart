class HomeMenuEntity {
	String invitationState;
	List<HomemanuHomepagelist> homepagelist;
	String mobileState;
	List<Null> mypagelist;

	HomeMenuEntity({this.invitationState, this.homepagelist, this.mobileState, this.mypagelist});

	HomeMenuEntity.fromJson(Map<String, dynamic> json) {
		invitationState = json['invitation_state'];
		if (json['Homepagelist'] != null) {
			homepagelist = new List<HomemanuHomepagelist>();(json['Homepagelist'] as List).forEach((v) { homepagelist.add(new HomemanuHomepagelist.fromJson(v)); });
		}
		mobileState = json['mobileState'];
		if (json['Mypagelist'] != null) {
			mypagelist = new List<Null>();
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['invitation_state'] = this.invitationState;
		if (this.homepagelist != null) {
      data['Homepagelist'] =  this.homepagelist.map((v) => v.toJson()).toList();
    }
		data['mobileState'] = this.mobileState;
		if (this.mypagelist != null) {
      data['Mypagelist'] =  [];
    }
		return data;
	}
}

class HomemanuHomepagelist {
	String menuLogo;
	String illustrate;
	String menuUrl;
	int menuId;
	String describes;

	HomemanuHomepagelist({this.menuLogo, this.illustrate, this.menuUrl, this.menuId, this.describes});

	HomemanuHomepagelist.fromJson(Map<String, dynamic> json) {
		menuLogo = json['menu_logo'];
		illustrate = json['illustrate'];
		menuUrl = json['menu_url'];
		menuId = json['menu_id'];
		describes = json['describes'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['menu_logo'] = this.menuLogo;
		data['illustrate'] = this.illustrate;
		data['menu_url'] = this.menuUrl;
		data['menu_id'] = this.menuId;
		data['describes'] = this.describes;
		return data;
	}
}
