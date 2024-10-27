//
//  MaxBudgetView.swift
//  BudgetTracker
//
//  Created by Bria Williams on 10/27/24.
//

import SwiftUI

struct MaxBudgetView: View {
    @Binding var maxBudget: Double?
    @State private var amount: String = ""
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Set Budget")) {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Budget Limit")
            
        }
    }
}

#Preview {
    MaxBudgetView(maxBudget: .constant(nil))
}
