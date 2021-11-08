//
//  ContentView.swift
//  iExpense
//
//  Created by Dmitry Sharabin on 08.11.2021.
//

import SwiftUI

//struct SecondView: View {
//    var body: some View {
//        Text("Second View")
//    }
//}

//struct SecondView: View {
//    let name: String
//
//    var body: some View {
//        Text("Hello, \(name)!")
//    }
//}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
//            SecondView(name: "@twostraws")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
