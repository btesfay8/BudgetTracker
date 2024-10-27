//
//  BudgetTrackerView.swift
//  BudgetTracker
//
//  Created by Blen Tesfaye on 10/22/24.
//

import SwiftUI

struct BudgetTrackerView: View {
    // A list of categories
    let categories = ["Food", "Entertainment", "Housing", "Transportation", "Misc"]
    
    @State private var expenses: [Expense] = [] // List of all expenses
    @State private var maxBudget: Double? // Not set at first
    @State private var showPopUp = false // Pop-up for setting budget
    @State private var limit: String = "" // Holds the budget limit input
    @State private var showAlert = false // Show if budget exceeded
    
    // State variable to hold the selected category
    @State private var selectedCategory = "Entertainment"
    
    // Function to filter expenses by selected category
    var filteredExpenses: [Expense] {
        expenses.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        VStack {
            Text("Select a Category")
                .font(.title)
                .padding()
            
            // Dropdown menu (Picker)
            Picker("Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category).tag(category)
                }
            }
            .pickerStyle(MenuPickerStyle()) // This makes it a dropdown menu
            
            // Display the selected category
            Text("Selected Category: \(selectedCategory)")
                .font(.headline)
                .padding()
            
            // List of filtered expenses
            List(filteredExpenses) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.headline)
                        Text(expense.category)
                            .font(.subheadline)
                    }
                    Spacer()
                    Text("\(expense.amount, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer() //Add button on bottom
            
            HStack{
                NavigationLink(destination: AddExpenseView(expenses: $expenses, expenseAdded: checkBudget)) {
                    Text("Add")
                        .font(.title)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 40)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(20)
                }
                .padding(.leading, 20)

                Spacer()

                Button(action: { showPopUp.toggle() }) {
                    Text("Set Limit")
                        .font(.title)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 40)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(20)
                }
            }

        }
        .padding()
        .sheet(isPresented: $showPopUp) {
            // Pop-up to set the budget limit
            VStack {
                Text("Set Budget Limit")
                    .font(.headline)
                    .padding()
                TextField("Amount", text: $limit)
                    .keyboardType(.decimalPad)
                    .padding()
                HStack {
                    Button("Save") {
                        if let limitVal = Double(limit) {
                            maxBudget = limitVal
                            limit = ""
                            showPopUp = false
                            checkBudget() // Ensure the budget is checked after saving
                        }
                    }
                    .padding()
                    Button("Cancel") {
                        showPopUp = false
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Budget Exceeded"),
                  message: Text("You have exceeded your budget of \(maxBudget ?? 0, specifier: "%.2f")"),
                  dismissButton: .default(Text("Ok")))
        }
    }
    
    // Function to calculate total expenses
    private func totalExpenses() -> Double {
        return expenses.reduce(0) { $0 + $1.amount }
    }
    
    // Function to check if the total expenses exceed the budget
    private func checkBudget() {
        let total = totalExpenses()
        if let limit = maxBudget, total > limit {
            showAlert = true
        } else {
            showAlert = false // Reset alert if within budget
        }
    }
}

#Preview {
    BudgetTrackerView()
}

