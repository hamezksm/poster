# Posts Management Web App

A Flutter web application that displays posts from JSONPlaceholder API with routing, search functionality, and data visualization.

## Features

✨ **URL Routing**

- Dashboard: `http://localhost:8080/` or `http://localhost:8080/#/`
- Posts List: `http://localhost:8080/#/posts`
- Post Detail: `http://localhost:8080/#/posts/:id`

> **Note**: The app uses hash-based routing. When the app starts, it automatically loads at the root (`/`) which displays the Dashboard. You can access it via the root URL or explicitly with `/#/`.

📊 **Dashboard**

- Interactive bar chart showing post distribution by user
- Visual analytics of posts count per user ID
- Responsive chart with tooltips

📋 **Posts List**

- Data table with ID and Title columns
- Real-time search functionality
- Clickable rows for navigation to details
- Search by post ID or title

📄 **Post Detail**

- Full post information display
- Clean, readable layout
- Easy navigation back to posts list

## Technology Stack

- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **go_router** - Declarative routing with hash-based URLs
- **dio** - HTTP client for API calls
- **fl_chart** - Beautiful native charts
- **provider** - State management

## API

This app uses [JSONPlaceholder](https://jsonplaceholder.typicode.com) - a free fake API for testing:

- Get all posts: `GET /posts`
- Get single post: `GET /posts/:id`

## Getting Started

### Prerequisites

- Flutter SDK (^3.9.2)
- Dart SDK
- A web browser (Chrome, Firefox, Safari, or Edge)

### Installation & Running

1. **Navigate to the project**:

    ```bash
    cd /Users/user/interview/poster
    ```

2. **Install dependencies**:

    ```bash
    flutter pub get
    ```

3. **Run the application**:

    ```bash
    flutter run -d chrome
    ```

The app will open in your browser at `http://localhost:<port>`.

## Usage

### Navigation

- Use the navigation bar to switch between Dashboard and Posts
- Browser back/forward buttons work
- Direct URL navigation supported

### Searching Posts

1. Navigate to Posts page
2. Type in search box to filter by ID or title
3. Click clear button (×) to reset

### Viewing Details

- Click any row in the posts table to view full details
- Use "Back to Posts" button to return

## Project Structure

```info
lib/
├── main.dart                           # App entry point
├── core/constants/                     # API constants
├── data/
│   ├── models/                         # Data models
│   ├── services/                       # API services
│   └── repositories/                   # Data repositories
├── presentation/
│   ├── providers/                      # State management
│   ├── screens/                        # UI screens
│   └── widgets/                        # Reusable widgets
└── routes/                             # Route configuration
```

## Interview Task

**Client**: AlienSoft Tech  
**Developer**: Mr. Opondo  
**Date**: October 8, 2025  
**Due**: October 9, 2025, 9:00 AM
