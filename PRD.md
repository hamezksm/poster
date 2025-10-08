# Product Requirements Document (PRD)

## Posts Management Web Application

---

## 1. Executive Summary

### 1.1 Purpose

Build a Flutter web application that consumes the JSONPlaceholder API to display posts data with routing, search, and analytics capabilities.

### 1.2 Stakeholders

- **Client**: AlienSoft Tech
- **Developer**: Mr. Opondo
- **End Users**: Interview evaluators

### 1.3 Timeline

- **Start Date**: October 8, 2025
- **Due Date**: October 9, 2025, 9:00 AM
- **Duration**: 24 hours

---

## 2. Product Overview

### 2.1 Vision

A clean, efficient web application that demonstrates proficiency in Flutter web development, API integration, data visualization, and routing.

### 2.2 Goals

1. Demonstrate URL routing implementation with hash-based navigation
2. Showcase data table implementation with search functionality
3. Display data visualization capabilities with charts
4. Prove API integration skills
5. Deliver production-ready code with clean architecture

---

## 3. Functional Requirements

### 3.1 Routing System

#### FR-1.1: Posts List Route

- **Route**: `http://localhost/#/posts`
- **Behavior**: Display all posts in a searchable data table
- **Priority**: P0 (Critical)

#### FR-1.2: Post Detail Route

- **Route**: `http://localhost/#/posts/:id` (e.g., `http://localhost/#/posts/1`)
- **Behavior**: Display single post details based on ID parameter
- **Priority**: P0 (Critical)

#### FR-1.3: Dashboard Route

- **Route**: `http://localhost/#/` or `http://localhost/#/dashboard`
- **Behavior**: Display analytics dashboard with chart
- **Priority**: P0 (Critical)

#### FR-1.4: Navigation

- Navigation bar/menu to switch between routes
- Browser back/forward button support
- Deep linking support

### 3.2 Data Table (Posts List)

#### FR-2.1: Display Requirements

- **Columns**:
  - Post ID (Integer)
  - Title (String)
- **Data Source**: `GET https://jsonplaceholder.typicode.com/posts`
- **Expected Records**: ~100 posts

#### FR-2.2: Search Functionality

- Real-time search as user types
- Search across both ID and Title columns
- Case-insensitive search
- Clear search button
- Show "No results found" when applicable

#### FR-2.3: Table Features

- Sortable columns (ID, Title)
- Row hover effects
- Clickable rows navigate to detail page
- Responsive table layout
- Pagination (optional, if time permits)

#### FR-2.4: Loading & Error States

- Loading indicator while fetching data
- Error message if API fails
- Retry mechanism

### 3.3 Dashboard with Analytics

#### FR-3.1: Chart Requirements

- **Type**: Bar Chart or Column Chart
- **Data**: Number of posts per user_id
- **X-axis**: User ID (1-10)
- **Y-axis**: Post Count
- **Labels**: Clear axis labels and title

#### FR-3.2: Data Processing

- Fetch all posts from API
- Group posts by `userId`
- Count posts for each user
- Display aggregated data in chart

#### FR-3.3: Visual Design

- Clean, professional appearance
- Appropriate colors
- Responsive chart sizing
- Legend if applicable

### 3.4 Post Detail Page

#### FR-4.1: Display Fields

- Post ID
- Title (emphasized/header)
- Body (full text)
- User ID

#### FR-4.2: Data Source

- **Endpoint**: `GET https://jsonplaceholder.typicode.com/posts/:id`
- **Parameter**: ID from URL route

#### FR-4.3: Navigation

- Back button to return to posts list
- Breadcrumb navigation (optional)

#### FR-4.4: Error Handling

- Handle invalid post IDs
- Display 404 message for non-existent posts
- Redirect option to posts list

---

## 4. Non-Functional Requirements

### 4.1 Performance

- **Page Load**: < 2 seconds on average internet connection
- **Search Response**: < 100ms after last keystroke
- **Chart Rendering**: < 1 second

### 4.2 Usability

- Intuitive navigation
- Clear visual hierarchy
- Readable fonts and colors
- Accessible design principles

### 4.3 Compatibility

- **Browsers**: Chrome, Firefox, Safari, Edge (latest versions)
- **Screen Sizes**: Desktop (1024px and above)

### 4.4 Code Quality

- Clean, maintainable code
- Proper separation of concerns
- Meaningful variable/function names
- Comments for complex logic

### 4.5 Reliability

- Graceful error handling
- No application crashes
- Consistent behavior

---

## 5. Technical Specifications

### 5.1 Dependencies

- run 'flutter pub add <?dependency>'

```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^14.0.0           # Routing
  http: ^1.2.0                 # API calls
  fl_chart: ^0.68.0            # Charts
  provider: ^6.1.0             # State management
```

### 5.2 API Integration

#### Endpoint 1: Get All Posts

