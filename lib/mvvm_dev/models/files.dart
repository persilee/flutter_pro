import 'package:equatable/equatable.dart';

class Files extends Equatable {
	final int id;
	final int width;
	final int height;
	final String largeImageUrl;
	final String mediumImageUrl;
	final String thumbnailImageUrl;

	const Files({
		this.id,
		this.width,
		this.height,
		this.largeImageUrl,
		this.mediumImageUrl,
		this.thumbnailImageUrl,
	});

	@override
	String toString() {
		return 'Files(id: $id, width: $width, height: $height, largeImageUrl: $largeImageUrl, mediumImageUrl: $mediumImageUrl, thumbnailImageUrl: $thumbnailImageUrl)';
	}

	factory Files.fromJson(Map<String, dynamic> json) {
		return Files(
			id: json['id'] as int,
			width: json['width'] as int,
			height: json['height'] as int,
			largeImageUrl: json['largeImageUrl'] as String,
			mediumImageUrl: json['mediumImageUrl'] as String,
			thumbnailImageUrl: json['thumbnailImageUrl'] as String,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'width': width,
			'height': height,
			'largeImageUrl': largeImageUrl,
			'mediumImageUrl': mediumImageUrl,
			'thumbnailImageUrl': thumbnailImageUrl,
		};
	}

	Files copyWith({
		int id,
		int width,
		int height,
		String largeImageUrl,
		String mediumImageUrl,
		String thumbnailImageUrl,
	}) {
		return Files(
			id: id ?? this.id,
			width: width ?? this.width,
			height: height ?? this.height,
			largeImageUrl: largeImageUrl ?? this.largeImageUrl,
			mediumImageUrl: mediumImageUrl ?? this.mediumImageUrl,
			thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
		);
	}

	@override
	List<Object> get props {
		return [
			id,
			width,
			height,
			largeImageUrl,
			mediumImageUrl,
			thumbnailImageUrl,
		];
	}
}
