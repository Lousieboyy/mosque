# Mosque Support App (Flutter)

A blue/purple themed mobile app concept for mosque operations.

## Implemented features
- Home page with prayer times and reminder notifications
- Report page with simulated voice-to-text submission
- Announcement page
- Profile page
- Sadaqa page
- Security demo: SHA-256 password hashing + OTP-based 2-step verification
- Notification service hooks for prayer/report/announcement workflows
- Manual reload per current page
- Architecture designed to scale through API-first services for 100+ concurrent users

## Demo login
- Email: `admin@mosque.app`
- Password: `SecurePass123`
- Request OTP first, then login using the shown demo OTP.

## Run
```bash
flutter pub get
flutter run
```
