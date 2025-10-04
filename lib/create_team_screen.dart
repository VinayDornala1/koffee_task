import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:koffeekodes_task/user_list.dart';
import 'create_team/create_team_cubit.dart';
import 'create_team/create_team_state.dart';
import 'dart:io';
import '../repository/user_repository.dart';

class CreateTeamScreen extends StatelessWidget {
  const CreateTeamScreen({super.key});

  static const countryList = [
    {'id': 101, 'name': 'India'},
    {'id': 102, 'name': 'USA'},
  ];
  static const stateList = [
    {'id': 12, 'name': 'Gujarat'},
    {'id': 13, 'name': 'California'},
  ];
  static const cityList = [
    {'id': 1041, 'name': 'Surat'},
    {'id': 1042, 'name': 'Los Angeles'},
  ];
  static const roleList = [
    {'id': 1, 'name': 'Master Role'},
    {'id': 2, 'name': 'LClient Role'},
    {'id': 3, 'name': 'HR'},
    {'id': 4, 'name': 'Employee Role'},
    {'id': 5, 'name': 'Director'},
    {'id': 6, 'name': 'Admin'},
  ];

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact number is required';
    }
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[^0-9]'), ''))) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pin code is required';
    }
    final pinRegex = RegExp(r'^[0-9]{6}$');
    if (!pinRegex.hasMatch(value)) {
      return 'Please enter a valid 6-digit pin code';
    }
    return null;
  }

  String? _validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (int.tryParse(value) == null) {
      return '$fieldName must be a number';
    }
    return null;
  }

  bool _validatePage0(CreateTeamState state) {
    return _validateRequired(state.title, 'Title') == null &&
        _validateRequired(state.firstName, 'First name') == null &&
        _validateRequired(state.lastName, 'Last name') == null &&
        _validateRequired(state.employeeId, 'Employee ID') == null &&
        _validateEmail(state.email) == null &&
        _validatePhone(state.contactNumber) == null &&
        _validateRequired(state.gender, 'Gender') == null &&
        _validateRequired(state.username, 'Username') == null &&
        _validatePassword(state.password) == null &&
        state.dob != null &&
        _validateRequired(state.emergencyName, 'Emergency contact name') == null &&
        _validatePhone(state.emergencyContact) == null &&
        _validateRequired(state.emergencyRelation, 'Emergency relation') == null;
  }

  bool _validatePage1(CreateTeamState state) {
    return _validateRequired(state.address, 'Address') == null &&
        state.countryId != null &&
        state.stateId != null &&
        state.cityId != null &&
        _validatePinCode(state.pinCode) == null &&
        _validateRequired(state.designation, 'Designation') == null &&
        _validateRequired(state.department, 'Department') == null &&
        _validateNumeric(state.totalAssignedLeave, 'Total assigned leave') == null;
  }

  bool _validatePage2(CreateTeamState state) {
    return state.joiningDate != null &&
        _validateRequired(state.selectedTeam, 'Team') == null &&
        state.roleId != null &&
        _validateRequired(state.workRegion, 'Work region') == null &&
        _validateRequired(state.shift, 'Shift') == null &&
        state.imageId != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Create new team'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocProvider(
        create: (_) => CreateTeamCubit(),
        child: BlocConsumer<CreateTeamCubit, CreateTeamState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = context.read<CreateTeamCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          color: Colors.teal,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 4,
                          color: state.pageIndex >= 1
                              ? Colors.teal
                              : Colors.teal.withOpacity(0.3),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 4,
                          color: state.pageIndex == 2
                              ? Colors.teal
                              : Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (state.pageIndex == 0) ...[
                    const Text('User Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        errorText: _validateRequired(state.title, 'Title'),
                      ),
                      value: state.title,
                      hint: const Text('MR'),
                      items: const [
                        DropdownMenuItem(value: 'MR', child: Text('MR')),
                        DropdownMenuItem(value: 'MRS', child: Text('MRS')),
                        DropdownMenuItem(value: 'MS', child: Text('MS')),
                      ],
                      onChanged: cubit.updateTitle,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: state.firstName,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              border: const OutlineInputBorder(),
                              errorText: _validateRequired(state.firstName, 'First name'),
                            ),
                            onChanged: cubit.updateFirstName,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            initialValue: state.lastName,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              border: const OutlineInputBorder(),
                              errorText: _validateRequired(state.lastName, 'Last name'),
                            ),
                            onChanged: cubit.updateLastName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.employeeId,
                      decoration: InputDecoration(
                        labelText: 'Employee ID',
                        border: const OutlineInputBorder(),
                        errorText: _validateRequired(state.employeeId, 'Employee ID'),
                      ),
                      onChanged: cubit.updateEmployeeId,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.email,
                      decoration: InputDecoration(
                        labelText: 'Email ID',
                        border: const OutlineInputBorder(),
                        errorText: _validateEmail(state.email),
                      ),
                      onChanged: cubit.updateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: state.contactNumber,
                            decoration: InputDecoration(
                              labelText: 'Contact Number',
                              border: const OutlineInputBorder(),
                              errorText: _validatePhone(state.contactNumber),
                            ),
                            onChanged: cubit.updateContactNumber,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            initialValue: state.gender,
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              border: const OutlineInputBorder(),
                              errorText: _validateRequired(state.gender, 'Gender'),
                            ),
                            onChanged: cubit.updateGender,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.username,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: const OutlineInputBorder(),
                        errorText: _validateRequired(state.username, 'Username'),
                      ),
                      onChanged: cubit.updateUsername,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: state.autoUsername,
                          onChanged: (value) =>
                              cubit.updateAutoUsername(value ?? false),
                        ),
                        const Text('Check to auto generated user name.'),
                      ],
                    ),
                    TextFormField(
                      initialValue: state.password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        errorText: _validatePassword(state.password),
                      ),
                      obscureText: true,
                      onChanged: cubit.updatePassword,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: state.autoPassword,
                          onChanged: (value) =>
                              cubit.updateAutoPassword(value ?? false),
                        ),
                        const Text('Check to auto generated password.'),
                      ],
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: state.dob != null
                            ? "${state.dob!.day}/${state.dob!.month}/${state.dob!.year}"
                            : '',
                      ),
                      decoration: InputDecoration(
                        labelText: 'Date Of Birth',
                        border: const OutlineInputBorder(),
                        errorText: state.dob == null ? 'Date of birth is required' : null,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today,
                              color: Colors.teal),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: state.dob ?? DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) cubit.updateDob(picked);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('Emergency Contact',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.emergencyName,
                      decoration: InputDecoration(
                        labelText: 'Person Name',
                        border: const OutlineInputBorder(),
                        errorText: _validateRequired(state.emergencyName, 'Emergency contact name'),
                      ),
                      onChanged: cubit.updateEmergencyName,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: state.emergencyContact,
                            decoration: InputDecoration(
                              labelText: 'Contact Number',
                              border: const OutlineInputBorder(),
                              errorText: _validatePhone(state.emergencyContact),
                            ),
                            onChanged: cubit.updateEmergencyContact,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            initialValue: state.emergencyRelation,
                            decoration: InputDecoration(
                              labelText: 'Relation',
                              border: const OutlineInputBorder(),
                              errorText: _validateRequired(state.emergencyRelation, 'Emergency relation'),
                            ),
                            onChanged: cubit.updateEmergencyRelation,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _validatePage0(state) ? Colors.teal : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _validatePage0(state) ? () {
                          cubit.updatePageIndex(1);
                        } : null,
                        child: const Text('NEXT'),
                      ),
                    ),
                  ] else if (state.pageIndex == 1) ...[
                    const Text('Additional Information',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: state.address,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        border: const OutlineInputBorder(),
                        errorText: _validateRequired(state.address, 'Address'),
                      ),
                      onChanged: cubit.updateAddress,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: 'Country',
                              border: const OutlineInputBorder(),
                              errorText: state.countryId == null ? 'Country is required' : null,
                            ),
                            value: state.countryId,
                            hint: const Text('Country'),
                            items: countryList
                                .map((country) => DropdownMenuItem<int>(
                              value: country['id'] as int,
                              child: Text(country['name'] as String),
                            ))
                                .toList(),
                            onChanged: cubit.updateCountryId,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: 'State',
                              border: const OutlineInputBorder(),
                              errorText: state.stateId == null ? 'State is required' : null,
                            ),
                            value: state.stateId,
                            hint: const Text('State'),
                            items: stateList
                                .map((state) => DropdownMenuItem<int>(
                              value: state['id'] as int,
                              child: Text(state['name'] as String),
                            ))
                                .toList(),
                            onChanged: cubit.updateStateId,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: 'City',
                              border: const OutlineInputBorder(),
                              errorText: state.cityId == null ? 'City is required' : null,
                            ),
                            value: state.cityId,
                            hint: const Text('City'),
                            items: cityList
                                .map((city) => DropdownMenuItem<int>(
                              value: city['id'] as int,
                              child: Text(city['name'] as String),
                            ))
                                .toList(),
                            onChanged: cubit.updateCityId,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            initialValue: state.pinCode,
                            decoration: InputDecoration(
                              labelText: 'Pin Code',
                              border: const OutlineInputBorder(),
                              errorText: _validatePinCode(state.pinCode),
                            ),
                            onChanged: cubit.updatePinCode,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.designation,
                      decoration: InputDecoration(
                        labelText: 'Designation',
                        border: const OutlineInputBorder(),
                        errorText: _validateRequired(state.designation, 'Designation'),
                      ),
                      onChanged: cubit.updateDesignation,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.department,
                      decoration: InputDecoration(
                        labelText: 'Department',
                        border: const OutlineInputBorder(),
                        errorText: _validateRequired(state.department, 'Department'),
                      ),
                      onChanged: cubit.updateDepartment,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.totalAssignedLeave,
                      decoration: InputDecoration(
                        labelText: 'Total Assigned Leave',
                        border: const OutlineInputBorder(),
                        errorText: _validateNumeric(state.totalAssignedLeave, 'Total assigned leave'),
                      ),
                      onChanged: cubit.updateTotalAssignedLeave,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      onTap: () async {
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: [
                            'pdf',
                            'doc',
                            'docx',
                            'jpg',
                            'png'
                          ],
                        );
                        if (result != null && result.files.isNotEmpty) {
                          context
                              .read<CreateTeamCubit>()
                              .updateUploadFileName(result.files.single.name);
                        }
                      },
                      readOnly: true,
                      controller: TextEditingController(
                          text: state.uploadFileName ?? ''),
                      decoration: const InputDecoration(
                        labelText: 'Upload File',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon:
                          Icon(Icons.upload_file, color: Colors.teal),
                          onPressed: null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _validatePage1(state) ? Colors.teal : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _validatePage1(state) ? () {
                          cubit.updatePageIndex(2);
                        } : null,
                        child: const Text('NEXT'),
                      ),
                    ),
                  ] else if (state.pageIndex == 2) ...[
                    const Text('User Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 16),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: state.joiningDate != null
                            ? "${state.joiningDate!.day}/${state.joiningDate!.month}/${state.joiningDate!.year}"
                            : '',
                      ),
                      decoration: InputDecoration(
                        labelText: 'Joining Date',
                        border: const OutlineInputBorder(),
                        errorText: state.joiningDate == null ? 'Joining date is required' : null,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today, color: Colors.teal),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: state.joiningDate ?? DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) cubit.updateJoiningDate(picked);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Team',
                        border: const OutlineInputBorder(),
                        errorText: _validateRequired(state.selectedTeam, 'Team'),
                      ),
                      value: state.selectedTeam,
                      items: ['Team A', 'Team B'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                      onChanged: cubit.updateSelectedTeam,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Role',
                        border: const OutlineInputBorder(),
                        errorText: state.roleId == null ? 'Role is required' : null,
                      ),
                      value: state.roleId,
                      hint: const Text('Role'),
                      items: roleList
                          .map((role) => DropdownMenuItem<int>(
                        value: role['id'] as int,
                        child: Text(role['name'] as String),
                      ))
                          .toList(),
                      onChanged: cubit.updateRoleId,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Work Region',
                        border: const OutlineInputBorder(),
                        errorText: _validateRequired(state.workRegion, 'Work region'),
                      ),
                      value: state.workRegion,
                      items: ['Region 1', 'Region 2'].map((w) => DropdownMenuItem(value: w, child: Text(w))).toList(),
                      onChanged: cubit.updateWorkRegion,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Shift',
                        border: const OutlineInputBorder(),
                        errorText: _validateRequired(state.shift, 'Shift'),
                      ),
                      value: state.shift,
                      items: ['Morning', 'Evening'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: cubit.updateShift,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      readOnly: true,
                      onTap: () async {
                        final result = await FilePicker.platform.pickFiles(type: FileType.image);
                        if (result != null && result.files.isNotEmpty) {
                          final imagePath = result.files.single.path!;
                          cubit.updateUploadImagePath(imagePath);

                          final repo = UserRepository();
                          try {
                            final response = await repo.uploadImage(imagePath);
                            print('Uploaded image URL: ${response.data.first.id}');
                            cubit.updateImageId(response.data.first.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Image uploaded: ${response.data.first.path}')),
                            );
                          } catch (e) {
                            print('Image upload failed: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Image upload failed')),
                            );
                          }
                        }
                      },
                      initialValue: state.uploadImagePath ?? '',
                      decoration: InputDecoration(
                        labelText: 'Upload Image',
                        border: const OutlineInputBorder(),
                        errorText: state.imageId == null ? 'Profile image is required' : null,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.upload_file, color: Colors.teal),
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(type: FileType.image);
                            if (result != null && result.files.isNotEmpty) {
                              final imagePath = result.files.single.path!;
                              cubit.updateUploadImagePath(imagePath);

                              final repo = UserRepository();
                              try {
                                final response = await repo.uploadImage(imagePath);
                                print('Uploaded image URL: ${response.data.first.path}');
                                cubit.updateImageId(response.data.first.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Image uploaded: ${response.data.first.path}')),
                                );
                              } catch (e) {
                                print('Image upload failed: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Image upload failed')),
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    if (state.uploadImagePath != null) ...[
                      const SizedBox(height: 12),
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.teal),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.file(
                              File(state.uploadImagePath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.teal),
                              onPressed: () {
                                cubit.updateUploadImagePath(null);
                                cubit.updateImageId(null);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _validatePage2(state) ? Colors.teal : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _validatePage2(state) ? () async {
                          final cubit = context.read<CreateTeamCubit>();
                          final state = cubit.state;

                          if (!_validatePage0(state) || !_validatePage1(state) || !_validatePage2(state)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill all required fields correctly')),
                            );
                            return;
                          }

                          final userData = {
                            "username": state.username,
                            "password": state.password,
                            "roleId": state.roleId,
                            "first_name": state.firstName,
                            "last_name": state.lastName,
                            "email": state.email,
                            "mobile": state.contactNumber,
                            "address": state.address,
                            "pincode": state.pinCode,
                            "country": state.countryId,
                            "stateId": state.stateId,
                            "cityId": state.cityId,
                            "departmentId": null,
                            "designationId": null,
                            "joining_date": state.joiningDate?.toIso8601String(),
                            "gender": state.gender,
                            "total_leave": int.tryParse(state.totalAssignedLeave ?? '0'),
                            "image": state.imageId,
                            "dob": state.dob?.toIso8601String(),
                            "screen_monitoring": false,
                            "employee_id": state.employeeId,
                          };

                          try {
                            await UserRepository().createUser(userData);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('User created successfully')),
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserList()));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to create user: $e')),
                            );
                          }
                        } : null,
                        child: const Text('SUBMIT'),
                      ),
                    ),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}