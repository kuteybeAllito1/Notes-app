## comprehensive note management system



# 📱 Notes App (with Firebase)
This is a complete notes management application built with Flutter and Firebase. It allows users to:

    Create, edit, and delete note categories.

    Add unlimited notes under each category.

Edit or delete individual notes.

# 🔒 Authentication Features (via Firebase Auth):
Register with email and password.

    Email verification through a confirmation link.

    Password reset functionality.

    Sign in with Google account (one-click login).


# ☁️ Data Storage:
    All data (categories and notes) is stored securely using Firebase Firestore.





## 🔐 Login Screen
Clean and user-friendly login screen with support for:

Email and password authentication

Password reset

Social login options (Google, Facebook, Apple)
![Image](https://github.com/user-attachments/assets/66ef834a-219e-4a55-9067-5415b3c841fe)

## 📝 Sign Up Screen
A simple and intuitive registration screen where users can:

Create a new account using their username, email, and password

Easily switch to the login screen if they already have an account
![Image](https://github.com/user-attachments/assets/1f62921e-6549-4c07-8bd1-25976f3c403c)

## 🗂️ Home Page (Categories)
The main screen displays all note categories in a clean folder-style layout.
Users can:

View existing categories

Tap to enter a specific category

Create new categories using the floating action button
![Image](https://github.com/user-attachments/assets/eed2391c-fbb5-4604-bad3-97247a6adefb)

## ➕ Add Category Screen
A minimal and user-friendly interface to create new note categories.
Users can simply type the category name and click Add to save it to the database.
![Image](https://github.com/user-attachments/assets/9f5ef7b2-4780-4a31-90e6-49e07f1259f1)

## 📝 View Notes Screen
Displays all notes under the selected category in a simple card-based layout.
Users can:

View the content of each note

Tap the floating button to add a new note to the current category
![Image](https://github.com/user-attachments/assets/7f624fdc-1ca2-4ca2-bcd4-c5829593fc97)

## ✍️ Add Note Screen
A clean input interface where users can write and save a new note under the selected category.
Just type the note content and click Add to store it in Firebase.
![Image](https://github.com/user-attachments/assets/a6c9dbc4-69d3-4085-b832-c9f9f7a594c3)

## ⚠️ Delete Confirmation Dialog
A warning dialog appears when the user attempts to delete a note.
This ensures that deletions are intentional and helps prevent accidental data loss.
![Image](https://github.com/user-attachments/assets/e0bc7654-b0f4-4c16-81d0-f08b4553c416)
### A new Flutter project.


