//
//  AddExpenseView.swift
//  BudgetTracker
//
//  Created by Bria Williams on 10/22/24.
//

import SwiftUI

struct AddExpenseView: View {
    @Binding var expenses: [Expense]
    var expenseAdded: () -> Void
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var selectedCategory: String = "Food" //default
    let categories = ["Food", "Entertainment", "Housing", "Transportation", "Misc"]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            Form{ //typically for data entry
                Section(header: Text("Enter Expense Details")){
                    TextField("Description", text: $name)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad) //only numbers and decimal points                        }
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) {cat in
                            Text(cat).tag(cat)
                        }
                    }
                    .pickerStyle(.menu) //either this or segmented
                    //.pickerStyle(.segmented)
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            }, trailing: Button("Submit") {
                if let amountValue = Double(amount), !name.isEmpty, !selectedCategory.isEmpty {
                    let newExpense = Expense(name: name, amount: amountValue, category: selectedCategory)
                    expenses.append(newExpense)
                    expenseAdded()
                    dismiss() //look up and comment this
                }
            })
        }
    }
}
#Preview {
    AddExpenseView(expenses: .constant([]), expenseAdded: {})
}
