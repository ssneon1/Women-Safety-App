import os

base_dir = r"e:\WOMEN\women"
docs_dir = os.path.join(base_dir, "docs")
os.makedirs(docs_dir, exist_ok=True)

# Move existing markdown files to docs/ except README.md
for file in os.listdir(base_dir):
    if file.endswith(".md") and file != "README.md":
        try:
            os.rename(os.path.join(base_dir, file), os.path.join(docs_dir, file))
        except FileExistsError:
            os.remove(os.path.join(docs_dir, file))
            os.rename(os.path.join(base_dir, file), os.path.join(docs_dir, file))

# Write fully correct .gitignore
gitignore_content = """# Miscellaneous
*.class
*.log
*.pyc
*.swp
.DS_Store
.atom/
.buildlog/
.history
.svn/
migrate_working_dir/

# IntelliJ related
*.iml
*.ipr
*.iws
.idea/

# The .vscode folder contains launch configuration and tasks you configure in
# VS Code which you may wish to be included in version control, so this line
# is commented out by default.
#.vscode/

# Flutter/Dart/Pub related
**/doc/api/
**/ios/Flutter/.last_build_id
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.pub-cache/
.pub/
/build/
/coverage/

# Symbolication related
app.*.symbols

# Obfuscation related
app.*.map.json

# Android Studio will place build artifacts here
/android/app/debug
/android/app/profile
/android/app/release

# Keystore files
*.jks
*.keystore

# Google Services
google-services.json
GoogleService-Info.plist

# macOS
.DS_Store
"""
with open(os.path.join(base_dir, ".gitignore"), "w", encoding="utf-8") as f:
    f.write(gitignore_content)

