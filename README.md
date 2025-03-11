# QuickCampus

QuickCampus is a mobile application designed to bridge the logistical gap between Ashesi University students and Accra by providing an efficient delivery service. The platform enables students to send and receive items effortlessly while ensuring smooth communication with riders.

## 📌 Features

### For Students:
- **User Authentication**: Secure login and registration with email verification.
- **Order Placement**: Easily request item deliveries with specified drop-off locations.
- **Real-time Tracking**: Monitor your item's live location with GPS tracking.
- **Order History**: Access past deliveries and their statuses.
- **In-app Calling**: Direct communication with assigned riders.
- **Notifications & Alerts**: Receive push notifications for order updates.
- **Profile Management**: Personalize your profile for better user experience.
- **Biometric Authentication**: Secure app access using fingerprint or face recognition.

### For Riders:
- **Navigation Assistance**: Integrated Google Maps for efficient routes.
- **Status Updates**: Update order statuses (e.g., picked up, delivered).
- **Order Assignment**: View assigned deliveries and optimize delivery routes.

### For Admins:
- **Manage Riders & Orders**: Oversee rider assignments and order management.

## 🏗 Tech Stack

### Backend:
- **PHP**
- **Composer** (Dependency Manager)
- **AltoRouter** (Routing)
- **phpDotenv** (Environment Variables)
- **PHPMailer** (Email Service)
- **XAMPP** (Apache & MySQL Server)
- **AWS EC2** (Hosting)

### Frontend (Mobile App):
- **Flutter** (Dart Framework)
- **Google Maps Flutter** (Mapping & Navigation)
- **Flutter Provider** (State Management)
- **Flutter Image Picker** (Gallery Access)
- **Flutter Local Auth** (Biometric Authentication)
- **Flutter Shared Preferences** (Local Caching)
- **Geocoding Package** (Convert Coordinates to Addresses)
- **Google Maps APIs** (Routing, Directions, Places, Marking)
- **Dart Email OTP Package** (Email Verification)
- **Sliding Up Package** (UI Enhancements)

### Planned Features:
- **Firebase** (Real-time location updates & push notifications)
- **Flutter Phone Caller** (Direct Calls)
- **Dart Direct Caller Sim Choice** (Call Optimization)

## 📊 Database Design
The system is designed to manage users (students, staff, and riders) and track delivery requests efficiently. A UML database diagram is available for reference.

## 🔧 Setup & Installation
### Backend Setup:
1. Clone the repository:
   ```sh
   git clone https://github.com/P-Asare/quick-campus.git
   ```
2. Install dependencies:
   ```sh
   composer install
   ```
3. Configure environment variables:
   - Create a `.env` file and set up database credentials.
4. Start the PHP server:
   ```sh
   php -S localhost:8000
   ```

### Mobile App Setup:
1. Install Flutter dependencies:
   ```sh
   flutter pub get
   ```
2. Run the app on an emulator or device:
   ```sh
   flutter run
   ```

## 📌 Important Links
- **Figma Prototype**: [QuickCampus UI Design](https://www.figma.com/design/92Gdk4Zl8owFxKXPPzLotb/quick-campus?node-id=0-1&t=dlAeE7Lzc45SA0oe-1)
- **Demo Video**: [YouTube Demo](https://youtu.be/FPgR_MkntAM)

## 🤝 Contributing
Contributions are welcome! Feel free to fork the repository and submit a pull request with improvements or bug fixes.

## 📜 License
This project is licensed under the MIT License.

---
### 🚀 QuickCampus - Making Deliveries Easier for Ashesi University!
