# HammerSystem

iOS приложение для доставки еды, разработанное на SwiftUI 
## 🏗️ Архитектура

- **MVVM** паттерн
- **Clean Architecture**
- **Dependency Injection**
- **Protocol-oriented programming**

## 📱 Функциональность

### ✅ Реализовано:
- 🚀 Splash экран с анимацией
- 🔐 Экран авторизации с валидацией
- 🍕 Главный экран с категориями еды
- 📍 Выбор города
- 🏷️ Sticky категории с прокруткой
- 🍽️ API интеграция (TheMealDB, TheCocktailDB)
- 📱 Offline режим с кэшированием
- 🎨 Pixel-perfect UI по дизайну

- ## Скриншоты

### Splash Screen
<p align="center">
  <img src="https://github.com/user-attachments/assets/a8232c0a-f082-4792-8f66-6475f3d6ed08" width="200" alt="Splash Screen">
</p>


### Login
<p align="center">
  <img src="https://github.com/user-attachments/assets/96ec89b3-48ea-492a-bc91-770f164679ad" width="200" alt="Splash Screen">
</p>


### Login Input
<p align="center">
  <img src="https://github.com/user-attachments/assets/ff6446c9-1103-46de-80b0-9dff1ac54181" width="200" alt="Login Input">
</p>


### Login (error)
<p align="center">
  <img src="https://github.com/user-attachments/assets/f3a33bfe-797d-41a6-809e-ffdc688809a0" width="200" alt="Login (error)">
</p>


### Login (successful)
<p align="center">
  <img src="https://github.com/user-attachments/assets/c95ab77e-10ca-4d93-a4eb-30360d719ff5" width="200" alt="Login (successful)">
</p>


### Main View
<p align="center">
  <img src="https://github.com/user-attachments/assets/fa313087-3207-4475-8b46-17370dd53f36" width="200" alt="Main View">
</p>


### List Scrolled
<p align="center">
  <img src="https://github.com/user-attachments/assets/e91638b5-fc3a-4432-8538-079cff43d707" width="200" alt="List Scrolled">
</p>


## 🎥 Demo

<p align="center">
  <img src="https://github.com/user-attachments/assets/2d82817d-6f85-414c-a99d-83e5a647aa59" width="250" alt="App Demo">
</p>




### 🛠️ Технологии:
- **SwiftUI** - UI фреймворк
- **URLSession** - сетевые запросы
- **UserDefaults** - локальное хранение
- **Async/await** - асинхронное программирование
- **Combine** - реактивное программирование

## 📁 Структура проекта

```
HammerSystem/
├── Services/           # Бизнес логика
│   ├── NetworkService
│   ├── CacheService
│   └── FoodDataService
├── Models/            # Модели данных
├── Components/        # Переиспользуемые UI компоненты
├── Views/            # Экраны приложения
└── Assets/           # Изображения и ресурсы
```

## 🚀 Запуск проекта

1. Клонируйте репозиторий
2. Откройте `HammerSystem.xcodeproj` в Xcode
3. Выберите симулятор iOS 17.0+
4. Нажмите ⌘+R для запуска

## 📋 Требования

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+


## 👨‍💻 Разработчик

Создано в рамках тестового задания для демонстрации навыков iOS разработки. 
