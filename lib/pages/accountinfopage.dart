import 'package:flutter/material.dart';
import '../utility/router.dart' as route;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({Key? key}) : super(key: key);

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  String? email;

  final _userInfo = Hive.box('userData');

  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _editingName = false;
  bool _editingMobile = false;
  bool _editingAddress = false;
  bool _editingPassword = false;

  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser?.email;
  }

  void _toggleEditing(String condition) {
    if (condition == 'Name') {
      setState(() {
        _editingName = !_editingName;
      });
    } else if (condition == 'Phone number') {
      setState(() {
        _editingMobile = !_editingMobile;
      });
    } else if (condition == 'Address') {
      setState(() {
        _editingAddress = !_editingAddress;
      });
    } else if (condition == 'Password') {
      setState(() {
        _editingPassword = !_editingPassword;
      });
      // Luodaan muokkaus mahdollisuus TextFormField kohtiin.
    }
  }

  void _saveName() {
    // voi tallentaa nimen Hiveen.
    _toggleEditing('Name');
    _userInfo.put('Name', _nameController.text);
  }

  void _saveAddress() {
    // voi tallentaa osoitteen Hiveen.
    _toggleEditing('Address');
    _userInfo.put('Address', _addressController.text);
  }

  void _savePassword() {
    // voi tallentaa salasanan Hiveen.
    _toggleEditing('Password');
    _userInfo.put('Password', _passwordController.text);
  }

  void _savePhoneNumber() {
    // voi tallentaa puhelinnumeron Hiveen.
    _toggleEditing('Phone number');
    _userInfo.put('Phone number', _mobileController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Info'),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey.shade800),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/pfp_placeholder.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_rounded),
              title: const Text('Home'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, route.homePage),
            ),
            ListTile(
                leading: const Icon(Icons.calendar_month_rounded),
                title: const Text('Calendar'),
                onTap: () =>
                    null //Navigator.pushNamed(context, route.calendarPage),
                ),
            ListTile(
                leading: const Icon(Icons.message_rounded),
                title: const Text('Messages'),
                onTap: () =>
                    null //Navigator.pushNamed(context, route.messagePage),
                ),
            ListTile(
              leading: const Icon(Icons.payment_rounded),
              title: const Text('Salary information'),
              onTap: () => Navigator.pushNamed(context, route.salaryInfo),
            ),
            ListTile(
                leading: const Icon(Icons.menu),
                title: const Text('Menu'),
                onTap: () => Navigator.pushNamed(context, route.menuPage)),
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              title: const Text('AdminHomePage'),
              onTap: () => Navigator.pushNamed(context, route.adminHomePage),
            ),
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              title: const Text('Settings'),
              onTap: () => Navigator.pushNamed(context, route.settingsPage),
            ),
          ],
        ),
        // "Drawer" valikon toiminnallisuus.
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/homepage_background.png'),
                fit: BoxFit.cover,
              ),
              // Taustakuvan toiminnallisuus.
            ),
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  children: const [
                    Icon(Icons.account_circle_rounded),
                    Text('Name:'),
                  ],
                ),
                // Komponenteilla on oletuksena hintText, johon on mahdollista täyttää omat tiedot.
                // Tiedot tallentuvat Hiveen, eli käyttäjän käydessä jollain muulla sivulla, annetut tiedot eivät nollaannu.
                // Jokaisella kentällä on muokkaus mahdollisuus, joka tallettaa aina uudelleen muokatun tiedon Hiveen.
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: _nameController,
                          enabled: _editingName,
                          decoration: InputDecoration(
                            hintText: _userInfo.get('Name'),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onSaved: (value) {
                            _nameController.text = value!;
                          }),
                    ),
                    IconButton(
                      onPressed: () => _toggleEditing('Name'),
                      icon: _editingName
                          ? const Icon(Icons.cancel)
                          : const Icon(Icons.edit),
                    ),
                    if (_editingName)
                      IconButton(
                        onPressed: _saveName,
                        icon: const Icon(Icons.save),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: const [
                    Icon(Icons.add_ic_call_rounded),
                    Text('Mobile:'),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _mobileController,
                        enabled: _editingMobile,
                        decoration: InputDecoration(
                          hintText: _userInfo.get('Phone number'),
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _toggleEditing('Phone number'),
                      icon: _editingMobile
                          ? const Icon(Icons.cancel)
                          : const Icon(Icons.edit),
                    ),
                    if (_editingMobile)
                      IconButton(
                        onPressed: _savePhoneNumber,
                        icon: const Icon(Icons.save),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: const [
                    Icon(Icons.attach_email_rounded),
                    Text(
                      'Email:',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      '$email', // Sähköposti haettu Firebasesta (ei ole annettu muokkaus mahdollisuutta).
                    ),
                  ],
                ),
                const Divider(
                  height: 40,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: const [
                    Icon(Icons.add_home_rounded),
                    Text('Address:'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _addressController,
                        enabled: _editingAddress,
                        decoration: InputDecoration(
                          hintText: _userInfo.get('Address'),
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _toggleEditing('Address'),
                      icon: _editingAddress
                          ? const Icon(Icons.cancel)
                          : const Icon(Icons.edit),
                    ),
                    if (_editingAddress)
                      IconButton(
                        onPressed: _saveAddress,
                        icon: const Icon(Icons.save),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: const [
                    Icon(Icons.add_moderator_rounded),
                    Text('Password:'),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        enabled: _editingPassword,
                        decoration: InputDecoration(
                          hintText: _userInfo.get('Password'),
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        obscureText: _isObscure,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _toggleEditing('Password'),
                      icon: _editingPassword
                          ? const Icon(Icons.cancel)
                          : const Icon(Icons.edit),
                    ),
                    if (_editingPassword)
                      IconButton(
                        onPressed: _savePassword,
                        icon: const Icon(Icons.save),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
