import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_team_state.dart';

class CreateTeamCubit extends Cubit<CreateTeamState> {
  CreateTeamCubit() : super(const CreateTeamState());

  void updateTitle(String? value) => emit(state.copyWith(title: value));
  void updateFirstName(String value) => emit(state.copyWith(firstName: value));
  void updateLastName(String value) => emit(state.copyWith(lastName: value));
  void updateEmployeeId(String value) => emit(state.copyWith(employeeId: value));
  void updateEmail(String value) => emit(state.copyWith(email: value));
  void updateContactNumber(String value) => emit(state.copyWith(contactNumber: value));
  void updateGender(String value) => emit(state.copyWith(gender: value));
  void updateUsername(String value) => emit(state.copyWith(username: value));
  void updateAutoUsername(bool value) => emit(state.copyWith(autoUsername: value));
  void updatePassword(String value) => emit(state.copyWith(password: value));
  void updateAutoPassword(bool value) => emit(state.copyWith(autoPassword: value));
  void updateDob(DateTime value) => emit(state.copyWith(dob: value));
  void updateEmergencyName(String value) => emit(state.copyWith(emergencyName: value));
  void updateEmergencyContact(String value) => emit(state.copyWith(emergencyContact: value));
  void updateEmergencyRelation(String value) => emit(state.copyWith(emergencyRelation: value));
  void updatePageIndex(int value) => emit(state.copyWith(pageIndex: value));
  void updateAddress(String value) => emit(state.copyWith(address: value));
  void updateCountryId(int? value) => emit(state.copyWith(countryId: value));
  void updateRoleId(int? value) => emit(state.copyWith(roleId: value));
  void updateStateId(int? value) => emit(state.copyWith(stateId: value));
  void updateCityId(int? value) => emit(state.copyWith(cityId: value));
  void updateImageId(int? value) => emit(state.copyWith(imageId: value));
  void updatePinCode(String value) => emit(state.copyWith(pinCode: value));
  void updateDesignation(String value) => emit(state.copyWith(designation: value));
  void updateDepartment(String value) => emit(state.copyWith(department: value));
  void updateTotalAssignedLeave(String value) => emit(state.copyWith(totalAssignedLeave: value));
  void updateUploadFileName(String value) => emit(state.copyWith(uploadFileName: value));
  void updateJoiningDate(DateTime value) => emit(state.copyWith(joiningDate: value));
  void updateSelectedTeam(String? value) => emit(state.copyWith(selectedTeam: value));
  void updateRole(String? value) => emit(state.copyWith(role: value));
  void updateWorkRegion(String? value) => emit(state.copyWith(workRegion: value));
  void updateShift(String? value) => emit(state.copyWith(shift: value));
  void updateUploadImagePath(String? value) => emit(state.copyWith(uploadImagePath: value));
}