```info
GET https://jsonplaceholder.typicode.com/posts
Response: Array of Post objects
```

#### Endpoint 2: Get Single Post

```info
GET https://jsonplaceholder.typicode.com/posts/{id}
Response: Single Post object
```

#### Post Model

```dart
{
  "userId": int,
  "id": int,
  "title": string,
  "body": string
}
```

### 5.3 Routing Configuration

- Use `go_router` package
- Hash-based routing for web
- Route guards (optional)
- Error/404 route

---

## 6. User Stories

### US-1: View All Posts

**As a** user  
**I want to** see all posts in a table  
**So that** I can browse available content  

**Acceptance Criteria:**

- Navigate to `/#/posts`
- See table with ID and Title columns
- Table loads within 2 seconds

### US-2: Search Posts

**As a** user  
**I want to** search posts by ID or title  
**So that** I can quickly find specific posts  

**Acceptance Criteria:**

- Type in search box
- Results filter in real-time
- Search works for both ID and Title
- Can clear search

### US-3: View Post Details

**As a** user  
**I want to** click on a post to see full details  
**So that** I can read the complete content  

**Acceptance Criteria:**

- Click row in table
- Navigate to `/#/posts/:id`
- See full post with title, body, user ID
- Can navigate back

### US-4: View Analytics Dashboard

**As a** user  
**I want to** see a chart of posts per user  
**So that** I can understand content distribution  

**Acceptance Criteria:**

- Navigate to `/#/` or `/#/dashboard`
- See bar/column chart
- Chart shows post count for each user
- Clear labels and formatting

---

## 7. UI/UX Requirements

### 7.1 Layout

- App bar with navigation links
- Consistent padding and margins
- Responsive layout
- Material Design components

### 7.2 Navigation Bar

- Dashboard link
- Posts link
- Active route indication
- Logo/app title

### 7.3 Color Scheme

- Primary color: Blue (#2196F3) or custom
- Secondary color: Complementary
- Background: Light theme
- Text: High contrast for readability

### 7.4 Typography

- Headers: Bold, larger font
- Body text: Readable size (16px+)
- Monospace for IDs (optional)

---

## 8. Testing Requirements

### 8.1 Manual Testing Checklist

- [ ] Navigate to `/#/posts` - table displays
- [ ] Search posts - filtering works
- [ ] Click post - navigates to detail
- [ ] Navigate to `/#/posts/1` - shows post 1
- [ ] Navigate to `/#/posts/999` - handles error
- [ ] Navigate to `/#/dashboard` - chart displays
- [ ] Browser back button - works correctly
- [ ] Refresh page - maintains route
- [ ] Direct URL entry - routes correctly

### 8.2 Edge Cases

- Invalid post ID in URL
- Network failure
- Empty search results
- Slow API response

---

## 9. Deliverables

### 9.1 Source Code

- Complete Flutter project
- Clean, commented code
- Proper file organization

### 9.2 Documentation

- README.md with setup instructions
- How to run the application
- Dependencies list

### 9.3 Demo-Ready Application

- Working locally on port 8080 or similar
- All features functional
- No console errors

---

## 10. Success Metrics

1. **Functionality**: All 3 main features working (routing, table, chart)
2. **Code Quality**: Clean, organized, maintainable
3. **UI/UX**: Professional appearance, intuitive navigation
4. **Performance**: Fast load times, responsive interactions
5. **Completeness**: All requirements met

---

## 11. Out of Scope

- User authentication
- Post creation/editing/deletion
- Comments management
- User profile pages
- Mobile responsive design (focus on desktop)
- Offline functionality
- Advanced filtering beyond search
- Export functionality

---

## 12. Assumptions

1. Internet connection available for API calls
2. JSONPlaceholder API is online and accessible
3. Desktop browser environment (1024px+ width)
4. Modern browser with JavaScript enabled
5. Flutter web is properly configured

---

## 13. Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| API unavailable | High | Cache data, show error message |
| Browser compatibility | Medium | Test on multiple browsers |
| Package conflicts | Medium | Use stable package versions |
| Chart rendering issues | Medium | Test thoroughly, have fallback |
| Time constraint | High | Prioritize P0 features first |

---

## 14. Implementation Priority

### P0 (Must Have)

- Routing to all 3 pages
- Posts table with ID and Title
- Search functionality
- Post detail page
- Dashboard with chart

### P1 (Should Have)

- Navigation bar
- Loading states
- Error handling
- Back navigation

### P2 (Nice to Have)

- Sorting
- Pagination
- Breadcrumbs
- Animations

---

## Appendix A: API Response Examples

### Get All Posts Response

```json
[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit recusandae consequuntur..."
  },
  ...
]
```

### Get Single Post Response

```json
{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
}
```

---

**Document Version**: 1.0  
**Last Updated**: October 8, 2025  
**Status**: Approved for Implementation
