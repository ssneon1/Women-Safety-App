# Security & Privacy

Security is a primary goal. The application is built with a privacy-first mindset to ensure user data is never compromised.

## 🔐 Key Security Features
- **Secure Authentication:** Robust login using Firebase Authentication.
- **Encrypted Data:** User details and contact information are encrypted in transit and at rest.
- **Permission-Based Access:** The app explicitly requests permissions (Location, SMS, Phone) and only uses them when absolutely necessary (e.g., during an SOS).
- **No Background Tracking:** Location is NOT tracked in the background during normal operation. It is only fetched when the user explicitly triggers the SOS.
- **Protected User Information:** Strict data access rules in Firebase prevent unauthorized read/write operations.
