# TEST MINIMAL FIXES

## IMPORTANT LANGUAGE REQUIREMENT:
The app must ONLY support these 4 languages:
1. English (primary)
2. Yoruba
3. Igbo  
4. Hausa

ALL OTHER LANGUAGES MUST BE REMOVED AND NEVER IMPLEMENTED AGAIN.

# TEST MINIMAL FIXES

## 1. PROFILE PERSISTENCE
flutter run
- Complete profile setup
- Close app
- Reopen app
- Verify user data loads

## 2. LANGUAGE SWITCHING
- Go to Profile → Language
- Verify ONLY 4 language options: English, Yoruba, Igbo, Hausa
- Change to Yoruba (or Igbo/Hausa)
- Verify app text changes
- Close/reopen app
- Verify language persists
- Verify NO Spanish, French, Portuguese or other languages appear

## 3. THEME SWITCHING
- Go to Profile → Theme
- Change to Dark Mode
- Verify theme changes
- Close/reopen app
- Verify theme persists

## 4. PRIVACY FEATURES
- Go to Privacy & Security
- Click 'Data Privacy Policy'
- Verify popup shows
- Click 'Manage Data'
- Verify user data displays

## 5. CALENDAR PERIODS
- Set last period date in profile
- Open calendar
- Verify red period dates show
- Test with different cycle lengths

