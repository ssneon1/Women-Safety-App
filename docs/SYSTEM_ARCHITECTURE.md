# System Architecture

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
