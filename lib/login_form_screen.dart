import 'package:flutter/material.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  String _savedEmail = '';
  String _savedPassword = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // โครงสร้าง UI จะอยู่ที่นี่
    return Scaffold(
      appBar: AppBar(title: const Text('ฟอร์มล็อกอิน')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          // เพิ่มวิดเจ็ต Form
          key: _formKey, // กำหนด key
          child: Column(
            children: <Widget>[
              const Text(
                'กรุณาล็อกอินด้วยอีเมลและรหัสผ่านของคุณ',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // ฟิลด์ Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'อีเมล',
                  hintText: 'you@example.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(), // เพิ่มเส้นขอบ
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาป้อนอีเมลของคุณ';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    // เพิ่มการตรวจสอบ . ด้วย
                    return 'กรุณาป้อนที่อยู่อีเมลที่ถูกต้อง';
                  }
                  return null; // คืนค่า null หากถูกต้อง
                },
                onSaved: (value) {
                  if (value != null) {
                    _savedEmail = value;
                  }
                },
              ),

              const SizedBox(height: 15), // ตัวเว้นวรรค
              // ฟิลด์ Password
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'รหัสผ่าน',
                  hintText: 'ป้อนรหัสผ่านของคุณ',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(), // เพิ่มเส้นขอบ
                ),
                obscureText: true, // ซ่อนข้อความรหัสผ่าน
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาป้อนรหัสผ่านของคุณ';
                  }
                  if (value.length < 6) {
                    return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                  }
                  return null; // คืนค่า null หากถูกต้อง
                },
                onSaved: (value) {
                  if (value != null) {
                    _savedPassword = value;
                  }
                },
              ),

              const SizedBox(height: 30), // ตัวเว้นวรรคก่อนปุ่ม
              ElevatedButton(
                onPressed: () {
                  // validate() คืนค่า true หากฟอร์มถูกต้อง, หรือ false หากไม่ถูกต้อง
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // หากฟอร์มถูกต้อง, แสดง Snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('ฟอร์มถูกต้อง! กำลังประมวลผลข้อมูล...'),
                      ),
                    );
                    print('_savedEmail: $_savedEmail');
                    print('_savedPassword: $_savedPassword');
                  } else {
                    print('ฟอร์มไม่ถูกต้อง');
                  }
                },
                child: const Text('ล็อกอิน'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
