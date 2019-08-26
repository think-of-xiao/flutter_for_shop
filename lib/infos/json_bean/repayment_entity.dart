class RepaymentEntity {
	String msg;
	List<RepaymantMergoods> mergoods;
	int deduction;
	String data;
	String userlevel;
	String gradeContrast;
	String openingAmount;
	double fee;
	String payFee;
	String checkcardAmount;
	String status;

	RepaymentEntity({this.msg, this.mergoods, this.deduction, this.data, this.userlevel, this.gradeContrast, this.openingAmount, this.fee, this.payFee, this.checkcardAmount, this.status});

	RepaymentEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		if (json['mergoods'] != null) {
			mergoods = new List<RepaymantMergoods>();(json['mergoods'] as List).forEach((v) { mergoods.add(new RepaymantMergoods.fromJson(v)); });
		}
		deduction = json['deduction'];
		data = json['data'];
		userlevel = json['userlevel'];
		gradeContrast = json['grade_contrast'];
		openingAmount = json['Opening_amount'];
		fee = json['fee'];
		payFee = json['pay_fee'];
		checkcardAmount = json['CheckCard_amount'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		if (this.mergoods != null) {
      data['mergoods'] =  this.mergoods.map((v) => v.toJson()).toList();
    }
		data['deduction'] = this.deduction;
		data['data'] = this.data;
		data['userlevel'] = this.userlevel;
		data['grade_contrast'] = this.gradeContrast;
		data['Opening_amount'] = this.openingAmount;
		data['fee'] = this.fee;
		data['pay_fee'] = this.payFee;
		data['CheckCard_amount'] = this.checkcardAmount;
		data['status'] = this.status;
		return data;
	}
}

class RepaymantMergoods {
	String goodsName;
	String goodsImage;
	String gradeContrast;
	String goodsDetails;
	String goodsDescribe;
	double goodsMoney;

	RepaymantMergoods({this.goodsName, this.goodsImage, this.gradeContrast, this.goodsDetails, this.goodsDescribe, this.goodsMoney});

	RepaymantMergoods.fromJson(Map<String, dynamic> json) {
		goodsName = json['goods_name'];
		goodsImage = json['goods_image'];
		gradeContrast = json['grade_contrast'];
		goodsDetails = json['goods_details'];
		goodsDescribe = json['goods_describe'];
		goodsMoney = json['goods_money'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['goods_name'] = this.goodsName;
		data['goods_image'] = this.goodsImage;
		data['grade_contrast'] = this.gradeContrast;
		data['goods_details'] = this.goodsDetails;
		data['goods_describe'] = this.goodsDescribe;
		data['goods_money'] = this.goodsMoney;
		return data;
	}
}
