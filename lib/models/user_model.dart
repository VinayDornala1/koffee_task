class UserListResponse {
  final int statusCode;
  final String status;
  final bool success;
  final String message;
  final UserListData data;

  UserListResponse({
    required this.statusCode,
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) {
    return UserListResponse(
      statusCode: json['status_code'],
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: UserListData.fromJson(json['data']),
    );
  }
}

class UserListData {
  final int totalDocs;
  final List<User> users;

  UserListData({
    required this.totalDocs,
    required this.users,
  });

  factory UserListData.fromJson(Map<String, dynamic> json) {
    return UserListData(
      totalDocs: json['totalDocs'],
      users: List<User>.from(json['data'].map((x) => User.fromJson(x))),
    );
  }
}

class User {
  final int id;
  final String username;
  final String? password;
  final bool isActive;
  final String joiningDate;
  final String? exitDate;
  final bool screenMonitoring;
  final String? employeeId;
  final String? lastLogin;
  final Profile profile;
  final Role role;
  final String totalLeave;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.isActive,
    required this.joiningDate,
    this.exitDate,
    required this.screenMonitoring,
    this.employeeId,
    this.lastLogin,
    required this.profile,
    required this.role,
    required this.totalLeave,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      isActive: json['is_Active'],
      joiningDate: json['joining_date'],
      exitDate: json['exit_date'],
      screenMonitoring: json['screen_monitoring'],
      employeeId: json['employee_id'],
      lastLogin: json['last_login'],
      profile: Profile.fromJson(json['profile']),
      role: Role.fromJson(json['role']),
      totalLeave: json['total_leave'],
    );
  }
}

class Profile {
  final int id;
  final String email;
  final String mobile;
  final String? address;
  final String? pincode;
  final String firstName;
  final String lastName;
  final String gender;
  final dynamic image;
  final String dob;
  final Department? department;
  final Designation? designation;
  final City? city;
  final State? state;
  final Country? countryInfo;
  final dynamic images;

  Profile({
    required this.id,
    required this.email,
    required this.mobile,
    required this.address,
    this.pincode,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.image,
    required this.dob,
    this.department,
    this.designation,
    this.city,
    this.state,
    this.countryInfo,
    this.images,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      email: json['email'],
      mobile: json['mobile'],
      address: json['address'],
      pincode: json['pincode'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      image: json['image'],
      dob: json['dob'],
      department: json['department'] != null ? Department.fromJson(json['department']) : null,
      designation: json['designation'] != null ? Designation.fromJson(json['designation']) : null,
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      state: json['state'] != null ? State.fromJson(json['state']) : null,
      countryInfo: json['countryinfo'] != null ? Country.fromJson(json['countryinfo']) : null,
      images: json['images'],
    );
  }
}

class Department {
  final int id;
  final String name;

  Department({required this.id, required this.name});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(id: json['id'], name: json['name']);
  }
}

class Designation {
  final int id;
  final String name;

  Designation({required this.id, required this.name});

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(id: json['id'], name: json['name']);
  }
}

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(id: json['id'], name: json['name']);
  }
}

class State {
  final int id;
  final String name;

  State({required this.id, required this.name});

  factory State.fromJson(Map<String, dynamic> json) {
    return State(id: json['id'], name: json['name']);
  }
}

class Country {
  final int id;
  final String name;

  Country({required this.id, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(id: json['id'], name: json['name']);
  }
}

class Role {
  final int id;
  final String name;

  Role({required this.id, required this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(id: json['id'], name: json['name']);
  }
}
