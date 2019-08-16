class ScheduleEntity {
	String msg;
	int code;
	List<ScheduleData> data;

	ScheduleEntity({this.msg, this.code, this.data});

	ScheduleEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<ScheduleData>();(json['data'] as List).forEach((v) { data.add(new ScheduleData.fromJson(v)); });
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

class ScheduleData {
	int month;
	int level;
	int year;
	int id;
	int state;
	int type;
	String title;
	int day;

	ScheduleData({this.month, this.level, this.year, this.id, this.state, this.type, this.title, this.day});

	ScheduleData.fromJson(Map<String, dynamic> json) {
		month = json['month'];
		level = json['level'];
		year = json['year'];
		id = json['id'];
		state = json['state'];
		type = json['type'];
		title = json['title'];
		day = json['day'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['month'] = this.month;
		data['level'] = this.level;
		data['year'] = this.year;
		data['id'] = this.id;
		data['state'] = this.state;
		data['type'] = this.type;
		data['title'] = this.title;
		data['day'] = this.day;
		return data;
	}
}
