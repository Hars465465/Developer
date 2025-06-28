#👨‍💻 Developer – AI-Powered Project-Based Learning Platform
Developer is a full-stack learning platform where users learn by building real-world projects with guidance from an intelligent AI assistant. Whether you're interested in Web, App, Machine Learning, or Game Development, Developer offers personalized, domain-specific project flows and expert-curated roadmaps — all powered by AI.
___
#🚀 Project Highlights
---

•	Interactive Project Selection by Domain & Difficulty

•	AI Chat Assistant powered by Gemini + Tavily + GenAI

•	Firebase Authentication with OTP, Forgot Password

•	Domain Roadmaps to guide learning from beginner to advanced

•	FastAPI Backend with clean architecture and modular routes

•	Scalable Flutter Frontend for mobile & web


#🎯 Problem Statement
---

Most learners struggle with applying what they’ve learned. Developer bridges that gap by enabling learning-by-doing, powered by AI mentorship. Users don’t just read — they build, explore, and evolve.


#💡 Key Features
---

##🔍 Project Discovery

•	Choose a domain (Web, App, ML, Game)

•	Select difficulty (Easy, Medium, Hard)

•	See a project overview with tools, goals & description

#🧠 AI-Powered Chat Assistant
---

•	Step-by-step project help from custom-trained AI

•	Explains code, gives hints, and offers bug help

•	Uses Gemini for generation, Tavily for documentation links, and GenAI for prompt structuring

🔐 Firebase Authentication

•	Email/password signup and login

•	OTP verification

•	Secure password recovery flow

🗺️ Learning Roadmaps

•	Detailed paths for each domain

•	Covers beginner to advanced topics

•	Structured with tools, projects, and learning goals

#🛠 Tech Stack
---
| Layer      | Technology                        |
| ---------- | --------------------------------- |
| Frontend   | Flutter, Firebase Auth, Firestore |
| Backend    | FastAPI (Python), Firebase Admin  |
| AI Layer   | Gemini, GenAI, Tavily             |
| State Mgmt | Riverpod / BLoC                   |


#🧱 Folder Structure
---

Developer/

│
├── flutter_app/                                         # Flutter frontend app      
│      ├── lib/              
│      ├── screens/         
│      ├── services/        
│      └── widgets/         

│
├── backend/                                              # FastAPI backend                        
│     ├── main.py                                                              
│── routers/                                                           
│     ├── models/                                                                    
│     ├── services/                                                                    
│     └── utils/

#📈 App Flow
---

•	User logs in / signs up

•	Chooses domain & difficulty

•	Sees project brief → clicks "Start Project"

•	AI assistant begins guiding project step-by-step

•	User builds, explores docs, and completes project

•	Progress is saved, roadmap updated

#🧪 Backend API Routes
---

| Method | Endpoint             | Description                         |
| ------ | -------------------- | ----------------------------------- |
| POST   | `/auth/login`        | Logs in a user                      |
| POST   | `/auth/signup`       | Creates a new user                  |
| GET    | `/projects/`         | Returns projects by domain & level  |
| GET    | `/projects/{id}`     | Detailed project info               |
| POST   | `/ai/chat`           | AI response via Gemini/GenAI/Tavily |
| GET    | `/roadmaps/{domain}` | Fetch domain-specific roadmap       |


#📦 Getting Started
---

🔧 Prerequisites

•	Flutter SDK

•	Python 3.10+

•	Firebase Project (for Auth & Firestore)

•	Gemini / Tavily / GenAI API Keys

#🚀 Run Flutter Frontend
---

cd flutter_app

flutter pub get

flutter run

#🚀 Run FastAPI Backend
---

cd backend

python -m venv venv

source venv/bin/activate

pip install -r requirements.txt

uvicorn main:app --reload

#🧠 AI Integration
---

Gemini: Generates human-like step breakdowns for projects

Tavily: Provides real-time documentation + GitHub/resource links

GenAI: Formats and processes user prompts into structured flows

These models work together to simulate an intelligent mentor experience during project development.

#🔮 Future Enhancements
---

🧑‍💻 GitHub project export

📈 Dashboard for tracking user learning stats

🏆 XP, Levels, Badges & Gamification

👯‍♂️ Collaborative Projects

🧠 Code Review + Feedback from AI

#🙋‍♂️ About Me
---

Hi! I'm Harsh Dubey, a developer passionate about building impactful tools for learning and growth.

This project reflects my skills in AI, full-stack development, and user experience.

GitHub: https://github.com/Hars465465

LinkedIn: linkedin.com/in/harsh465

Email: harshdubey5510@gmail.com
