//
//  Expenses.swift
//  iExpense
//
//  Created by Dmitry Sharabin on 09.11.2021.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
