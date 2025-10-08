# Project Overview: Posts Management Web App

## Project Information

- **Project Name**: Poster
- **Platform**: Flutter Web Application
- **Due Date**: October 9, 2025 (9AM Meeting)
- **Data Source**: JSONPlaceholder API (<https://jsonplaceholder.typicode.com>)

## Technology Stack

- **Framework**: Flutter (Web)
- **Language**: Dart
- **Architecture**: Clean Architecture / MVVM
- **State Management**: Provider / Riverpod (to be decided)
- **HTTP Client**: http / dio package
- **Routing**: go_router
- **Charts**: fl_chart
- **Data Tables**: Custom implementation with search capability

## Project Structure

```info
lib/
├── main.dart                  # App entry point
├── core/
│   ├── constants/            # API endpoints, app constants
│   ├── theme/                # App theming
│   └── utils/                # Helper functions
├── data/
│   ├── models/               # Data models (Post, User)
│   ├── repositories/         # API repositories
│   └── services/             # HTTP services
├── presentation/
│   ├── screens/
│   │   ├── dashboard/        # Dashboard with chart
│   │   ├── posts_list/       # Posts table with search
│   │   └── post_detail/      # Single post view
│   ├── widgets/              # Reusable widgets
│   └── providers/            # State management
└── routes/                   # Route configuration
```

## Key Features

### 1. URL Routing

- **Posts List**: `http://localhost/#/posts` - Displays all posts in a table
- **Post Detail**: `http://localhost/#/posts/:id` - Displays single post details
- **Dashboard**: `http://localhost/#/` or `http://localhost/#/dashboard` - Shows analytics

### 2. Data Table (Posts List)

- Display all posts from API
- Columns: ID, Title
- Search functionality (filter by ID or Title)
- Sortable columns
- Clickable rows to navigate to detail page
- Responsive design

### 3. Dashboard with Analytics

- **Chart Type**: Bar Chart (most appropriate for showing discrete user counts)
- **X-axis**: User ID (1-10)
- **Y-axis**: Number of posts per user
- Visual representation of post distribution
- Clean, professional design

### 4. Post Detail Page

- Display full post information:
  - Post ID
  - Title
  - Body
  - User ID
- Navigation back to posts list
- Clean, readable layout

## API Endpoints Used

1. **Get All Posts**: `GET https://jsonplaceholder.typicode.com/posts`
2. **Get Single Post**: `GET https://jsonplaceholder.typicode.com/posts/{id}`

## Design Considerations

- **Responsive**: Works on desktop browsers
- **Clean UI**: Material Design principles
- **Loading States**: Proper loading indicators
- **Error Handling**: Graceful error messages
- **Performance**: Efficient data fetching and caching

## Development Phases

1. **Phase 1**: Setup & Dependencies
   - Install required packages
   - Configure routing
   - Setup project structure

2. **Phase 2**: Data Layer
   - Create models
   - Implement API services
   - Setup repositories

3. **Phase 3**: UI Implementation
   - Dashboard with chart
   - Posts list with table & search
   - Post detail page

4. **Phase 4**: Testing & Polish
   - Test all routes
   - Verify search functionality
   - Ensure chart displays correctly
   - Final UI polish

## Success Criteria

- ✅ All routes working correctly with hash-based routing
- ✅ Posts table displays all posts with search capability
- ✅ Chart accurately shows post distribution by user_id
- ✅ Clean, professional UI
- ✅ No errors or crashes
- ✅ Fast load times
- ✅ Responsive design
