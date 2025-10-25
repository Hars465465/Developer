<div align="center">

<h1>
  <img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Objects/Laptop.png" width="40" height="40" />
  Developer - AI-Powered Project-Based Learning Platform
</h1>

<p><i>Learn by Building. Guided by AI.</i></p>

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![Firebase](https://img.shields.io/badge/Firebase-Auth-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![AI Powered](https://img.shields.io/badge/AI-Gemini%20%7C%20Tavily-8E75B2?logo=googlegemini&logoColor=white)](https://ai.google.dev/)

<p>
  <a href="#-what-is-developer">About</a> •
  <a href="#-features">Features</a> •
  <a href="#-tech-stack">Tech Stack</a> •
  <a href="#-installation">Installation</a> •
  <a href="#-api-endpoints">API</a> •
  <a href="#-roadmap">Roadmap</a>
</p>

</div>
## 🎯 What is Developer?

**Developer** is a full-stack learning platform that revolutionizes how people learn to code — **by building real-world projects** with an intelligent AI mentor by their side.

<table>
<tr>
<td width="50%">

**💡 The Problem**

Most learners struggle with applying what they've learned. Traditional learning focuses on theory without practical implementation.

</td>
<td width="50%">

**✅ The Solution**

Developer enables **learning-by-doing** with personalized, domain-specific project flows and AI-powered guidance every step of the way.

</td>
</tr>
</table>

Whether you're diving into **Web Development**, **Mobile Apps**, **Machine Learning**, or **Game Development** — Developer provides curated roadmaps and intelligent assistance to help you **learn, build, and grow**.

---
## ✨ Features

<table>
<tr>
<td width="50%">

### 🎨 Interactive Project Discovery
- Choose from **4 domains**: Web, App, ML, Game
- Filter by difficulty: **Easy** | **Medium** | **Hard**
- Detailed project briefs with tools & goals

</td>
<td width="50%">

### 🧠 AI Chat Assistant
- Powered by **Gemini + Tavily + GenAI**
- Step-by-step project guidance
- Code explanations, hints & debugging help

</td>
</tr>
<tr>
<td width="50%">

### 🔐 Secure Authentication
- Firebase Email/Password Auth
- OTP verification
- Forgot password recovery flow

</td>
<td width="50%">

### 🗺️ Learning Roadmaps
- Beginner → Advanced paths
- Domain-specific learning tracks
- Tools, projects & milestones

</td>
</tr>
</table>

---
## 🛠️ Tech Stack

<div align="center">

### Frontend
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Riverpod](https://img.shields.io/badge/Riverpod-1389FD?style=for-the-badge&logo=flutter&logoColor=white)

### Backend
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Firebase Admin](https://img.shields.io/badge/Firebase_Admin-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)

### AI & APIs
![Google Gemini](https://img.shields.io/badge/Google_Gemini-8E75B2?style=for-the-badge&logo=googlegemini&logoColor=white)
![Tavily](https://img.shields.io/badge/Tavily-000000?style=for-the-badge)
![GenAI](https://img.shields.io/badge/GenAI-FF6F00?style=for-the-badge)

</div>

---
## 🏗️ Architecture

### Project Structure
```
Developer/
│
├── 📱 flutter_app/ # Flutter Frontend
│ ├── lib/
│ │ ├── screens/ # UI screens
│ │ ├── services/ # API & Firebase services
│ │ ├── widgets/ # Reusable components
│ │ ├── models/ # Data models
│ │ └── providers/ # State management
│ └── pubspec.yaml
│
├── 🔧 backend/ # FastAPI Backend
│ ├── main.py # Entry point
│ ├── routers/ # API routes
│ │ ├── auth.py
│ │ ├── projects.py
│ │ ├── ai.py
│ │ └── roadmaps.py
│ ├── models/ # Pydantic models
│ ├── services/ # Business logic
│ │ ├── firebase.py
│ │ ├── ai_service.py
│ │ └── project_service.py
│ ├── utils/ # Helper functions
│ └── requirements.txt
```
### System Flow


---
## 🚀 Installation

### Prerequisites

Before you begin, ensure you have:

- ✅ [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.0+)
- ✅ [Python](https://www.python.org/downloads/) (v3.10+)
- ✅ [Firebase Project](https://console.firebase.google.com/) with Auth & Firestore
- ✅ API Keys: [Gemini](https://ai.google.dev/), [Tavily](https://tavily.com/), GenAI

---

### 📱 Flutter Frontend Setup

1. Clone the repository
git clone https://github.com/Hars465465/Developer.git
cd Developer/flutter_app

2. Install dependencies
flutter pub get

3. Configure Firebase
Add google-services.json (Android) to android/app/
Add GoogleService-Info.plist (iOS) to ios/Runner/
4. Run the app
flutter run


---

### 🔧 FastAPI Backend Setup

1. Navigate to backend
cd Developer/backend

2. Create virtual environment
python -m venv venv

3. Activate virtual environment
Windows:
venv\Scripts\activate

macOS/Linux:
source venv/bin/activate

4. Install dependencies
pip install -r requirements.txt

5. Configure environment variables
cp .env.example .env

Edit .env with your credentials
6. Run the server
uvicorn main:app --reload --host 0.0.0.0 --port 8000


---

### 🌐 Environment Variables

Create `.env` file in backend directory:

## 📡 API Endpoints

<details>
<summary><b>🔐 Authentication Routes</b></summary>

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/auth/signup` | Register new user |
| `POST` | `/auth/login` | User login |
| `POST` | `/auth/verify-otp` | Verify OTP |
| `POST` | `/auth/forgot-password` | Password recovery |
| `POST` | `/auth/reset-password` | Reset password |

</details>

<details>
<summary><b>📚 Project Routes</b></summary>

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/projects/` | Get projects by domain & difficulty |
| `GET` | `/projects/{id}` | Get project details |
| `POST` | `/projects/{id}/start` | Start a project |
| `GET` | `/projects/{id}/progress` | Get user progress |

</details>

<details>
<summary><b>🤖 AI Assistant Routes</b></summary>

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/ai/chat` | Send message to AI assistant |
| `GET` | `/ai/chat/history` | Get chat history |
| `POST` | `/ai/generate-hint` | Generate code hints |

</details>

<details>
<summary><b>🗺️ Roadmap Routes</b></summary>

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/roadmaps/{domain}` | Get domain roadmap |
| `GET` | `/roadmaps/{domain}/milestones` | Get learning milestones |

</details>

---
## 🧠 AI Integration

The platform uses **three AI models** working together:

| AI Model | Purpose | Capabilities |
|----------|---------|--------------|
| 🤖 **Gemini** | Conversational AI | Natural language understanding<br>Step-by-step breakdowns<br>Code explanations |
| 🔍 **Tavily** | Documentation Search | Real-time doc retrieval<br>GitHub resources<br>Tutorial recommendations |
| ⚡ **GenAI** | Prompt Engineering | Query structuring<br>Context management<br>Response formatting |

### How It Works

1. **User asks a question** → Sent to FastAPI backend
2. **GenAI structures the prompt** → Optimizes for clarity
3. **Gemini generates response** → Intelligent answer
4. **Tavily enriches with docs** → Adds relevant links
5. **Response returned to user** → Complete guidance

---
## 🤝 Contributing

Contributions are **greatly appreciated**! Here's how:

1. **Fork the Project**
2. **Create Feature Branch** (`git checkout -b feature/AmazingFeature`)
3. **Commit Changes** (`git commit -m 'Add AmazingFeature'`)
4. **Push to Branch** (`git push origin feature/AmazingFeature`)
5. **Open a Pull Request**

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 👨‍💻 About the Developer



### Harsh Dubey
**Full-Stack Developer | AI Enthusiast | Builder of Learning Tools**

<p align="center">
  <a href="https://github.com/Hars465465">
    <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
  </a>
  <a href="https://linkedin.com/in/harsh465">
    <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
  </a>
  <a href="mailto:harshdubey5510@gmail.com">
    <img src="https://img.shields.io/badge/Email-EA4335?style=for-the-badge&logo=gmail&logoColor=white" alt="Email"/>
  </a>
</p>


## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - Beautiful native apps
- [FastAPI](https://fastapi.tiangolo.com/) - Modern Python framework
- [Firebase](https://firebase.google.com/) - Backend as a service
- [Google Gemini](https://ai.google.dev/) - AI model
- [Shields.io](https://shields.io/) - README badges

---



### ⭐ Star this repo if you find it helpful!

[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/Hars465465/Developer)

Made with ❤️ by [Harsh Dubey](https://github.com/Hars465465)

**Happy Learning! 🚀**

</div>
