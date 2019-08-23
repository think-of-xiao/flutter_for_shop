class MainBannerEntity {
	String invitationState;
	List<MainBannerHomepagelist> homepagelist;
	String mobileState;
	List<Null> mypagelist;

	MainBannerEntity({this.invitationState, this.homepagelist, this.mobileState, this.mypagelist});

	MainBannerEntity.fromJson(Map<String, dynamic> json) {
		invitationState = json['invitation_state'];
		if (json['Homepagelist'] != null) {
			homepagelist = new List<MainBannerHomepagelist>();(json['Homepagelist'] as List).forEach((v) { homepagelist.add(new MainBannerHomepagelist.fromJson(v)); });
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

class MainBannerHomepagelist {
	String menuLogo;
	String menuUrl;
	int menuId;
	String describes;

	MainBannerHomepagelist({this.menuLogo, this.menuUrl, this.menuId, this.describes});

	MainBannerHomepagelist.fromJson(Map<String, dynamic> json) {
		menuLogo = json['menu_logo'];
		menuUrl = json['menu_url'];
		menuId = json['menu_id'];
		describes = json['describes'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['menu_logo'] = this.menuLogo;
		data['menu_url'] = this.menuUrl;
		data['menu_id'] = this.menuId;
		data['describes'] = this.describes;
		return data;
	}
}
