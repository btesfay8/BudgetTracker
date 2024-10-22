//
//  ContentView.swift
//  BudgetTracker
//
//  Created by Blen Tesfaye on 10/15/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: BudgetTrackerView()) {
                    Text("Welcome to the Budget Tracker App")
                        .frame(width: 250, height: 500, alignment: .center)
                        .background(Color.orange)
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        .font(.title3)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
