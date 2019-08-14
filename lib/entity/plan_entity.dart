class PlanEntity {
	String msg;
	int code;
	List<PlanData> data;

	PlanEntity({this.msg, this.code, this.data});

	PlanEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<PlanData>();(json['data'] as List).forEach((v) { data.add(new PlanData.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.data != null) {
			data['data'] =  this.data.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

class PlanData {
	int level;
	int id;
	int state;
	int type;
	String title;

	PlanData({this.level, this.id, this.state, this.type, this.title});

	PlanData.fromJson(Map<String, dynamic> json) {
		level = json['level'];
		id = json['id'];
		state = json['state'];
		type = json['type'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['level'] = this.level;
		data['id'] = this.id;
		data['state'] = this.state;
		data['type'] = this.type;
		data['title'] = this.title;
		return data;
	}
}
