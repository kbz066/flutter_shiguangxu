class UserEntity {

	UserData data;

	UserEntity({ this.data});

	UserEntity.fromJson(Map<String, dynamic> json) {

		data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();

		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		return data;
	}
}

class UserData {
	int id;
	int passWord;
	String userName;

	UserData({this.passWord, this.userName});

	UserData.fromJson(Map<String, dynamic> json) {

		passWord = json['passWord'];
		userName = json['userName'];
		passWord = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['passWord'] = this.passWord;
		data['userName'] = this.userName;
		data['id'] = this.id;
		return data;
	}
}
