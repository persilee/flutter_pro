import 'package:equatable/equatable.dart';

import "avatar.dart";

class User extends Equatable {
	final int id;
	final String name;
	final Avatar avatar;

	const User({
		this.id,
		this.name,
		this.avatar,
	});

	@override
	String toString() {
		return 'User(id: $id, name: $name, avatar: $avatar)';
	}

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			id: json['id'] as int,
			name: json['name'] as String,
			avatar: json['avatar'] == null
					? null
					: Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'name': name,
			'avatar': avatar?.toJson(),
		};
	}

	User copyWith({
		int id,
		String name,
		Avatar avatar,
	}) {
		return User(
			id: id ?? this.id,
			name: name ?? this.name,
			avatar: avatar ?? this.avatar,
		);
	}

	@override
	List<Object> get props => [id, name, avatar];
}
