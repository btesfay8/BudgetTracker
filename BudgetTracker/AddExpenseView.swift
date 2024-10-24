//
//  AddExpenseView.swift
//  BudgetTracker
//
//  Created by Bria Williams on 10/22/24.
//

import SwiftUI

struct AddExpenseView: View {
    @Binding var expenses: [Expense] = []
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var selectedCategory: String = ""
    let categories = ["Food", "Entertainment", "Housing", "Transportation", "Misc"]
    @Environment(\.presentationMode) var presentationMode //may be deprecated
    
    var body: some View {
        NavigationView{
            Form{ //typically for data entry
                Section(header: Text("idk what to put here yet")){
                    TextField("Name", text: $name) //editable text interface
                    //TODO figure out how to format to currency
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad) //only numbers and decimal point
                    Picker("Category", selections: $selectedCategory) {
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
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Submit") {
                if let amountValue = Double(amount) {
                    let newExpense = Expense(name: name, amount: amountValue, category: selectedCategoryategory)
                    expenses.append(newExpense)
                    presentationMode.wrappedValue.dismiss() //look up and comment this
                }
            })
        }
    }
}