# Define content for all docs files
docs_content = {
    "MARKET_ANALYSIS.md": """# Market Analysis

## Overview
Women's safety has become one of the most critical priorities globally. Millions of women travel independently every day for education, work, and personal activities, often facing varying degrees of safety concerns.
Modern smartphones, equipped with GPS and reliable communication networks, make it possible to build intelligent safety systems that provide instant emergency assistance.

## Market Opportunity
- **Increasing Smartphone Adoption:** Higher penetration in emerging markets allows safety apps to reach vulnerable populations.
- **Growing Awareness:** Increased social awareness surrounding women's safety is driving demand for proactive personal security solutions.
- **Government & Institutional Safety Initiatives:** Partnerships with local authorities and educational institutions.
- **Smart City Projects:** Integration with upcoming smart city frameworks for better emergency response.

## Market Size
The global personal safety application market is expanding rapidly due to an increasing demand for reliable emergency response systems.
**Target Users:**
- Students and youth
- Working professionals (especially night shift workers)
- Solo travelers and tourists
- Parents monitoring their children's safety
- Senior citizens

## Competitors
- **bSafe:** Offers live streaming and fake calls.
- **Noonlight:** Connects directly to emergency dispatchers.
- **Life360:** Primarily focused on family location tracking.
- **Citizen App:** Crowd-sourced safety alerts.
- **Safetipin:** Focuses on safety audits of public spaces.

## Competitive Advantage
Our application focuses on speed, reliability, and privacy:
- **One-Tap SOS:** Immediate action without navigating complex menus.
- **Offline SMS:** Works even without internet connectivity using direct telephony.
- **Fast User Interface:** Designed to be accessible during high-stress situations.
- **Privacy First:** Location is only shared when the SOS is triggered, respecting user autonomy.
""",

    "BUSINESS_MODEL.md": """# Business Model

## Revenue Sources
1. **Premium Subscription (B2C):**
   - Advanced features like live tracking, cloud backup of recordings, and AI threat detection.
2. **Enterprise Safety Plans (B2B):**
   - Corporate packages for employers to provide safety apps to their female employees, especially those working late hours.
3. **University Partnerships (B2B2C):**
   - Campus-wide licenses for students, integrating with campus security.
4. **In-App Purchases:**
   - One-time purchases for specialized emergency hardware (e.g., Bluetooth SOS buttons).

## Free Features (Core Safety)
- Basic SOS trigger
- Emergency calling (Police, Ambulance)
- SMS alerts with static GPS sharing
- Management of up to 3 trusted contacts

## Premium Features (Paid Tier)
- **Live Continuous Tracking:** Real-time updates during an emergency.
- **Cloud Backup:** Automatic secure upload of audio/video recordings when SOS is triggered.
- **AI Detection:** Voice-activated SOS (e.g., recognizing distress keywords).
- **Unlimited Contacts:** Add unlimited emergency contacts.
- **Smartwatch Integration:** Trigger SOS directly from a wearable device.
""",

    "PROBLEM_STATEMENT.md": """# Problem Statement

Many women face constant and severe safety concerns in their daily lives, particularly while:
- Traveling alone, especially at night.
- Working late shifts or irregular hours.
- Living alone in new or unfamiliar cities.
- Using public transportation or ride-sharing services.

**The Core Issue:**
Traditional emergency methods (like dialing an emergency number and explaining the location) often take too much time, require the user to speak clearly, and are noticeable to attackers. In panic situations, finding contacts or dialing numbers manually is inefficient and dangerous.

**Our Mission:**
Our application reduces response time to virtually zero by allowing users to alert authorities and loved ones with a single, discreet tap.
""",

    "SOLUTION.md": """# Proposed Solution

The Women Safety App provides a comprehensive, immediate, and reliable response mechanism for users in distress.

## Key Offerings
- **One-Tap SOS:** Instantly notifies all trusted contacts with an urgent message and GPS location.
- **Live GPS Sharing:** accurately pinpoints the user's location using the device's native GPS capabilities.
- **Trusted Contacts Management:** Easily configure who gets notified in an emergency.
- **Direct Emergency Calling:** One tap to call local police or emergency hotlines without opening the dialer.
- **Offline SMS Alerts:** Utilizes standard SMS so that alerts are sent even if mobile data is unavailable.
- **Push Notifications:** Alerts configured contacts who also have the app installed.

The solution is specifically designed to work quickly, reliably, and with absolute minimal user interaction when it matters most.
""",

    "HOW_IT_WORKS.md": """# How It Works

## Step 1: Installation & Setup
The user installs the application from the App Store or Google Play.

## Step 2: Permissions
To function effectively, the user grants necessary permissions:
- **Location:** To fetch accurate GPS coordinates.
- **SMS:** To send offline alerts to contacts.
- **Phone:** To make direct calls to emergency services.
- **Notifications:** To receive alerts from others.

## Step 3: Configuration
The user adds their trusted contacts (family, friends, or colleagues) to the emergency list.

## Step 4: Emergency Trigger
During an emergency, the user opens the app and presses the prominent SOS button (or uses a widget/hardware shortcut).

## Step 5: Automated Response
The application immediately and concurrently:
- Fetches the current exact GPS location.
- Sends an emergency SMS with the location link to all trusted contacts.
- Dials the primary emergency service number (e.g., Police).
- Sends push notifications to contacts (if integrated).

## Step 6: Assistance
Trusted contacts receive the alert instantly, complete with:
- The user's exact location.
- The time of the incident.
- A call to action to assist or contact authorities.
""",

    "FEATURES.md": """# Core Features

## 🚨 One-Tap SOS
Instantly send your current location and a distress message to your trusted contacts with a single button press.

## 📍 Accurate GPS Tracking
Utilizes advanced geolocator services to pinpoint your exact coordinates for faster response.

## 📞 Direct Police Calling
Skip the dialer. Tap the emergency call button to directly connect with local authorities.

## 👥 Trusted Contacts
Easily add, manage, and edit your network of trusted contacts from your phonebook.

## 📶 Offline Functionality
Does not rely solely on internet connectivity; SOS alerts are sent via direct SMS.

## 📱 Simple & Discreet UI
A clutter-free interface designed specifically for high-stress situations.
""",

    "WOMEN_EMPOWERMENT.md": """# Women Empowerment

## Why This App Matters
**Safety creates confidence.**
When women feel safe and secure in their environment, they are empowered to:
- Study freely without curfew concerns.
- Travel independently and explore the world.
- Work late shifts and pursue ambitious careers.
- Participate fully in public and social life without fear.

## Social Impact
This application supports women globally by:
- **Reducing Response Time:** Bridging the gap between an emergency and the arrival of help.
- **Increasing Confidence:** Acting as a digital safety net.
- **Providing Quick Communication:** Ensuring loved ones are always informed.
- **Fostering Independence:** Helping women make choices based on ambition, not fear.

## Sustainable Development Goals (SDGs)
This project directly aligns with several UN SDGs:
- **Goal 5: Gender Equality** (Empowering women through safety).
- **Goal 3: Good Health and Well-being** (Reducing violence and trauma).
- **Goal 11: Sustainable Cities and Communities** (Making public spaces safer).
- **Goal 9: Industry, Innovation, and Infrastructure** (Using technology for social good).
""",

    "TARGET_AUDIENCE.md": """# Target Audience

Our primary users encompass a wide demographic of individuals who prioritize personal safety.

## 👩‍💼 Working Professionals
Women commuting to and from work, especially those working night shifts, in retail, healthcare, or corporate sectors.

## 🎓 Students
College and university students traveling across campuses, libraries, and dormitories, often late at night.

## 🌍 Solo Travelers
Tourists and digital nomads exploring new cities and unfamiliar environments independently.

## 👨‍👩‍👧 Parents & Families
Parents who wish to ensure the safety of their daughters (and sons) when they are away from home.

## 👵 Senior Citizens
Elderly individuals who may need urgent medical or physical assistance and require an easy-to-use SOS tool.
""",

    "FUTURE_SCOPE.md": """# Future Scope

We are continuously working to make the platform smarter and more resilient. Future updates will include:

- **AI Threat Detection:** Voice recognition to trigger SOS based on distress keywords or screams.
- **Fake Call Feature:** Allowing users to trigger a simulated incoming phone call to gracefully exit uncomfortable situations.
- **Wearable Support & Smartwatch SOS:** Trigger the SOS directly from an Apple Watch, Wear OS device, or Bluetooth button without taking out the phone.
- **Live Video/Audio Recording:** Automatically start recording media when SOS is triggered and sync it securely to the cloud.
- **Community Alerts (Crowdsourcing Help):** Notify nearby app users when an SOS is triggered so community members can offer immediate assistance.
- **Police API Integration:** Direct integration with local emergency dispatch APIs for automated dispatching.
- **AI Chat Assistant:** A companion bot to guide users on safety practices and legal rights.
""",

    "TECH_STACK.md": """# Technology Stack

## 💻 Frontend
- **Framework:** Flutter (Cross-platform for iOS and Android)
- **Language:** Dart

## ⚙️ Backend & Cloud Services
- **Platform:** Firebase
- **Services:** Firebase Authentication, Cloud Firestore, Firebase Cloud Messaging (FCM)

## 📦 Core Packages
- `geolocator`: For highly accurate GPS location fetching.
- `telephony` / `flutter_sms`: For sending background SMS.
- `url_launcher` & `flutter_phone_direct_caller`: For initiating phone calls.
- `shared_preferences`: For local storage of settings and contacts.
- `provider`: For robust state management.
- `permission_handler`: For managing OS-level permissions dynamically.

## 🛠️ Development Tools
- **IDE:** Android Studio, VS Code
- **Version Control:** Git & GitHub
- **CI/CD:** GitHub Actions (Planned)
""",

    "SECURITY.md": """# Security & Privacy

Security is a primary goal. The application is built with a privacy-first mindset to ensure user data is never compromised.

## 🔐 Key Security Features
- **Secure Authentication:** Robust login using Firebase Authentication.
- **Encrypted Data:** User details and contact information are encrypted in transit and at rest.
- **Permission-Based Access:** The app explicitly requests permissions (Location, SMS, Phone) and only uses them when absolutely necessary (e.g., during an SOS).
- **No Background Tracking:** Location is NOT tracked in the background during normal operation. It is only fetched when the user explicitly triggers the SOS.
- **Protected User Information:** Strict data access rules in Firebase prevent unauthorized read/write operations.
""",

    "PRIVACY_POLICY.md": """# Privacy Policy

**Last Updated:** [Date]

## Data Collection
We only collect the minimum amount of data required to provide emergency assistance:
- **Location Data:** Collected ONLY when the SOS button is triggered.
- **Contacts:** Accessed locally to allow you to select your emergency contacts. This data is not uploaded to our servers unless explicitly backed up by the user.

## Data Usage
- Your location and emergency message are sent directly to your chosen contacts via SMS or Push Notifications.
- We do not sell, rent, or share your personal data with third-party marketers.

## Permissions
The app requires the following permissions to function:
- **Location:** Essential for SOS features.
- **SMS & Call:** Essential for notifying contacts and authorities offline.
- **Contacts:** Essential for selecting who to notify.

## User Rights
You have the right to request deletion of your account and all associated data at any time through the app settings.
""",

    "USER_FLOW.md": """# User Flow

## 1. Onboarding
- **Splash Screen** -> **Welcome/Intro Sliders**
- **Login/Registration** (Phone Number or Email/Google)
- **Permissions Request:** Explicitly asking for SMS, Call, Location, and Contacts.

## 2. Setup
- **Home Screen** -> Prompt to add Emergency Contacts.
- **Contact Selection:** Pick from the phonebook.

## 3. Normal Operation
- User opens the app.
- Home screen displays a massive **SOS Button**.
- Quick access buttons for Police, Ambulance, and Fire.

## 4. Emergency State (SOS Triggered)
- User taps the SOS button.
- App fetches Location.
- App sends SMS to contacts in the background.
- App shows a countdown (optional 3 seconds to cancel).
- App initiates a call to the default emergency number.
""",

    "SYSTEM_ARCHITECTURE.md": """# System Architecture

## High-Level Architecture
1. **Client Layer (Mobile App):** 
   - Built with Flutter. Handles UI, State (Provider), and native API interactions (GPS, SMS, Calling).
2. **Service Layer:**
   - Background services to handle location fetching and SMS dispatching independently of the UI thread.
3. **Backend Layer (Firebase):**
   - **Authentication:** Manages user identity.
   - **Firestore Database:** Stores user profiles and synced trusted contacts.
   - **Cloud Messaging:** Handles push notifications between users.

## Data Flow (SOS Event)
1. User triggers SOS -> Mobile Client requests Location.
2. OS Location Services return Lat/Lng.
3. Mobile Client formats an Emergency Message with Google Maps link.
4. Mobile Client invokes Native SMS API to dispatch messages locally.
5. Mobile Client concurrently sends an API request to Firebase to trigger Push Notifications.
6. Mobile Client invokes Native Dialer API to call Authorities.
""",

    "ROADMAP.md": """# Product Roadmap

## 🎯 Phase 1: Core Functionality (Version 1.0)
- User Authentication.
- SOS Button functionality.
- GPS Location fetching.
- Offline SMS Dispatch.
- Emergency Contacts Management.

## 🚀 Phase 2: Cloud Integration (Version 2.0)
- Firebase Database synchronization for contacts.
- Push Notifications for real-time alerts.
- UI/UX improvements and animations.

## 🧠 Phase 3: Advanced Features (Version 3.0)
- Live Location Tracking (Continuous updates).
- Fake Call Simulation.
- Voice-activated SOS Commands.
- Smartwatch / Wear OS Integration.

## 🌐 Phase 4: Expansion (Version 4.0)
- Community Alerts (Crowdsourced Safety).
- Direct Police API Integration (where supported).
- Machine Learning based Safety Prediction (safe routing).
""",

    "FAQ.md": """# Frequently Asked Questions (FAQ)

## Does the app work offline?
**Yes.** The core SOS feature relies on your cellular network to send standard SMS messages. As long as you have a cell signal, the app can send alerts even without active mobile data.

## Is GPS required?
**Yes.** For your contacts to know where to find you, GPS must be enabled. If GPS is off, the app will prompt you to turn it on, and will attempt to send the last known location or just a generic distress message if location is completely unavailable.

## Can I add multiple contacts?
**Yes.** You can add multiple trusted contacts from your phonebook. We recommend adding at least 3 close friends or family members.

## Is my data secure?
**Yes.** Your data is stored securely. Your location is never tracked in the background and is only calculated and shared at the exact moment you press the SOS button.

## Is the app free?
**Yes.** All core safety features (SOS, Location, SMS, Calling) are completely free and will always remain free.
""",

    "CONTRIBUTING.md": """# Contributing to Women Safety App

We love your input! We want to make contributing to this project as easy and transparent as possible.

## How to Contribute
1. **Fork the Repository:** Fork the project to your own GitHub account.
2. **Clone:** Clone it to your local machine.
3. **Branch:** Create a new branch for your feature or bug fix.
   ```bash
   git checkout -b feature/your-feature-name
   ```
4. **Develop:** Make your changes, ensuring you follow the existing code style and structure.
5. **Test:** Run the app and ensure all features work perfectly.
6. **Commit:** Commit your changes with clear, descriptive commit messages.
7. **Push:** Push to your fork and submit a Pull Request.

## Coding Guidelines
- Follow standard Dart and Flutter linting rules.
- Ensure all UI is responsive and accessible.
- Document any new complex logic or services.

## Reporting Bugs
If you find a bug, please create an issue in the GitHub repository detailing the steps to reproduce it, the expected behavior, and your device specifications.
"""
}

for filename, content in docs_content.items():
    with open(os.path.join(docs_dir, filename), "w", encoding="utf-8") as f:
        f.write(content)

print("Documentation and .gitignore updated successfully.")
