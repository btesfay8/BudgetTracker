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
}