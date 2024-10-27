//
//  BudgetTrackerView.swift
//  BudgetTracker
//
//  Created by Blen Tesfaye on 10/22/24.
//

import SwiftUI

struct BudgetTrackerView: View {
    // A list of categories
    let categories = ["Entertainment", "Food", "Housing"]
    
    @State private var expenses: [Expense] = []
    @State private var maxBudget : Double? //not set at first
    @State private var showPopUp = false //pop up for setting budget
    @State private var limit : String = ""
    @State private var showAlert = false //show if exceed budget
    
    // State variable to hold the selected category
    @State private var selectedCategory = "Entertainment"
    
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
            
            //List the added expenses
            List(expenses) {expense in
                HStack{
                    VStack{
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
                
                Button(action: {showPopUp.toggle()}) {
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
                            checkBudget()
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
            Alert(title : Text("Budget Exceeded"), message: Text("You have exceed \(maxBudget ?? 0, specifier: "%.2f")"), dismissButton: .default(Text("Ok")))
        }
    }
    private func totalExpenses() -> Double {
        var total = 0.0
        for expense in expenses {
            total += expense.amount
        }
        return total
    }
    private func checkBudget() {
        let total = totalExpenses()
        if let limit = maxBudget, total > limit {
            showAlert = true
        }
    }
}

#Preview {
    BudgetTrackerView()
}

