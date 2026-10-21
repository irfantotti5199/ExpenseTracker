//
//  EditExpenseView.swift
//  ExpenseTracker
//
//  Created by Irfan on 21/10/26.
//

import SwiftUI
import CoreData

struct EditExpenseView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    let expense: Expense
    @State private var title = ""
    @State private var amount = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Edit Expense") {
                    TextField("Expense title", text: $title)
                    
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Edit Expense")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement:.confirmationAction) {
                    Button("Save") {
                        updateExpense()
                    }
                }
            }
            .onAppear {
                title = expense.title ?? ""
                amount = String(expense.amount)
            }
        }
    }
    
    private func updateExpense() {
        guard let updatedAmount = Double(amount),
              updatedAmount >= 0,
              !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        expense.title  = title
        expense.amount = updatedAmount
        do {
            try context.save()
            dismiss()
        } catch {
            print("Failed to save \(error)")
        }
    }
}

