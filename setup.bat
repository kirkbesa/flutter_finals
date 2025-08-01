@echo off
echo ========================================
echo Flutter Banking App Setup
echo ========================================

echo.
echo 1. Installing Flutter dependencies...
C:\flutter\bin\flutter.bat pub get

echo.
echo 2. Generating JSON serialization code...
C:\flutter\bin\flutter.bat packages pub run build_runner build

echo.
echo 3. Setting up backend...
cd backend

echo Installing Node.js dependencies...
npm install

echo.
echo 4. Creating environment file...
if not exist .env (
    copy env.example .env
    echo Environment file created. Please edit .env with your MongoDB connection string.
) else (
    echo Environment file already exists.
)

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Install MongoDB (local or Atlas)
echo 2. Edit backend/.env with your MongoDB connection
echo 3. Start backend: cd backend && npm start
echo 4. Run Flutter app: C:\flutter\bin\flutter.bat run -d chrome
echo.
echo Default test account:
echo Phone: 092738039355
echo MPIN: 2222
echo.
pause 