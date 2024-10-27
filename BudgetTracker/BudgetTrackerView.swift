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
            
            Spacer() //button on bottom
            
            HStack{
                NavigationLink(destination: AddExpenseView(expenses: $expenses)) {
                    Text("Add")
                        .font(.title)
                        .padding()
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(20)
                }
                .padding(.leading, 50)
                Spacer()
            }
            
        }
        .padding()
    }
}

#Preview {
    BudgetTrackerView()
}

