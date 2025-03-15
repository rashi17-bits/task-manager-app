# 📌 Task Manager App – A Flutter-Based CRUD Application Using Back4App
 
## 📖 Overview  
Task Manager App is a **Flutter-based application** that allows users to **create, read, update, and delete (CRUD) tasks** with real-time synchronization using **Back4App (BaaS)** as the backend.
 
This project is built to demonstrate **Flutter app development with cloud database integration.**
 
---
 
## 🚀 Features  
✅ **User Authentication** – Register and login using a student email ID.  
✅ **Task Management (CRUD)** – Users can add, view, edit, and delete tasks.  
✅ **Back4App Integration** – No need to write backend code.  
✅ **Real-Time Database Syncing** – Changes update dynamically.  
✅ **Secure Logout** – Ensures session invalidation after logout.  
 
---
 
## 🛠️ Tech Stack  
- **Frontend:** Flutter (Dart)  
- **Backend:** Back4App (Parse Server)  
- **Database:** Back4App Cloud Database  
- **Version Control:** GitHub  
 
---
 
## 📱 App Flow  
1️⃣ **User Registration & Login:**  
   - Users register and log in using their **student email ID**.  
   - Credentials are securely stored in **Back4App's authentication system**.  
 
2️⃣ **Task Management (CRUD):**  
   - Users can **create** tasks with a title and description.  
   - Tasks are stored in **Back4App's cloud database**.  
   - Users can **edit or delete** tasks.  
   - The app syncs with the **backend in real time**.  
 
3️⃣ **Logout:**  
   - Users can **securely log out**, and their session will be invalidated.  
 
---
 
## 📂 Project Structure
task-manager-app/  
│-- lib/  
│   │-- main.dart                     # Entry point of the app  
│  
│   ├── screens/  
│   │   │-- login_screen.dart         # User login screen  
│   │   │-- register_screen.dart      # User registration screen  
│   │   │-- task_list_screen.dart     # Task list & CRUD operations  
│  
│-- assets/                           # (Optional) Store images/icons  
│-- pubspec.yaml                      # Flutter dependencies  
│-- README.md                         # Project documentation  
│-- .gitignore                        # Ignored files


## 📸 Screenshots  
 
Screenshots of the app can be found in the `assets/screenshots/` folder.  
 
### Available Screenshots:  
- **Login Screen** (`assets/screenshots/login_screen.JPG`)  
- **Registration Screen** (`assets/screenshots/registration_screen.JPG`)  
- **Successful Registration** (`assets/screenshots/registration_successful.JPG`)  
- **Task Manager Screen** (`assets/screenshots/Task_Manager_Screen.JPG`)  
- **Adding a Task** (`assets/screenshots/Adding_Task.JPG`)  
- **Logout Button** (`assets/screenshots/logout_button.JPG`)  
 
To view them, navigate to the folder in the repository.
 