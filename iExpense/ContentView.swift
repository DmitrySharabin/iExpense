//
//  ContentView.swift
//  iExpense
//
//  Created by Dmitry Sharabin on 08.11.2021.
//

import SwiftUI

extension Collection {
    var isNotEmpty: Bool {
        !self.isEmpty
    }
}

struct AmountView: View {
    let amount: Double
    
    var color: Color {
        if amount < 10 {
            return .green
        } else if amount < 100 {
            return .yellow
        } else {
            return .red
        }
    }
    
    var body: some View {
        Text(amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
            .padding(5)
            .background(color.opacity(0.3))
            .foregroundColor(.black.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    private var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    private var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    
    var body: some View {
        NavigationView {
            List {
                if personalExpenses.isNotEmpty {
                    Section("Personal Expenses") {
                        ForEach(personalExpenses) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                }
                                
                                Spacer()
                                
                                AmountView(amount: item.amount)
                            }
                            .accessibilityElement()
                            .accessibilityLabel("\(item.name), \(item.amount)")
                            .accessibilityHint("Personal expense")
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, type: "Personal")
                        }
                    }
                }
                
                if businessExpenses.isNotEmpty {
                    Section("Business Expenses") {
                        ForEach(businessExpenses) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                }
                                
                                Spacer()
                                
                                AmountView(amount: item.amount)
                            }
                            .accessibilityElement()
                            .accessibilityLabel("\(item.name), \(item.amount)")
                            .accessibilityHint("Business expense")
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, type: "Business")
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, type: String) {
        guard type == "Business" || type == "Personal" else { return }
        
        let items = type == "Business" ? businessExpenses : personalExpenses
        
        for offset in offsets {
            let item = items[offset]
            
            if let index = expenses.items.firstIndex(where: { $0.id == item.id }) {
                expenses.items.remove(at: index)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
