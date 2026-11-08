import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ShreeRastuApp());
}

const navy = Color(0xFF07152F);
const navy2 = Color(0xFF10264A);
const gold = Color(0xFFE7B94F);
const cream = Color(0xFFFFF4D7);

class ShreeRastuApp extends StatelessWidget {
  const ShreeRastuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHREE RASTU VASTU & JYOTISHYA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: gold, brightness: Brightness.dark),
        scaffoldBackgroundColor: navy,
        useMaterial3: true,
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int tab = 0;
  bool kannada = true;

  String t(String kn, String en) => kannada ? kn : en;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _home(),
      SimplePage(title: t('ಸೇವೆಗಳು', 'Services'), subtitle: t('ವಾಸ್ತು ಮತ್ತು ಜ್ಯೋತಿಷ್ಯ ಸೇವೆಗಳು', 'Vastu and astrology services')),
      SimplePage(title: t('ಲೇಖನಗಳು', 'Articles'), subtitle: t('ವಾಸ್ತು ಸಲಹೆಗಳು ಮತ್ತು ಜ್ಯೋತಿಷ್ಯ ಮಾಹಿತಿ', 'Vastu tips and astrology information')),
      SimplePage(title: t('ಅಧಿಸೂಚನೆಗಳು', 'Notifications'), subtitle: t('ಹೊಸ ಅಪಾಯಿಂಟ್‌ಮೆಂಟ್ ಮತ್ತು ವರದಿ ಅಪ್‌ಡೇಟ್‌ಗಳು', 'Booking and report updates')),
      SimplePage(title: t('ಸೆಟ್ಟಿಂಗ್‌ಗಳು', 'Settings'), subtitle: t('ಭಾಷೆ ಮತ್ತು ಖಾತೆ ಆಯ್ಕೆಗಳು', 'Language and account options')),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: gold,
        title: const Text('SHREE RASTU', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        actions: [
          TextButton(
            onPressed: () => setState(() => kannada = !kannada),
            child: Text(kannada ? 'ಕನ್ನಡ' : 'English', style: const TextStyle(color: gold)),
          ),
          IconButton(
            onPressed: () => _message(t('ಅಧಿಸೂಚನೆಗಳು ಶೀಘ್ರದಲ್ಲೇ ಲಭ್ಯ.', 'Notifications will be available soon.')),
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: navy2,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: navy),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image.asset('assets/shree_rastu_logo.png', height: 76, errorBuilder: (_, __, ___) => const Icon(Icons.temple_hindu, size: 54, color: gold)),
                const SizedBox(height: 8),
                const Text('SHREE RASTU VASTU & JYOTISHYA', style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
              ]),
            ),
            for (final item in [
              (Icons.home, t('ಮುಖಪುಟ', 'Home'), 0),
              (Icons.grid_view, t('ಸೇವೆಗಳು', 'Services'), 1),
              (Icons.article, t('ಲೇಖನಗಳು', 'Articles'), 2),
              (Icons.notifications, t('ಅಧಿಸೂಚನೆಗಳು', 'Notifications'), 3),
              (Icons.settings, t('ಸೆಟ್ಟಿಂಗ್‌ಗಳು', 'Settings'), 4),
            ])
              ListTile(
                leading: Icon(item.$1, color: gold),
                title: Text(item.$2, style: const TextStyle(color: Colors.white)),
                onTap: () { setState(() => tab = item.$3); Navigator.pop(context); },
              ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings, color: gold),
              title: const Text('Admin Dashboard', style: TextStyle(color: Colors.white)),
              subtitle: const Text('Centre owner access', style: TextStyle(color: Colors.white60)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLoginPage()));
              },
            ),
          ],
        ),
      ),
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        backgroundColor: navy2,
        indicatorColor: gold.withOpacity(.2),
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home_outlined), label: t('ಮುಖಪುಟ', 'Home')),
          NavigationDestination(icon: const Icon(Icons.grid_view), label: t('ಸೇವೆಗಳು', 'Services')),
          NavigationDestination(icon: const Icon(Icons.article_outlined), label: t('ಲೇಖನಗಳು', 'Articles')),
          NavigationDestination(icon: const Icon(Icons.notifications_none), label: t('ಅಪ್‌ಡೇಟ್', 'Updates')),
          NavigationDestination(icon: const Icon(Icons.settings_outlined), label: t('ಸೆಟ್ಟಿಂಗ್', 'Settings')),
        ],
      ),
    );
  }

  Widget _home() {
    final services = [
      (Icons.auto_awesome, t('ಜ್ಯೋತಿಷ್ಯ', 'Astrology'), t('ಜಾತಕ ಮತ್ತು ಗ್ರಹಫಲ', 'Horoscope and planetary readings')),
      (Icons.home_work, t('ವಾಸ್ತು', 'Vastu'), t('ಮನೆ ಮತ್ತು ಸೈಟ್ ಪರಿಶೀಲನೆ', 'Home and site consultation')),
      (Icons.picture_as_pdf, t('ಜಾತಕ PDF', 'Kundali PDF'), t('ವೈಯಕ್ತಿಕ ವರದಿ ವಿನಂತಿ', 'Request a personal report')),
      (Icons.calendar_month, t('ಅಪಾಯಿಂಟ್‌ಮೆಂಟ್', 'Appointment'), t('ಸಮಯ ಕಾಯ್ದಿರಿಸಿ', 'Book a consultation')),
      (Icons.lightbulb_outline, t('ಪರಿಹಾರಗಳು', 'Remedies'), t('ಪರಿಹಾರಗಳ ಮಾಹಿತಿ', 'Remedy information')),
      (Icons.account_circle, t('ನನ್ನ ಖಾತೆ', 'My Account'), t('ನಿಮ್ಮ ವಿವರಗಳು', 'Your profile')),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(colors: [navy2, Color(0xFF1B3157)]),
            border: Border.all(color: gold, width: 1.2),
          ),
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset('assets/shree_rastu_logo.png', height: 150, fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(Icons.temple_hindu, color: gold, size: 90)),
            ),
            const SizedBox(height: 10),
            const Text('ಶ್ರೀರಸ್ತು ವಾಸ್ತು & ಜ್ಯೋತಿಷ್ಯ ಕೇಂದ್ರ',
              textAlign: TextAlign.center,
              style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('SHREE RASTU VASTU & JYOTISHYA',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: .6)),
            const SizedBox(height: 8),
            Text(t('ನಿಮ್ಮ ಜೀವನಕ್ಕೆ ವಾಸ್ತು ಮತ್ತು ಜ್ಯೋತಿಷ್ಯದ ಮಾರ್ಗದರ್ಶನ', 'Guidance through Vastu & Astrology'),
              textAlign: TextAlign.center, style: const TextStyle(color: cream)),
          ]),
        ),
        const SizedBox(height: 20),
        Text(t('ನಮ್ಮ ಸೇವೆಗಳು', 'Our Services'),
          style: const TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.18),
          itemBuilder: (context, i) => InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => _openService(services[i].$2, services[i].$3),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cream,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: gold, width: 1.5),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(.22), blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(services[i].$1, color: navy, size: 34),
                const SizedBox(height: 8),
                Text(services[i].$2, textAlign: TextAlign.center,
                  style: const TextStyle(color: navy, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(services[i].$3, textAlign: TextAlign.center,
                  style: const TextStyle(color: navy2, fontSize: 11)),
              ]),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: navy2, borderRadius: BorderRadius.circular(16), border: Border.all(color: gold)),
          child: Row(children: [
            const Icon(Icons.phone_in_talk, color: gold, size: 30),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Contact Us / ಸಂಪರ್ಕಿಸಿ', style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('9008968519', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            ])),
          ]),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: navy2, borderRadius: BorderRadius.circular(16), border: Border.all(color: gold)),
          child: Row(children: [
            const Icon(Icons.stars, color: gold, size: 30),
            const SizedBox(width: 12),
            Expanded(child: Text(t('ಶುಭವಾಗಲಿ • ಸಮೃದ್ಧಿ ಮತ್ತು ಸಕಾರಾತ್ಮಕ ಶಕ್ತಿ', 'Good Luck • Prosperity & Positive Energy'),
              style: const TextStyle(color: cream, fontWeight: FontWeight.w600))),
          ]),
        ),
      ],
    );
  }

  void _openService(String title, String description) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ServiceRequestPage(title: title, description: description)));
  }

  void _message(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

class SimplePage extends StatelessWidget {
  final String title;
  final String subtitle;
  const SimplePage({super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.auto_awesome, color: gold, size: 54),
        const SizedBox(height: 14),
        Text(title, style: const TextStyle(color: gold, fontSize: 23, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: cream)),
        const SizedBox(height: 12),
        const Text('ಈ ವಿಭಾಗ ಮುಂದಿನ development ಹಂತದಲ್ಲಿ ಸಕ್ರಿಯವಾಗುತ್ತದೆ.',
          textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ]),
    ),
  );
}

