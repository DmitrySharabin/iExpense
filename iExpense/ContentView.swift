//
//  ContentView.swift
//  iExpense
//
//  Created by Dmitry Sharabin on 08.11.2021.
//

import SwiftUI

struct ContentView: View {
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCount = 0
//    @AppStorage("Tap") private var tapCount = 0
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
//            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
