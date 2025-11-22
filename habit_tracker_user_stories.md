# Routiner - Habit Tracker User Stories

## User Story 1: User Registration and Login

**As a** new user  
**I want to** register and securely log in with my personal details  
**So that** I can access the app's features and start tracking my habits

**Acceptance Criteria:**
- User can sign up with username, email, and password
- Login credentials are securely checked
- Error feedback for incorrect login attempts
- Form validation for email format and password strength
- User navigates to home screen after successful login

---

## User Story 2: View Home Screen

**As a** logged-in user  
**I want to** see an overview of my habits and progress on the home screen  
**So that** I can stay motivated and track my daily progress

**Acceptance Criteria:**
- Home screen displays summary and active habits
- Shortcut to add habits from the home screen (FAB button)
- Welcome message or quick guide for new users
- App logo visible in header
- List of habits is scrollable and clickable
- Navigation menu accessible via hamburger icon

---

## User Story 3: View Habit Details

**As a** user  
**I want to** see detailed information about each habit  
**So that** I can track and update my progress

**Acceptance Criteria:**
- Detailed view displays habit description, progress, and color
- User can edit or delete habits from the detail screen
- User can mark a habit as completed
- Back navigation returns to home screen
- Add to favorites button available
- Statistics showing streak and completion count

---

## User Story 4: Favorite Habits (Data Persistence)

**As a** user  
**I want** my login state, preferences, and habit history saved between app sessions  
**So that** I don't have to reset every time I open the app

**Acceptance Criteria:**
- User data persists locally using SharedPreferences
- Login state remembered unless logged out
- App restores preferences (theme, language)
- Favorites are displayed in dedicated page
- User can add/remove habits from favorites
- Data is stored in local storage and visible in both frontend and backend

---

## User Story 5: View External Data (API Integration)

**As a** user  
**I want to** view external data (e.g., weather updates or motivational content) integrated in the app  
**So that** I can have a richer experience

**Acceptance Criteria:**
- Weather API shows real-time data
- External tips/news fetches motivational content
- Loading indicator shows during data fetch
- Error message displays if API call fails
- Data is displayed in a readable format
- Refresh functionality available

---

## User Story 6: Access Settings Menu

**As a** user  
**I want to** access a settings menu from anywhere in the app  
**So that** I can quickly adjust my preferences

**Acceptance Criteria:**
- Settings menu accessible from all screens via icon
- Menu has clear sections (Profile, Notifications, Appearance)
- Menu displays all available settings options
- Logout option available
- User profile information displayed in menu header

---

## User Story 7: Configure Application Settings

**As a** user  
**I want to** change account details and adjust application preferences in the settings screen  
**So that** I can personalize my experience

**Acceptance Criteria:**
- User can update name, email, password
- User can switch between dark and light modes
- Notification and privacy settings available
- Changes are saved and persist across sessions
- Theme changes apply immediately
- Language preferences can be selected

---

## User Story 8: Receive Notifications

**As a** user  
**I want to** receive timely notifications about my habits  
**So that** I don't forget to complete them

**Acceptance Criteria:**
- User can turn notifications on/off for each habit
- Notification times can be set/configured
- User receives daily reminder notifications
- App requests notification permissions on first use
- Test notification can be triggered
- Tapping notification navigates to relevant content

---

## User Story 9: Navigate Between Screens

**As a** user  
**I want** smooth navigation between all app screens  
**So that** I can easily move through the app and access different features

**Acceptance Criteria:**
- Back navigation works from all screens
- Bottom navigation bar accessible globally
- Navigation transitions are smooth and intuitive
- Hamburger menu provides quick access to settings
- Navigation icons are clearly visible
- Screen transitions maintain app state