class ServiceRequestPage extends StatefulWidget {
  final String title;
  final String description;
  const ServiceRequestPage({super.key, required this.title, required this.description});

  @override
  State<ServiceRequestPage> createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _dob = TextEditingController();
  final _birthTime = TextEditingController();
  final _birthPlace = TextEditingController();
  final _notes = TextEditingController();
  String _language = 'Kannada';
  String _gender = 'Not specified';

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    _dob.dispose();
    _birthTime.dispose();
    _birthPlace.dispose();
    _notes.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label, {String? hint}) => InputDecoration(
    labelText: label,
    hintText: hint,
    border: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: gold.withOpacity(.65)),
      borderRadius: BorderRadius.circular(12),
    ),
  );

  Widget _field(TextEditingController controller, String label, {
    String? hint, TextInputType keyboard = TextInputType.text, int maxLines = 1,
    String? Function(String?)? validator,
  }) => TextFormField(
    controller: controller,
    keyboardType: keyboard,
    maxLines: maxLines,
    validator: validator,
    decoration: _decoration(label, hint: hint),
  );

  @override
  Widget build(BuildContext context) {
    final isKundali = widget.title.toLowerCase().contains('kundali') ||
        widget.title.toLowerCase().contains('ಜಾತಕ');

    return Scaffold(
      appBar: AppBar(title: Text(widget.title), backgroundColor: navy, foregroundColor: gold),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(widget.title, style: const TextStyle(color: gold, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.description, style: const TextStyle(color: cream, fontSize: 16)),
            const SizedBox(height: 20),
            Text(isKundali ? 'Kundali Details / ಜಾತಕದ ವಿವರಗಳು' : 'Request Details / ವಿನಂತಿಯ ವಿವರಗಳು',
              style: const TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 14),
            _field(_name, 'Full Name / ಪೂರ್ಣ ಹೆಸರು',
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null),
            const SizedBox(height: 12),
            _field(_mobile, 'Mobile Number / ಮೊಬೈಲ್ ಸಂಖ್ಯೆ',
              keyboard: TextInputType.phone,
              validator: (v) => (v == null || !RegExp(r'^[6-9][0-9]{9}$').hasMatch(v.trim()))
                  ? 'Enter a valid 10-digit Indian mobile number' : null),
            if (isKundali) ...[
              const SizedBox(height: 12),
              _field(_dob, 'Date of Birth / ಜನ್ಮ ದಿನಾಂಕ', hint: 'DD-MM-YYYY',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter date of birth' : null),
              const SizedBox(height: 12),
              _field(_birthTime, 'Time of Birth / ಜನನ ಸಮಯ', hint: 'e.g. 07:20 AM',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter birth time' : null),
              const SizedBox(height: 12),
              _field(_birthPlace, 'Place of Birth / ಜನನ ಸ್ಥಳ',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter birth place' : null),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: _decoration('Gender / ಲಿಂಗ'),
                dropdownColor: navy2,
                items: const [
                  DropdownMenuItem(value: 'Not specified', child: Text('Prefer not to say / ತಿಳಿಸಲು ಇಷ್ಟವಿಲ್ಲ')),
                  DropdownMenuItem(value: 'Male', child: Text('Male / ಪುರುಷ')),
                  DropdownMenuItem(value: 'Female', child: Text('Female / ಮಹಿಳೆ')),
                  DropdownMenuItem(value: 'Other', child: Text('Other / ಇತರೆ')),
                ],
                onChanged: (v) => setState(() => _gender = v ?? 'Not specified'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _language,
                decoration: _decoration('Report Language / ವರದಿ ಭಾಷೆ'),
                dropdownColor: navy2,
                items: const [
                  DropdownMenuItem(value: 'Kannada', child: Text('Kannada / ಕನ್ನಡ')),
                  DropdownMenuItem(value: 'English', child: Text('English')),
                ],
                onChanged: (v) => setState(() => _language = v ?? 'Kannada'),
              ),
            ],
            const SizedBox(height: 12),
            _field(_notes, 'Additional Details / ಹೆಚ್ಚುವರಿ ಮಾಹಿತಿ',
              maxLines: 3, hint: 'Write any specific questions or requirements'),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: navy2, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: gold.withOpacity(.8)),
              ),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Kundali PDF Service Fee / ಜಾತಕ PDF ಸೇವಾ ಶುಲ್ಕ', style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('₹299', style: TextStyle(color: cream, fontSize: 26, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('How it works / ಸೇವೆಯ ವಿಧಾನ', style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('1. Customer submits birth details.\n2. Payment is completed after the service fee is confirmed.\n3. The centre prepares the Kundali PDF manually.\n4. The PDF is sent to the customer.',
                  style: TextStyle(color: cream, height: 1.5)),
              ]),
            ),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: navy, padding: const EdgeInsets.symmetric(vertical: 14)),
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    backgroundColor: navy2,
                    title: const Text('Details captured in demo', style: TextStyle(color: gold)),
                    content: Text(
                      'Name: ${_name.text}\nMobile: ${_mobile.text}\n'
                      '${isKundali ? 'DOB: ${_dob.text}\nBirth time: ${_birthTime.text}\nBirth place: ${_birthPlace.text}\nReport: $_language\n' : ''}'
                      '\nThis prototype does not yet transmit or save requests. Backend and payment integration are the next steps.',
                      style: const TextStyle(color: cream),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('OK')),
                    ],
                  ),
                );
              },
              child: Text(isKundali ? 'Submit Birth Details / ಜಾತಕ ವಿವರ ಸಲ್ಲಿಸಿ' : 'Submit Request / ವಿನಂತಿ ಸಲ್ಲಿಸಿ',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            const Text('Prototype stage: customer details are validated on this screen only. Secure submission, payment confirmation and PDF delivery are not connected yet.',
              style: TextStyle(color: Colors.white60, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}


class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  String filter = 'All';
  final List<Map<String, String>> demoOrders = [
    {'id': 'SR-1001', 'name': 'Demo Customer A', 'service': 'Kundali PDF', 'date': '08 Nov 2026', 'payment': 'Pending', 'status': 'New'},
    {'id': 'SR-1002', 'name': 'Demo Customer B', 'service': 'Kundali PDF', 'date': '08 Nov 2026', 'payment': 'Paid', 'status': 'In Progress'},
    {'id': 'SR-1003', 'name': 'Demo Customer C', 'service': 'Vastu Consultation', 'date': '07 Nov 2026', 'payment': 'Paid', 'status': 'Completed'},
  ];

  @override
  Widget build(BuildContext context) {
    final orders = demoOrders.where((o) => filter == 'All' || o['status'] == filter).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: navy,
        foregroundColor: gold,
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth >= 720;
        return SingleChildScrollView(
          padding: EdgeInsets.all(wide ? 28 : 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('SHREE RASTU VASTU & JYOTISHYA',
                    style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 4),
                  const Text('Owner control panel / ನಿರ್ವಹಣಾ ಫಲಕ',
                    style: TextStyle(color: cream)),
                  const SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: wide ? 4 : 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: wide ? 1.7 : 1.45,
                    children: const [
                      _AdminMetric(icon: Icons.people_alt, label: 'Customers', value: '—', note: 'Live data not connected'),
                      _AdminMetric(icon: Icons.receipt_long, label: 'New Orders', value: '1', note: 'Demo only'),
                      _AdminMetric(icon: Icons.payments, label: 'Paid Orders', value: '2', note: 'Demo only'),
                      _AdminMetric(icon: Icons.picture_as_pdf, label: 'PDF Pending', value: '1', note: 'Demo only'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Expanded(child: Text('Order Management / ಆರ್ಡರ್ ನಿರ್ವಹಣೆ',
                        style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold))),
                      DropdownButton<String>(
                        value: filter,
                        dropdownColor: navy2,
                        style: const TextStyle(color: cream),
                        underline: Container(height: 1, color: gold),
                        items: const [
                          DropdownMenuItem(value: 'All', child: Text('All')),
                          DropdownMenuItem(value: 'New', child: Text('New')),
                          DropdownMenuItem(value: 'In Progress', child: Text('In Progress')),
                          DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                        ],
                        onChanged: (v) => setState(() => filter = v ?? 'All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...orders.map((o) => Card(
                    color: navy2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: gold.withOpacity(.55)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Expanded(child: Text('${o['id']} • ${o['name']}',
                            style: const TextStyle(color: gold, fontWeight: FontWeight.bold))),
                          Text(o['payment']!, style: TextStyle(
                            color: o['payment'] == 'Paid' ? Colors.lightGreenAccent : Colors.orangeAccent,
                            fontWeight: FontWeight.bold)),
                        ]),
                        const SizedBox(height: 8),
                        Text('${o['service']}  |  ${o['date']}',
                          style: const TextStyle(color: cream)),
                        const SizedBox(height: 8),
                        Row(children: [
                          const Text('Status: ', style: TextStyle(color: Colors.white70)),
                          Expanded(child: Text(o['status']!, style: const TextStyle(color: cream))),
                          if (o['status'] != 'Completed')
                            TextButton(
                              onPressed: () => setState(() {
                                final index = demoOrders.indexWhere((x) => x['id'] == o['id']);
                                demoOrders[index]['status'] =
                                  o['status'] == 'New' ? 'In Progress' : 'Completed';
                              }),
                              child: Text(o['status'] == 'New' ? 'Start' : 'Complete',
                                style: const TextStyle(color: gold)),
                            ),
                        ]),
                        if (o['status'] == 'Completed')
                          const Text('PDF delivery action will be enabled after secure file storage is connected.',
                            style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ]),
                    ),
                  )),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: navy2, borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: gold.withOpacity(.6)),
                    ),
                    child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Important setup still required',
                        style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(
                        'This is a clickable dashboard prototype with sample orders only. '
                        'Customer login, live order database, payment verification, PDF upload/delivery '
                        'and owner-only security must be connected before real customer use.',
                        style: TextStyle(color: cream, height: 1.45)),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _AdminMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String note;
  const _AdminMetric({required this.icon, required this.label, required this.value, required this.note});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cream, borderRadius: BorderRadius.circular(16),
      border: Border.all(color: gold, width: 1.2),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: navy, size: 25),
      const SizedBox(height: 6),
      Text(value, style: const TextStyle(color: navy, fontSize: 22, fontWeight: FontWeight.bold)),
      Text(label, style: const TextStyle(color: navy, fontWeight: FontWeight.bold)),
      Text(note, style: const TextStyle(color: navy2, fontSize: 9)),
    ]),
  );
}


