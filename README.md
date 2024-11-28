
# Cafe Order Food App (COFA)

Welcome to the Cafe Order Food App (COFA), a project designed to showcase a food ordering application. This app allows users to explore the food menu, view item details, and place orders. Its user interface and functionalities are designed to provide an easy and efficient food ordering experience.

<div align="center">
  <img src="GIF/jitter1.gif" alt="jitter" style="width: 100%; height: 500px;">
  <img src="GIF/jitter2.gif" alt="jitter" style="width: 100%; height: 500px;">
</div>

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Tech Stack](#tech-stack)
- [ScreenShots](#ScreenShots)


## Features
- *Login*: Login to the App.
- *Register*:  Register Account to Login the App.
- *Logout*: Logout from the App.
- *Food Category": Choices from several food categories
- *Food Detail":  Access complete information about each food item, including images.
- *Chart*: Display the selected food
- *Detail Order*: Displays all information about the order before payment
- *Payment*: Make a payment.
- *Add Order*: Add new Order with details like name, category, price, and date.
- *Remove Order*: Remove Order from Chart.
- *History Order*: Can see for History Order.


## Installation

1. *Clone the repository*
   sh
   git clone https://github.com/irvanwilly13/FinalProjectIOS_IrvanWilly

2. *Open the project*
   Open the cloned repository in Xcode.

## Tech Stack

![Alt text](./imageFinalProj/techStack.jpg)

### **Kingfisher**
### **RxSwift**
### **Firebase**
### **IQKeyboardCore**
### **Lottie**
### **Midtrans**
### **netfox**
### **SkeletonView**
### **SnapKit**
### **Toast**


# Design Patterns
![Alt text](./imageFinalProj/MVVM.jpg)

This project adopts the Model-View-ViewModel MVVM separates an app’s user interface (View) from the underlying data (Model) and introduces an intermediary component called ViewModel to manage the presentation logic.

## ScreenShots

| OnBoard | Login | Register |
|--------|--------|---------|
| ![Mobile](./imageFinalProj/1.png) | ![Tablet](./imageFinalProj/2.png) | ![Desktop](./imageFinalProj/3.png) |
| Dashboard | FoodCategory | DetailFood |
|--------|--------|---------|
| ![Mobile](./imageFinalProj/4.png) | ![Tablet](./imageFinalProj/5.png) | ![Desktop](./imageFinalProj/6.png) |
| Chart | DetailOrder | Address |
|--------|--------|---------|
| ![Mobile](./imageFinalProj/7.png) | ![Tablet](./imageFinalProj/8.png) | ![Desktop](./imageFinalProj/9.png) |
| Promo | Payment | Payment |
|--------|--------|---------|
| ![Mobile](./imageFinalProj/10.png) | ![Tablet](./imageFinalProj/11.png) | ![Desktop](./imageFinalProj/12.png) |
| Payment Success | HistoryOrder | DetailHistory Order |
|--------|--------|---------|
| ![Mobile](./imageFinalProj/13.png) | ![Tablet](./imageFinalProj/14.png) | ![Desktop](./imageFinalProj/15.png) |


# Cafe Order Food App - Project Structure

```
CafeFoodOrderApp
├── CafeFoodOrderApp
│   ├── Coordinator
│   ├── Configuration
│   ├── Resource
│   ├── Network
│   ├── Component
│   │   ├── BottomSheetAddAddress
│   │   ├── BottomSheetReview
│   │   ├── ErrorView
│   │   ├── BottomSheet
│   │   ├── PopUp
│   │   ├── EmptyChart
│   │   ├── ToolBarView
│   │   ├── LeftMenuBottomSheetViewController
│   │   └── CustomInputField
│   ├── Common
│   ├── Module
│   │   ├── FoodReviewViewController
│   │   ├── CancelOrderViewController
│   │   ├── AdsViewController
│   │   ├── PickAddressViewController
│   │   ├── FilterHistoryViewController
│   │   ├── PromotionViewController
│   │   ├── OrderPageViewController
│   │   ├── PaymentMidTransViewController
│   │   ├── HelpCenterViewController
│   │   ├── TermOfServicesViewController
│   │   ├── PrivacyPolicyViewController
│   │   ├── ProfileUserViewController
│   │   ├── ChangeInformationViewController
│   │   ├── MapKitView
│   │   ├── ForgotPassword
│   │   ├── FilterBottomSheet
│   │   ├── ConfirmPaymentViewController
│   │   ├── PaymentViewController
│   │   └── DetailFoodViewController
│   ├── DetailFoodViewController
│   ├── CategoryViewController
│   ├── ProfileViewController
│   ├── HistoryOrderDetailViewController
│   ├── HistoryOrderViewController
│   ├── ChartViewController
│   ├── DashboardViewController
│   ├── MainTabBarController
│   ├── RegisterViewController
│   ├── LoginViewController
│   ├── OnBoard
├── App
│   ├── ViewController
├── Main
├── LaunchScreen
├── Info
├── GoogleService-Info
├── CoreData
├── CafeFoodOrderAppTests
```

# ToDo App

Keep track of tasks, improvements, and future plans for our project.

- [ ] Implement Tracking Order
- [ ] Implement Searching Product
- [ ] Implement Point App
- [ ] Implement Payment with Qris





