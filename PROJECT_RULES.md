# ElectroMart - Project Rules

## Project Goal

Build a clean, professional Flutter E-Commerce application for the Fake Store API.

The project should demonstrate good Flutter development practices while keeping the code easy to understand for a beginner.

The code should be simple, readable, maintainable, and well documented.

---

# Architecture

Use Clean Architecture.

Each feature must contain:

feature/

    data/

    domain/

    presentation/

Do not mix business logic with UI.

---

# Code Style

Always write beginner-friendly code.

Avoid advanced Dart features unless absolutely necessary.

Prefer readable code over clever code.

Keep functions short.

Keep classes focused on one responsibility.

Use meaningful variable names.

Comment complex logic.

Avoid unnecessary abstractions.

---

# State Management

Use Riverpod.

Only one provider should manage one responsibility.

Examples:

- Auth Provider
- Product Provider
- Cart Provider
- Search Provider
- Profile Provider

Avoid deeply nested providers.

---

# Networking

Use Dio.

Create only one Dio client.

Use one ApiService.

Handle errors gracefully.

Do not duplicate API code.

---

# Repository Pattern

Every feature should have:

Repository Interface

↓

Repository Implementation

Repositories communicate with:

- Remote Data Source
- Local Storage

Presentation should never call Dio directly.

---

# Models

API JSON should be converted into Models.

Models should use:

- freezed
- json_serializable

Never expose JSON directly to UI.

---

# Local Storage

Use SharedPreferences.

Store:

- Login session
- Shopping cart

Save cart as JSON.

Restore cart automatically when the app starts.

---

# UI

Use Material 3.

Professional UI.

Modern spacing.

Rounded corners.

Good typography.

Responsive layouts.

Small reusable widgets.

Avoid large widgets.

---

# Folder Structure

Every feature contains:

data/
    datasource/
    models/
    repositories/

domain/
    entities/
    repositories/
    usecases/

presentation/
    pages/
    providers/
    widgets/

---

# Screens

Splash

Login

Home

Product Details

Search

Categories

Cart

Profile

---

# Loading States

Every API request must show:

Loading

Success

Error

Retry Button

---

# Empty States

Show user-friendly messages for:

No Products

No Search Results

Empty Cart

No Categories

---

# Error Handling

Handle:

Network Error

Timeout

API Error

Unexpected Error

Display friendly messages.

---

# Reusable Widgets

Create reusable widgets whenever possible.

Examples:

PrimaryButton

AppTextField

LoadingWidget

ErrorWidget

EmptyWidget

ProductCard

CategoryChip

CartTile

---

# Navigation

Use GoRouter.

Do not use Navigator.push directly.

---

# Code Generation

Use:

freezed

json_serializable

Run build_runner whenever models change.

---

# Git
 you tell the user as it
Commit after every completed module.



---

# Important

Always prefer simplicity.

If there are multiple solutions,

choose the easiest one to understand.

The goal is production-quality architecture with beginner-friendly implementation.