class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _email = TextEditingController(text: 'rohininaksharta@gmail.com');
  final _password = TextEditingController();
  bool _obscure = true;
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _showSetupMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Login'), backgroundColor: navy, foregroundColor: gold),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: navy2, borderRadius: BorderRadius.circular(22),
                border: Border.all(color: gold, width: 1.2),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Icon(Icons.admin_panel_settings, color: gold, size: 58),
                const SizedBox(height: 12),
                const Text('SHREE RASTU', textAlign: TextAlign.center,
                  style: TextStyle(color: gold, fontSize: 23, fontWeight: FontWeight.bold)),
                const Text('Owner Admin Login', textAlign: TextAlign.center,
                  style: TextStyle(color: cream)),
                const SizedBox(height: 24),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Admin Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _password,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: navy, padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: _busy ? null : () async {
                    final email = _email.text.trim().toLowerCase();
                    if (email != 'rohininaksharta@gmail.com') {
                      _showSetupMessage('Only the registered owner email can access Admin.');
                      return;
                    }
                    if (_password.text.isEmpty) {
                      _showSetupMessage('Please enter your password.');
                      return;
                    }
                    setState(() => _busy = true);
                    try {
                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: _password.text,
                      );
                      if (!mounted) return;
                      if (credential.user?.email?.toLowerCase() != 'rohininaksharta@gmail.com') {
                        await FirebaseAuth.instance.signOut();
                        _showSetupMessage('This account is not authorized as Admin.');
                        return;
                      }
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminDashboardPage()));
                    } on FirebaseAuthException catch (e) {
                      _showSetupMessage(e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential'
                          ? 'Email or password is incorrect.'
                          : 'Login failed: ${e.message ?? e.code}');
                    } catch (e) {
                      _showSetupMessage('Login failed. Please check your internet connection and Firebase setup.');
                    } finally {
                      if (mounted) setState(() => _busy = false);
                    }
                  },
                  child: const Text('Login / ಪ್ರವೇಶಿಸಿ', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () async {
                    final email = _email.text.trim().toLowerCase();
                    if (email != 'rohininaksharta@gmail.com') {
                      _showSetupMessage('Enter the registered owner email address.');
                      return;
                    }
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                      _showSetupMessage('Password reset email sent. Check your inbox.');
                    } on FirebaseAuthException catch (e) {
                      _showSetupMessage('Could not send reset email: ${e.message ?? e.code}');
                    }
                  },
                  child: const Text('Forgot Password?', style: TextStyle(color: gold)),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Security note: this is a login-screen prototype. It does not authenticate users yet. '
                  'Real owner-only access must be enforced by Firebase Authentication and backend/database security rules.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white60, fontSize: 11, height: 1.4),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
