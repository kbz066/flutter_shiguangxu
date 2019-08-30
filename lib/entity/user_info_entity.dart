import 'dart:typed_data';

import 'package:dio/dio.dart';

class UserInfoEntity {

	UserInfoData data;

	UserInfoEntity({ this.data});

	UserInfoEntity.fromJson(Map<String, dynamic> json) {

		data = json['data'] != null ? new UserInfoData.fromJson(json['data']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();

		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		return data;
	}
}

class UserInfoData {
	int id;
	Uint8List headImage;
	String userName;
	String mobile;
	String email;
	int sex;
	String autograph;
	String birthday;
	String occupation;


	UserInfoData({this.id, this.headImage, this.userName, this.mobile, this.email,
		this.sex, this.autograph, this.birthday, this.occupation});

	UserInfoData.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		headImage = json['headImage'];
		userName = json['userName'];
		mobile = json['mobile'];

		email = json['email'];
		sex = json['sex'];
		autograph = json['autograph'];
		birthday = json['birthday'];
		occupation = json['occupation'];

	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['headImage'] = this.headImage;
		data['userName'] = this.userName;

		data['mobile'] = this.mobile;
		data['email'] = this.email;
		data['sex'] = this.sex;

		data['autograph'] = this.autograph;
		data['birthday'] = this.birthday;
		data['occupation'] = this.occupation;

		return data;
	}
}
