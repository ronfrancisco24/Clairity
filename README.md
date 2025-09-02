# Clairity: Smart Restroom Air Quality Monitoring System

Clairity is an AI-powered system designed to monitor restroom air quality in schools and institutions. Using IoT sensors and predictive analytics, Clairity helps ensure clean and healthy restrooms by notifying janitorial staff when air quality thresholds are exceeded.

## Features Showcase
1. Real-time Air Quality Monitoring

Clairity tracks restroom air quality continuously, measuring metrics like VOCs, ammonia, and other pollutants.
📊 Users can see live updates on air quality via the mobile app.

2. Predictive Analytics

The system uses a Gradient Boosting machine learning model to classify cleanliness levels and forecast potential air quality issues.
🤖 Helps prevent problems before they become serious.

3. Automated Notifications

Janitorial staff receive instant alerts on their mobile devices when restroom air quality falls below safe thresholds.
📱 Ensures timely cleaning and maintenance.

4. Historical Data & Trends

School IT administrators can view dashboards showing air quality trends over time, helping them make data-driven decisions.
📈 Supports reporting and long-term planning.

5. Cloud Integration

All sensor data is stored and processed in Firestore, and the mobile app fetches the latest readings seamlessly.
☁️ No manual setup required for end users.

6. User-Friendly Mobile App

Simple interface designed for janitors and administrators:

View restroom air quality in real-time

Receive notifications when cleaning is needed

Track trends and historical data

## System Components

Sensors: Installed in restrooms to detect environmental metrics.

Mobile App: Receives notifications and displays air quality data for janitors and administrators.

Cloud Pipeline: Processes and stores sensor data, feeding it to the ML model.

ML Pipeline: Classifies cleanliness levels and predicts potential issues.

## Usage

Janitorial Staff: Receive instant notifications for areas that need attention.

School IT Administrator: Monitor overall restroom air quality and generate reports.

Tech Stack

Frontend: Flutter (mobile app)

Backend & Database: Firebase Firestore

Machine Learning: Gradient Boosting (Python, scikit-learn)

Containerization: Docker (managed by developers, no setup required for users)
