import 'package:flutter/foundation.dart';

@immutable
class CreateTeamState {
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? employeeId;
  final String? email;
  final String? contactNumber;
  final String? gender;
  final String? username;
  final bool autoUsername;
  final String? password;
  final bool autoPassword;
  final DateTime? dob;
  final String? emergencyName;
  final String? emergencyContact;
  final String? emergencyRelation;
  final int pageIndex;
  final String? address;
  final int? countryId;
  final int? stateId;
  final int? cityId;
  final int? roleId;
  final int? imageId;
  final String? pinCode;
  final String? designation;
  final String? department;
  final String? totalAssignedLeave;
  final String? uploadFileName;
  final DateTime? joiningDate;
  final String? selectedTeam;
  final String? role;
  final String? workRegion;
  final String? shift;
  final String? uploadImagePath;

  const CreateTeamState({
    this.title,
    this.firstName,
    this.lastName,
    this.employeeId,
    this.email,
    this.contactNumber,
    this.gender,
    this.username,
    this.autoUsername = false,
    this.password,
    this.autoPassword = false,
    this.dob,
    this.emergencyName,
    this.emergencyContact,
    this.emergencyRelation,
    this.pageIndex = 0,
    this.address,
    this.countryId,
    this.stateId,
    this.cityId,
    this.imageId,
    this.roleId,
    this.pinCode,
    this.designation,
    this.department,
    this.totalAssignedLeave,
    this.uploadFileName,
    this.joiningDate,
    this.selectedTeam,
    this.role,
    this.workRegion,
    this.shift,
    this.uploadImagePath,
  });

  CreateTeamState copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? employeeId,
    String? email,
    String? contactNumber,
    String? gender,
    String? username,
    bool? autoUsername,
    String? password,
    bool? autoPassword,
    DateTime? dob,
    String? emergencyName,
    String? emergencyContact,
    String? emergencyRelation,
    int? pageIndex,
    String? address,
    int? countryId,
    int? stateId,
    int? cityId,
    int? roleId,
    int? imageId,
    String? pinCode,
    String? designation,
    String? department,
    String? totalAssignedLeave,
    String? uploadFileName,
    DateTime? joiningDate,
    String? selectedTeam,
    String? role,
    String? workRegion,
    String? shift,
    String? uploadImagePath,
  }) {
    return CreateTeamState(
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      employeeId: employeeId ?? this.employeeId,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      gender: gender ?? this.gender,
      username: username ?? this.username,
      autoUsername: autoUsername ?? this.autoUsername,
      password: password ?? this.password,
      autoPassword: autoPassword ?? this.autoPassword,
      dob: dob ?? this.dob,
      emergencyName: emergencyName ?? this.emergencyName,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyRelation: emergencyRelation ?? this.emergencyRelation,
      pageIndex: pageIndex ?? this.pageIndex,
      address: address ?? this.address,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
      roleId: roleId ?? this.roleId,
      imageId: imageId ?? this.imageId,
      pinCode: pinCode ?? this.pinCode,
      designation: designation ?? this.designation,
      department: department ?? this.department,
      totalAssignedLeave: totalAssignedLeave ?? this.totalAssignedLeave,
      uploadFileName: uploadFileName ?? this.uploadFileName,
      joiningDate: joiningDate ?? this.joiningDate,
      selectedTeam: selectedTeam ?? this.selectedTeam,
      role: role ?? this.role,
      workRegion: workRegion ?? this.workRegion,
      shift: shift ?? this.shift,
      uploadImagePath: uploadImagePath ?? this.uploadImagePath,
    );
  }
}
