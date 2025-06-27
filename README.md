# Finance Tracker

A full-stack finance tracking application with an iOS frontend and Node.js backend.

## Project Structure

```
finance-tracker/
├── ios/                           # iOS Application
│   ├── FinanceTracker.xcodeproj   # Xcode project file
│   ├── FinanceTracker/            # Main iOS app source
│   ├── FinanceTrackerTests/       # Unit tests
│   └── FinanceTrackerUITests/     # UI tests
├── backend/                       # Backend API Server
│   ├── controllers/               # Route controllers
│   │   ├── deleteAccount.ts       # Account deletion logic
│   │   ├── login.ts              # User authentication
│   │   └── signup.ts             # User registration
│   ├── models/                    # Database models
│   │   └── User.ts               # User model
│   ├── routes/                    # API routes
│   │   ├── deleteAccount.ts       # Account deletion routes
│   │   ├── login.ts              # Authentication routes
│   │   └── signup.ts             # Registration routes
│   ├── server.ts                  # Main server entry point
│   ├── package.json              # Node.js dependencies
│   ├── tsconfig.json             # TypeScript configuration
│   └── .env                      # Environment variables
└── README.md                     # This file
```

## Getting Started

### Backend Setup
1. Navigate to the backend directory: `cd backend`
2. Install dependencies: `npm install`
3. Configure environment variables in `.env`
4. Start the server: `npm start`

### iOS Setup
1. Open `ios/FinanceTracker.xcodeproj` in Xcode
2. Build and run the project

## Features

### Current Implementation
- User authentication (signup/login)
- Account management (delete account)
- RESTful API backend
- iOS frontend with SwiftUI

### Planned Features
- Expense tracking
- Budget management
- Financial reports
- Data visualization
- Multi-platform support

## Technology Stack

**Backend:**
- Node.js
- TypeScript
- Express.js
- MongoDB

**iOS:**
- Swift
- SwiftUI
- Xcode

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request
