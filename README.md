# Women Safety App

## 🛡️ Overview
A comprehensive Flutter-based mobile application designed to ensure the safety, security, and peace of mind of women. The app provides immediate access to emergency services, reliable SOS messaging, and critical location sharing to protect users in vulnerable situations.

## ✨ Features
- **SOS Alert System:** A one-tap emergency trigger that sends SMS alerts containing your real-time location to trusted contacts.
- **Direct Emergency Calling:** Quick, hassle-free access to call local police stations or emergency hotlines.
- **Trusted Contacts Management:** Easily add, edit, and manage a list of emergency contacts who will be notified instantly when in danger.
- **Real-Time Location:** Integrates the `geolocator` package to fetch and share accurate GPS coordinates.
- **Push Notifications:** Built-in notification service structure to alert contacts effectively.

---

## 📊 Market Analysis
### Problem Statement
Violence against women and personal safety concerns in public spaces remain a critical global issue. Women often feel vulnerable traveling alone, especially at night or in unfamiliar areas. Traditional methods of seeking help (like dialing numbers manually) are often too slow during high-stress situations.

### Target Audience
- Women of all ages, including working professionals and college students.
- Parents who want to ensure the safety of their daughters.
- Anyone seeking an extra layer of personal security while commuting or traveling independently.

### Market Demand
The personal safety app market is experiencing rapid growth. With increasing smartphone penetration globally, a reliable, fast, and accessible SOS application has transitioned from a luxury to an absolute necessity. Users are actively seeking apps that respect their privacy while providing robust emergency tools.

### Competitive Advantage
- **Speed & Simplicity:** A non-intrusive, easy-to-navigate UI that requires minimal interaction to trigger an alarm.
- **Offline Capabilities:** Uses direct SMS via the `telephony` package, ensuring alerts are sent even if internet connectivity is poor or unavailable.
- **Direct Action:** Seamless integration with system phone dialers and SMS managers.

---

## 💡 How It Helps (Value Proposition)
- **Instant Response:** Drastically reduces the time taken to alert authorities and loved ones during a panic scenario.
- **Deterrence & Protection:** The presence of a quick-access SOS tool can deter potential threats and escalate a situation to authorities immediately.
- **Empowerment:** Empowers women to travel, work, and live independently with the peace of mind that help is just one tap away.
- **Accessibility under Stress:** The straightforward interface guarantees that users can trigger alerts effortlessly, even when panicking.

---

## 🚀 Future Scope
To make the application even more robust, the following features are planned for future releases:
1. **Fake Call Simulation:** A feature allowing users to trigger a simulated incoming phone call to help them gracefully escape uncomfortable or potentially dangerous situations.
2. **Continuous Live Tracking:** Transitioning from static coordinates to live, continuous location sharing with trusted contacts during an active SOS state.
3. **Auto Audio/Video Recording:** Automatically start recording surrounding audio and video when the SOS is triggered, uploading it securely to the cloud as evidence.
4. **Community Alerts (Crowdsourcing Help):** Notify nearby app users when an SOS is triggered so community members can offer immediate assistance before authorities arrive.
5. **AI-based Threat Detection:** Implement voice recognition to trigger the SOS automatically based on distress keywords or screams.
6. **Wearable Integration:** Allow users to trigger the SOS directly from a smartwatch, fitness band, or hidden Bluetooth button without needing to take out their phone.

---

## 🛠️ Tech Stack
- **Frontend:** Flutter & Dart
- **State Management:** Provider
- **Local Storage:** Shared Preferences
- **Key Plugins:** Geolocator, Telephony, Permission Handler, URL Launcher, Flutter Phone Direct Caller
- **Backend/Services:** Firebase (Authentication, Database), Custom Notification Service

---

## 🏁 Getting Started

### Prerequisites
- Flutter SDK (`>=3.0.0 <4.0.0`)
- Android Studio or VS Code
- A physical Android/iOS device (Recommended for testing SMS and Phone Call features as emulators may lack telephony support).

### Installation
1. **Clone the repository:**
   ```bash
   git clone <your-repository-url>
   ```
2. **Navigate to the project directory:**
   ```bash
   cd women_safety_app
   ```
3. **Install dependencies:**
   ```bash
   flutter pub get
   ```
4. **Run the application:**
   ```bash
   flutter run
   ```

## 📝 License
This project is licensed under the MIT License.
