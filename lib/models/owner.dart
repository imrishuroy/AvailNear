// import 'dart:convert';

// import 'package:equatable/equatable.dart';

// class Owner extends Equatable {
//   final String? ownerId;
//   final String? ownerName;
//   final String? ownerAddress;
//   final String? ownerPhNo;
//   final String? ownerEmail;
//   final String? ownerProfilePic;

//   const Owner({
//     this.ownerId,
//     this.ownerName,
//     this.ownerAddress,
//     this.ownerPhNo,
//     this.ownerEmail,
//     this.ownerProfilePic,
//   });

//   Owner copyWith({
//     String? ownerId,
//     String? ownerName,
//     String? ownerAddress,
//     String? ownerPhNo,
//     String? ownerEmail,
//     String? ownerProfilePic,
//   }) {
//     return Owner(
//       ownerId: ownerId ?? this.ownerId,
//       ownerName: ownerName ?? this.ownerName,
//       ownerAddress: ownerAddress ?? this.ownerAddress,
//       ownerPhNo: ownerPhNo ?? this.ownerPhNo,
//       ownerEmail: ownerEmail ?? this.ownerEmail,
//       ownerProfilePic: ownerProfilePic ?? this.ownerProfilePic,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'ownerId': ownerId,
//       'ownerName': ownerName,
//       'ownerAddress': ownerAddress,
//       'ownerPhNo': ownerPhNo,
//       'ownerEmail': ownerEmail,
//       'ownerProfilePic': ownerProfilePic,
//     };
//   }

//   factory Owner.fromMap(Map<String, dynamic> map) {
//     return Owner(
//       ownerId: map['ownerId'],
//       ownerName: map['ownerName'],
//       ownerAddress: map['ownerAddress'],
//       ownerPhNo: map['ownerPhNo'],
//       ownerEmail: map['ownerEmail'],
//       ownerProfilePic: map['ownerProfilePic'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Owner.fromJson(String source) => Owner.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Owner(ownerName: $ownerName, ownerAddress: $ownerAddress, ownerPhNo: $ownerPhNo, ownerEmail: $ownerEmail, ownerProfilePic: $ownerProfilePic, ownerId: $ownerId)';
//   }

//   @override
//   List<Object?> get props {
//     return [
//       ownerId,
//       ownerName,
//       ownerAddress,
//       ownerPhNo,
//       ownerEmail,
//       ownerProfilePic
//     ];
//   }
// }
