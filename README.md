# CRUD Application using Flutter and Spring Boot

This is a simple CRUD (Create, Read, Update, Delete) application built using Flutter for the frontend and Spring Boot for the backend.

## Overview

The application provides a user interface to perform CRUD operations on a database. It consists of two main components:

- Frontend: Built with Flutter, a modern UI toolkit. It provides the user interface for interacting with the CRUD functionalities.
- Backend: Built with Spring Boot, a powerful Java-based framework. It handles the business logic and data persistence for the application.
![WhatsApp Image 2024-06-12 at 09 36 18_753a1b77](https://github.com/dev04sa/flutter-spring-boot/assets/129666293/1bb111c1-9208-4d58-9a8a-9e97e84cec45)
![WhatsApp Image 2024-06-12 at 09 36 17_05a4c84f](https://github.com/dev04sa/flutter-spring-boot/assets/129666293/a0c4dd13-82aa-46a9-b6f5-e000a11737f5)
![Screenshot 2024-06-12 093549](https://github.com/dev04sa/flutter-spring-boot/assets/129666293/cf89b5f4-8caa-42f9-9c04-6660a26a313f)

## Prerequisites

Make sure you have the following installed before running the application:

- Flutter SDK: To run the frontend built with Flutter.
- Java Development Kit (JDK): To run the Spring Boot backend.

## Installation

### Frontend

1. Navigate to the `employee_management` directory.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to start the application on your desired device/emulator.

### Backend

1. Navigate to the `crud_app` directory.
2. Import the project into your favorite IDE (Eclipse, IntelliJ, etc.).
3. Build and run the project.

## Usage

Once both the frontend and backend are running, you can access the application on your device/emulator. By default, the backend server runs on port 8080.

## API Documentation

The backend exposes RESTful APIs to perform CRUD operations on employee records. Here are the available endpoints:

- `GET /api/employee`: Retrieve all employees.
- `GET /api/employee/{id}`: Retrieve a specific employee by ID.
- `POST /api/employee`: Create a new employee.
- `PUT /api/employee/{id}`: Update an existing employee.
- `DELETE /api/employee/{id}`: Delete an employee by ID.

## Contributing

Contributions are welcome! If you find any issues or want to add new features, feel free to submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
