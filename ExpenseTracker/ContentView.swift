//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Irfan on 21/10/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var context
    @State private var title = ""
    @State private var amount = ""
    @State private var selectedExpense: Expense?
    @State private var isShowingEditSheet = false
    
    @FetchRequest(
            sortDescriptors: [
                NSSortDescriptor(
                    keyPath: \Expense.date,
                    ascending: false
                )
            ],
            animation: .default
        )
    
    private var expenses: FetchedResults<Expense>
    
    private var totalExpenses : Double {
        expenses.reduce(0) { total,expense  in
            total + expense.amount
            
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Expense Details") {
                    TextField("Expense title", text: $title)
                    
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Button("Save Expense") {
                        saveExpense()
                    }
                    .disabled(
                        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||  Double(amount) == nil || (Double(amount) ?? 0) <= 0
                    )
 
                }
                
                Section("Saved Expenses") {
                    if expenses.isEmpty {
                        Text("No expenses yet.")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(expenses) { expense in
                            HStack {
                                VStack(alignment:.leading, spacing: 4) {
                                    Text(expense.title ?? "Untitled")
                                    
                                    if let date = expense.date {
                                        Text(date, style: .date)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                
                                
                                
                                Text(
                                    (expense.amount as NSNumber)
                                        .doubleValue,
                                    format: .currency(code: "INR")
                                )
                                .fontWeight(.medium)
                                
                                Spacer()
                                
                                Button("Edit") {
                                    selectedExpense = expense
                                    isShowingEditSheet = true
                                }
                            }
                        }
                        .onDelete(perform: deleteExpenses)
                    }
                }
                
                Section("Expense Summary") {
                    HStack {
                        Text("Total Expenses")
                        
                        Spacer()
                        
                        Text(totalExpenses, format: .currency(code: "INR"))
                    }
                }
            }
            .navigationTitle("Expense Tracker")
            .sheet(item: $selectedExpense) { expense in
                EditExpenseView(expense: expense)
            }
        }
        
    }
    
    
    private func deleteExpenses(at offset: IndexSet) {
        for index in offset {
            let expense = expenses[index]
            context.delete(expense)
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to delete expense: \(error)")
        }
    }
    
    
    private func saveExpense() {
        let trimmedCharacters = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedCharacters.isEmpty, let expenseAmount = Double(amount), expenseAmount > 0 else {
            return
        }
        
        let expense = Expense(context: context)
        expense.id = UUID()
        expense.title = trimmedCharacters
        expense.amount = expenseAmount
        expense.date = Date()
        
        do {
            try context.save()
            title = ""
            amount = ""
            print("Expenses saved successfully.")
        } catch {
            print("Failed to save expenses \(error)")
        }

    }
    
    
}

