# 💈 Saç Ekim Kliniği Mobil Uygulaması

Modern, çoklu dil destekli ve dark mode özellikli saç ekim kliniği hasta-doktor takip uygulaması.

## 🌟 Özellikler

### ✅ Genel Özellikler
- 🌍 **Çoklu Dil Desteği**: Türkçe ve İngilizce (sistem diline göre otomatik)
- 🌙 **Dark Mode**: Light/Dark tema desteği
- 📱 **Responsive Tasarım**: Phone, tablet ve desktop uyumlu
- 🔐 **Persistent Login**: Logout olana kadar kullanıcı hatırlanır
- 🎨 **Material Design 3**: Modern ve şık UI

### 👤 Hasta Özellikleri
- **Basic Hesap**:
  - 16 haftalık bakım rehberi
  - Fotoğraf yükleme ve not ekleme
  - Doktor yorumlarını görüntüleme
  
- **Premium Hesap**:
  - Basic tüm özellikler
  - Doktor ile canlı chat
  - Öncelikli destek

### 👨‍⚕️ Doktor Özellikleri
- Hasta listesi ve detayları
- Konsültasyonlara yorum yapma
- Premium hastalarla chat
- Hasta ilerleme takibi

## 🚀 Kurulum

### Gereksinimler
- Flutter SDK (3.11.5+)
- Dart SDK
- Android Studio / VS Code
- Android Emulator veya iOS Simulator

### Adımlar

1. **Projeyi klonlayın**
```bash
git clone <repo-url>
cd sac_ekim
```

2. **Dependencies yükleyin**
```bash
flutter pub get
```

3. **Uygulamayı çalıştırın**
```bash
flutter run
```

## 👥 Mock Kullanıcılar

### Doktorlar
| Email | Şifre | İsim |
|-------|-------|------|
| ahmet@clinic.com | 123456 | Dr. Ahmet Yılmaz |
| ayse@clinic.com | 123456 | Dr. Ayşe Demir |
| mehmet@clinic.com | 123456 | Dr. Mehmet Kaya |

### Hastalar (Basic)
| Email | Şifre | İsim | Hafta |
|-------|-------|------|-------|
| ali@mail.com | 123456 | Ali Veli | 4 |
| can@mail.com | 123456 | Can Öz | 2 |
| emre@mail.com | 123456 | Emre Yıldız | 6 |

### Hastalar (Premium)
| Email | Şifre | İsim | Hafta |
|-------|-------|------|-------|
| fatma@mail.com | 123456 | Fatma Şahin | 8 |
| zeynep@mail.com | 123456 | Zeynep Arslan | 12 |
| selin@mail.com | 123456 | Selin Aydın | 10 |

## 📁 Proje Yapısı

```
lib/
├── main.dart                 # Ana uygulama
├── models/                   # Data modelleri
│   ├── user_model.dart
│   ├── doctor_model.dart
│   ├── patient_model.dart
│   ├── care_guide_model.dart
│   ├── consultation_model.dart
│   ├── chat_message_model.dart
│   └── notification_model.dart
├── services/                 # Servisler
│   ├── mock_data_service.dart
│   ├── auth_service.dart
│   └── firebase_service.dart (template)
├── providers/                # State management
│   ├── auth_provider.dart
│   ├── theme_provider.dart
│   ├── locale_provider.dart
│   ├── patient_provider.dart
│   ├── doctor_provider.dart
│   └── notification_provider.dart
├── screens/                  # Ekranlar
│   ├── splash_screen.dart
│   ├── auth/
│   ├── patient/
│   ├── doctor/
│   └── premium/
├── widgets/                  # Reusable widgets
├── utils/                    # Yardımcı dosyalar
│   ├── theme.dart
│   ├── colors.dart
│   ├── constants.dart
│   └── helpers.dart
└── l10n/                     # Localization
    ├── app_en.arb
    └── app_tr.arb
```

## 🎯 Kullanım

### Dil Değiştirme
- Login ekranında sağ üst köşeden dil seçimi yapılabilir
- Sistem dili otomatik algılanır (TR/EN)

### Dark Mode
- Profil sayfasından dark mode açılıp kapatılabilir
- Tercih SharedPreferences'a kaydedilir

### Persistent Login
- "Beni Hatırla" seçeneği ile giriş yapıldığında kullanıcı hatırlanır
- Uygulama kapatılıp açıldığında otomatik giriş yapılır
- Logout yapana kadar oturum devam eder

## 🔥 Firebase Entegrasyonu (Gelecek)

Uygulama Firebase entegrasyonu için hazır:
- `firebase_service.dart` dosyası template olarak hazır
- Yorumları kaldırarak aktif edilebilir
- Gerekli Firebase paketleri `pubspec.yaml`'da yorum satırında

### Firebase Kurulum Adımları:
1. Firebase Console'da proje oluşturun
2. `pubspec.yaml`'daki Firebase paketlerinin yorumunu kaldırın
3. `firebase_service.dart`'daki yorumları kaldırın
4. Firebase config dosyalarını ekleyin
5. Mock data yerine Firebase servislerini kullanın

## 🛠️ Teknolojiler

- **Flutter**: 3.11.5+
- **Provider**: State management
- **SharedPreferences**: Local storage
- **Image Picker**: Fotoğraf yükleme
- **Intl**: Tarih formatlama ve localization
- **Material Design 3**: Modern UI

## 📝 Notlar

- Şu anda mock data kullanılıyor
- Tüm şifreler: `123456`
- Bazı ekranlar "Coming Soon" placeholder'ı içeriyor
- Firebase entegrasyonu için hazır template mevcut

## 🚧 Geliştirme Durumu

✅ Tamamlanan:
- Proje yapısı
- Authentication (mock)
- Tema sistemi (Light/Dark)
- Localization (TR/EN)
- Splash screen + Auto-login
- Hasta/Doktor dashboard
- Mock data service
- Responsive tasarım hazırlığı

⏳ Devam Eden:
- Tüm ekranların detaylı implementasyonu
- Firebase entegrasyonu
- Push notifications
- Payment integration

## 📄 Lisans

Bu proje eğitim amaçlı oluşturulmuştur.

## 👨‍💻 Geliştirici

Senior Flutter Developer tarafından geliştirilmiştir.
