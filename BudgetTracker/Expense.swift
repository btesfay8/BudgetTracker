//
//  Expense.swift
//  BudgetTracker
//
//  Created by Bria Williams on 10/22/24.
//

import Foundation

struct Expense : Identifiable {
    let id = UUID()
    var name : String
    var amount: Double
    var category: String
}