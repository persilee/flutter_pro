import 'package:equatable/equatable.dart';

class Avatar extends Equatable {
	final String largeAvatarUrl;
	final String smallAvatarUrl;
	final String mediumAvatarUrl;

	const Avatar({
		this.largeAvatarUrl,
		this.smallAvatarUrl,
		this.mediumAvatarUrl,
	});

	@override
	String toString() {
		return 'Avatar(largeAvatarUrl: $largeAvatarUrl, smallAvatarUrl: $smallAvatarUrl, mediumAvatarUrl: $mediumAvatarUrl)';
	}

	factory Avatar.fromJson(Map<String, dynamic> json) {
		return Avatar(
			largeAvatarUrl: json['largeAvatarUrl'] as String,
			smallAvatarUrl: json['smallAvatarUrl'] as String,
			mediumAvatarUrl: json['mediumAvatarUrl'] as String,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'largeAvatarUrl': largeAvatarUrl,
			'smallAvatarUrl': smallAvatarUrl,
			'mediumAvatarUrl': mediumAvatarUrl,
		};
	}

	Avatar copyWith({
		String largeAvatarUrl,
		String smallAvatarUrl,
		String mediumAvatarUrl,
	}) {
		return Avatar(
			largeAvatarUrl: largeAvatarUrl ?? this.largeAvatarUrl,
			smallAvatarUrl: smallAvatarUrl ?? this.smallAvatarUrl,
			mediumAvatarUrl: mediumAvatarUrl ?? this.mediumAvatarUrl,
		);
	}

	@override
	List<Object> get props {
		return [
			largeAvatarUrl,
			smallAvatarUrl,
			mediumAvatarUrl,
		];
	}
}
