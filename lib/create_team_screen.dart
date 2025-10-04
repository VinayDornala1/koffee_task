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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
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
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
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
                            decoration: const InputDecoration(
                                labelText: 'First Name',
                                border: OutlineInputBorder()),
                            onChanged: cubit.updateFirstName,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            initialValue: state.lastName,
                            decoration: const InputDecoration(
                                labelText: 'Last Name',
                                border: OutlineInputBorder()),
                            onChanged: cubit.updateLastName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.employeeId,
                      decoration: const InputDecoration(
                          labelText: 'Employee ID',
                          border: OutlineInputBorder()),
                      onChanged: cubit.updateEmployeeId,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.email,
                      decoration: const InputDecoration(
                          labelText: 'Email ID', border: OutlineInputBorder()),
                      onChanged: cubit.updateEmail,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: state.contactNumber,
                            decoration: const InputDecoration(
                                labelText: 'Contact Number',
                                border: OutlineInputBorder()),
                            onChanged: cubit.updateContactNumber,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            initialValue: state.gender,
                            decoration: const InputDecoration(
                                labelText: 'Gender',
                                border: OutlineInputBorder()),
                            onChanged: cubit.updateGender,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.username,
                      decoration: const InputDecoration(
                          labelText: 'Username', border: OutlineInputBorder()),
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
                      decoration: const InputDecoration(
                          labelText: 'Password', border: OutlineInputBorder()),
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
                      decoration: const InputDecoration(
                          labelText: 'Person Name',
                          border: OutlineInputBorder()),
                      onChanged: cubit.updateEmergencyName,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: state.emergencyContact,
                            decoration: const InputDecoration(
                                labelText: 'Contact Number',
                                border: OutlineInputBorder()),
                            onChanged: cubit.updateEmergencyContact,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            initialValue: state.emergencyRelation,
                            decoration: const InputDecoration(
                                labelText: 'Relation',
                                border: OutlineInputBorder()),
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
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          cubit.updatePageIndex(1);
                        },
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
                      decoration: const InputDecoration(
                          labelText: 'Address', border: OutlineInputBorder()),
                      onChanged: cubit.updateAddress,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            decoration: const InputDecoration(
                                labelText: 'Country',
                                border: OutlineInputBorder()),
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
                            decoration: const InputDecoration(
                                labelText: 'State',
                                border: OutlineInputBorder()),
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
                            decoration: const InputDecoration(
                                labelText: 'City',
                                border: OutlineInputBorder()),
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
                            decoration: const InputDecoration(
                                labelText: 'Pin Code',
                                border: OutlineInputBorder()),
                            onChanged: cubit.updatePinCode,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.designation,
                      decoration: const InputDecoration(
                          labelText: 'Designation',
                          border: OutlineInputBorder()),
                      onChanged: cubit.updateDesignation,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.department,
                      decoration: const InputDecoration(
                          labelText: 'Department',
                          border: OutlineInputBorder()),
                      onChanged: cubit.updateDepartment,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: state.totalAssignedLeave,
                      decoration: const InputDecoration(
                          labelText: 'Total Assigned Leave',
                          border: OutlineInputBorder()),
                      onChanged: cubit.updateTotalAssignedLeave,
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
                      decoration: InputDecoration(
                        labelText: 'Upload File',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon:
                              const Icon(Icons.upload_file, color: Colors.teal),
                          onPressed: () async {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          cubit.updatePageIndex(2);
                          // Handle submit or next
                        },
                        child: const Text('NEXT'),
                      ),
                    ),
                  ]else if (state.pageIndex == 2) ...[
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
                      decoration: const InputDecoration(labelText: 'Select Team', border: OutlineInputBorder()),
                      value: state.selectedTeam,
                      items: ['Team A', 'Team B'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                      onChanged: cubit.updateSelectedTeam,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                          labelText: 'Role',
                          border: OutlineInputBorder()),
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
                    // DropdownButtonFormField<String>(
                    //   decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
                    //   value: state.role,
                    //   items: ['Developer', 'Manager'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                    //   onChanged: cubit.updateRole,
                    // ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Select Work Region', border: OutlineInputBorder()),
                      value: state.workRegion,
                      items: ['Region 1', 'Region 2'].map((w) => DropdownMenuItem(value: w, child: Text(w))).toList(),
                      onChanged: cubit.updateWorkRegion,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Select Shift', border: OutlineInputBorder()),
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

                          // Call API immediately after picking image
                          final repo = UserRepository();
                          try {
                            final response = await repo.uploadImage(imagePath);
                            print('Uploaded image URL: ${response.data.first.id}');
                            cubit.updateImageId(response.data.first.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Image uploaded: ${response.data.first.path}')),
                            );
                            // Optionally, update state with the uploaded URL if needed
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
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.upload_file, color: Colors.teal),
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(type: FileType.image);
                            if (result != null && result.files.isNotEmpty) {
                              final imagePath = result.files.single.path!;
                              cubit.updateUploadImagePath(imagePath);

                              // Call API immediately after picking image
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
                                cubit.updateUploadImagePath(null);} ,
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
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () async {
                            final cubit = context.read<CreateTeamCubit>();
                            final state = cubit.state;

                            final userData = {
                              "username": state.username,
                              "password": state.password,
                              "roleId": state.roleId, // set this from your state or dropdown
                              "first_name": state.firstName,
                              "last_name": state.lastName,
                              "email": state.email,
                              "mobile": state.contactNumber,
                              "address": state.address,
                              "pincode": state.pinCode,
                              "country": state.countryId,
                              "stateId": state.stateId,
                              "cityId": state.cityId,
                              "departmentId": null, // set this if available
                              "designationId": null, // set this if available
                              "joining_date": state.joiningDate?.toIso8601String(),
                              "gender": state.gender,
                              "total_leave": int.tryParse(state.totalAssignedLeave ?? '0'),
                              "image": state.imageId, // or uploaded image URL if available
                              "dob": state.dob?.toIso8601String(),
                              "screen_monitoring": false,
                              "employee_id": state.employeeId,
                            };

                            try {
                              await UserRepository().createUser(userData);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('User created successfully')),
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserList()));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to create user: $e')),
                              );
                            }

                          // Handle submit
                        },
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
