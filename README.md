# ExpenseTracker — iOS App

ExpenseTracker is a native iOS application built using **SwiftUI and Core Data** to help users record, manage, and track their daily expenses.

The project demonstrates practical implementation of Core Data persistence, SwiftUI state management, CRUD operations, and reactive UI updates.

## Features

- **Add Expenses:** Record an expense with a title and amount.
- **View Expenses:** Display saved expenses, including their dates and amounts.
- **Edit Expenses:** Update an existing expense.
- **Delete Expenses:** Remove expenses using swipe-to-delete.
- **Expense Summary:** Calculate the total of all saved expenses.
- **Persistent Storage:** Store expenses locally using Core Data.
- **Reactive UI:** Automatically refresh the expense list and total when data changes.

## Tech Stack

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Persistence:** Core Data
- **Architecture:** SwiftUI with a managed object context
- **IDE:** Xcode

## Project Structure

```text
ExpenseTracker/
├── ExpenseTrackerApp.swift
├── ContentView.swift
├── EditExpenseView.swift
├── Persistence.swift
├── ExpenseTracker.xcdatamodeld
└── Assets.xcassets
```

*Note: The file structure above describes the expected main files; your actual project may differ slightly.*

## Core Data Model

The app uses an `Expense` entity with the following attributes:

| Attribute | Type | Description |
|---|---|---|
| `id` | UUID | Unique identifier for an expense |
| `title` | String | Expense description |
| `amount` | Double | Expense amount |
| `date` | Date | Date the expense was recorded |

## How It Works

1. SwiftUI collects the expense title and amount from the user.
2. A new `Expense` managed object is created using `NSManagedObjectContext`.
3. Changes are persisted using `context.save()`.
4. `
