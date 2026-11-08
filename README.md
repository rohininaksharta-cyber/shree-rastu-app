# SHREE RASTU VASTU & JYOTISHYA — Android starter

This is the first Flutter source-code prototype for the Android app.

## Included
- Premium navy and gold theme
- Kannada / English language toggle
- Home screen with six service tiles
- Navigation bar and drawer
- Service request demo forms
- Your generated logo asset

## Not connected yet
- OTP authentication
- Database / admin dashboard
- Appointment scheduling
- Payment gateway
- Automated horoscope calculations
- PDF generation and delivery
- Push notifications

These require backend configuration, business rules, credentials, and testing.

## Run locally
1. Install Flutter SDK and Android Studio.
2. Extract this project.
3. From this folder run:
   - `flutter pub get`
   - `flutter run`
4. To build an APK after testing:
   - `flutter build apk --release`

## Important
The request form currently demonstrates the UI only. It does not send or store customer information.

## Contact displayed in app
- Contact number: 9008968519

## Kundali request workflow prototype
- Customer form fields: name, mobile, date of birth, birth time, birth place, gender, report language, notes.
- Form validates required fields and Indian mobile number format.
- The form currently validates and displays a local demo confirmation only.
- No customer data is transmitted or stored yet.
- Payment integration and secure backend submission are pending fee and merchant-account setup.
- Centre prepares the report manually and sends it to the customer after implementation of secure delivery.

## Kundali PDF service fee
- Displayed service fee: INR 299 per Kundali PDF request.
- This is a displayed price only; live checkout / payment confirmation is not yet integrated.

## Responsive Admin Dashboard prototype
- Open from the app navigation drawer: Admin Dashboard.
- Responsive layout for phone-sized and wide browser windows.
- Demo order cards, status filters, and local status changes.
- Uses sample records only; no live customer records are connected.
- For production web + Android admin access, configure Firebase Authentication with owner-only access, Firestore, secure Storage rules, payment webhooks, and HTTPS hosting.
- The same Flutter codebase can target Android and Web (`flutter build apk --release` and `flutter build web`).

## Owner Admin Login prototype
- Owner email prefilled: rohininaksharta@gmail.com
- Password field is intentionally blank; create/set the password privately in Firebase Authentication.
- Drawer > Admin Dashboard opens the Admin Login screen.
- Login and password reset are UI placeholders until Firebase project credentials, Authentication, and owner-only security rules are configured.
- Never hardcode an admin password in the app source code.


## Firebase owner Admin login integration (Android)
- Firebase project configured from the supplied Android app configuration:
  - Project ID: `shree-rastu-vastu-jyotishya`
  - Android package: `com.shreerastu.vastu.jyotishya`
  - Owner email allowed by the app UI: `rohininaksharta@gmail.com`
- Firebase Core initialization and Firebase Email/Password sign-in have been added.
- The Admin Dashboard opens only after Firebase sign-in succeeds; logout signs the owner out.
- Password reset uses Firebase's email reset flow.
- `android/app/google-services.json` and `lib/firebase_options.dart` are included.

### Required Firebase Console steps (must be done by the project owner)
1. Open Firebase Console > Authentication > Sign-in method (or Sign-in providers).
2. Enable **Email/Password** and save.
3. Open Authentication > Users > Add user.
4. Create the owner account with `rohininaksharta@gmail.com` and set a private password.
5. Do not share the password in chat. Use the password reset flow if needed.

### Important limitations
- This ZIP is the source prototype supplied for this task; it does not contain the full Android Gradle/platform scaffold. Open it in a Flutter project with Android platform files (or run `flutter create .` from the project root with Flutter installed) before building.
- The email check in the app is a UI gate only. Before storing customer data, enforce owner access with Firestore/Storage security rules or trusted backend authorization. Do not treat a client-side email check as database security.
- Customer forms and sample dashboard orders are still demo-only; Firestore order storage, payment processing, PDF storage/delivery, and notifications are not implemented.
