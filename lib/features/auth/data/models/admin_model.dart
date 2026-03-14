import 'package:cloud_firestore/cloud_firestore.dart';

/// Enum for application roles.
enum AppRole { admin, user }

/// Model representing an admin user in the system.
class AdminModel {
  final String? id;
  final String email;
  final String firstName;
  final String lastName;
  final String userName;
  final String phoneNumber;
  final String profilePicture;
  final AppRole role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Constructor for AdminModel.
  AdminModel({
    this.id,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.userName = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = AppRole.admin,
    this.createdAt,
    this.updatedAt,
  });

  /// Helper methods
  String get fullName => '$firstName $lastName';

  /// Static function to create an empty admin model.
  static AdminModel empty() => AdminModel(email: '');

  /// Convert model to JSON structure for storing in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.name.toString(),
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt ?? DateTime.now(),
    };
  }

  /// Factory method to create an AdminModel from a Firebase document snapshot.
  factory AdminModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return AdminModel(
        id: document.id,
        firstName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
        userName: data.containsKey('UserName') ? data['UserName'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        phoneNumber:
            data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
        profilePicture:
            data.containsKey('ProfilePicture')
                ? data['ProfilePicture'] ?? ''
                : '',
        role:
            data.containsKey('Role')
                ? (data['Role'] == AppRole.admin.name.toString()
                    ? AppRole.admin
                    : AppRole.user)
                : AppRole.user,
        createdAt:
            data.containsKey('CreatedAt')
                ? (data['CreatedAt'] as Timestamp?)?.toDate()
                : null,
        updatedAt:
            data.containsKey('UpdatedAt')
                ? (data['UpdatedAt'] as Timestamp?)?.toDate()
                : null,
      );
    } else {
      return AdminModel.empty();
    }
  }
}
