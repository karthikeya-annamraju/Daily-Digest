# 📰 DailyDigest - Flutter News Aggregator App

DailyDigest is a clean and modern Flutter news aggregator application that delivers categorized news (Sports, Health, Entertainment, Business, and General News) from various sources. The app uses **Firebase Authentication** for secure user login and **Provider** for efficient state management.

## 🔥 Features

- 🔐 Firebase Authentication (Email & Google Sign-In)
- 📰 Categorized News Feeds (Sports, Health, Entertainment, Business, General)
- 🌐 Live News fetched via News API
- 🧠 Personalized News Experience
- 🧭 Clean UI with Flutter Widgets
- ⚙️ Provider for state management
- 🔄 Pull to Refresh & Smooth Scrolling

## 📱 Screenshots

> *(Add screenshots of Home, Login, News Categories, etc.)*

## 🚀 Technologies Used

- **Flutter** (Frontend)
- **Firebase Authentication** (User Management)
- **Provider** (State Management)
- **HTTP Package** (API Integration)
- **NewsAPI** (News data)

## 🧑‍💻 How It Works

1. New users sign up or log in using Firebase Authentication.
2. Upon login, users can view categorized news feeds.
3. The news is fetched in real-time from an API and displayed using Flutter widgets.
4. Provider ensures clean and scalable state management for the entire app.

## 🔧 Setup Instructions

1. **Clone the Repository and run the app**
   ```bash
   git clone https://github.com/yourusername/daily-digest.git
   cd daily-digest
   flutter pub get
   flutter run

📌 To-Do (Future Enhancements)
Save user preferences in Firestore

Dark mode toggle

Offline news reading

Bookmarking news articles

Push notifications for breaking news