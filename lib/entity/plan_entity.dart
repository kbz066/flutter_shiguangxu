class PlanEntity {
	String msg;
	int code;
	PlanData data;

	PlanEntity({this.msg, this.code, this.data});

	PlanEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		data = json['data'] != null ? new PlanData.fromJson(json['data']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		return data;
	}
}

class PlanData {
	int level;
	int state;
	int type;

	PlanData({this.level, this.state, this.type});

	PlanData.fromJson(Map<String, dynamic> json) {
		level = json['level'];
		state = json['state'];
		type = json['type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['level'] = this.level;
		data['state'] = this.state;
		data['type'] = this.type;
		return data;
	}
}
