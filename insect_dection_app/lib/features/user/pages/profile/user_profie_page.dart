import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/user/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthUserInfo currentUser;
  @override
  void initState() {
    super.initState();
    currentUser = BlocProvider.of<AuthBloc>(context).state.user;

    BlocProvider.of<UserProfileBloc>(context).add(OnLoadUserProfileEvent(
      uid: currentUser.uid,
      username: currentUser.email!,
    ));
  }

  // edit field
  Future<void> editField({
    required String displayText,
    required String field,
    required String? value,
  }) async {
    String? newValue = value;
    UserProfileBloc bloc = BlocProvider.of<UserProfileBloc>(context);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[800],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter new $displayText',
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),

          // save button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    // Update Profile
    bloc.add(UpdateUserProfileEvent(felid: field, value: newValue));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (_, state) {
          if (state.status == UserProfileStatus.error) {
            showTopSnackBar(context, message: state.message);
          }
        },
        builder: (_, state) {
          if (state.status == UserProfileStatus.initial ||
              state.status != UserProfileStatus.loading) {
            return ListView(
              children: [
                // profile pic
                const Icon(Icons.person, size: 50),
                const SizedBox(height: 10),

                // user email
                Text(
                  state.username,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[800]),
                ),
                const SizedBox(height: 10),

                // user details
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    ' My Details',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// User first name
                TextBox(
                  key: const Key("userProfile_firstName_textBox"),
                  text: state.firstName,
                  sectionName: 'First name',
                  onPressed: () => editField(
                    displayText: 'first name',
                    field: "firstName",
                    value: state.firstName,
                  ),
                ),
                const SizedBox(height: 20),

                TextBox(
                  key: const Key("userProfile_lastName_textBox"),
                  text: state.lastName,
                  sectionName: 'Last name',
                  onPressed: () => editField(
                    displayText: 'Last name',
                    field: 'lastName',
                    value: state.lastName,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    'Contact Info',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                TextBox(
                  key: const Key("userProfile_streetInput_textBox"),
                  text: state.street,
                  sectionName: 'Street',
                  onPressed: () => editField(
                    displayText: 'street',
                    field: 'street',
                    value: state.street,
                  ),
                ),
                const SizedBox(height: 20),

                TextBox(
                  key: const Key("userProfile_cityInput_textBox"),
                  text: state.city,
                  sectionName: 'City',
                  onPressed: () => editField(
                    displayText: 'city',
                    field: 'ctiy',
                    value: state.city,
                  ),
                ),
                const SizedBox(height: 20),

                TextBox(
                  key: const Key("userProfile_countryInput_textBox"),
                  text: state.country,
                  sectionName: 'Country',
                  onPressed: () => editField(
                    displayText: 'Country',
                    field: 'country',
                    value: state.country,
                  ),
                ),
                const SizedBox(height: 20),

                TextBox(
                  key: const Key("userProfile_phoneInput_textBox"),
                  text: state.phoneNumber,
                  sectionName: 'Phone number',
                  onPressed: () => editField(
                      displayText: 'Phone number',
                      field: 'phoneNumber',
                      value: state.phoneNumber),
                ),
                const SizedBox(height: 20),
              ],
            );
          } else if (state.status == UserProfileStatus.error) {
            return Center(
              child: Text('Error${state.message}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
