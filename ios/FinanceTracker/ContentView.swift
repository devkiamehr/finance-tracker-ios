//
//  ContentView.swift
//  Finance Tracker
//
//  Created by Kiamehr on 6/26/25.
//

import SwiftUI

struct ContentView: View {
    @State private var balance: Double = 150
    @State private var amount: String = ""

    private let columnSpacing: CGFloat = 55    // horizontal space between keys
    private let rowSpacing: CGFloat = 40       // vertical space between rows

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 24) {
                // “$1,234.56” with modern formatter
                Text("Remaining:")
                    .font(.system(size: 20).weight(.bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(balance, format: .currency(code: "USD"))
                    .font(.system(size: 35).weight(.bold))
                    .foregroundStyle(.white)
                    .shadow(color: .white.opacity(0.8), radius: 10)
                    .shadow(color: .white.opacity(0.4), radius: 20)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 20)
            .padding(.vertical, 25)
            
            VStack {
                Text(Double(amount) ?? 0, format: .currency(code: "USD"))
                    .font(.system(size: 75).weight(.bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 20)
            .padding(.vertical, 130)
            
            // Number pad
            VStack(spacing: rowSpacing) {                 // vertical spacing between rows
                HStack(spacing: columnSpacing) {             // row 1
                    ForEach(1...3, id: \.self) { i in
                        Button("\(i)") {
                            amount.append("\(i)")
                        }
                        .font(.system(size: 30).weight(.bold))
                        .foregroundStyle(.white)
                        .frame(width: 50)
                    }
                }

                HStack(spacing: columnSpacing) {             // row 2
                    ForEach(4...6, id: \.self) { i in
                        Button("\(i)") {
                            amount.append("\(i)")
                        }
                        .font(.system(size: 30).weight(.bold))
                        .foregroundStyle(.white)
                        .frame(width: 50)
                    }
                }

                HStack(spacing: columnSpacing) {             // row 3
                    ForEach(7...9, id: \.self) { i in
                        Button("\(i)") {
                            amount.append("\(i)")
                        }
                        .font(.system(size: 30).weight(.bold))
                        .foregroundStyle(.white)
                        .frame(width: 50)
                    }
                    .padding(.top, rowSpacing / 2)
                }

                // Row 4 with ".", "0", and backspace
                HStack(spacing: columnSpacing) {
                    Button(".") {
                        if !amount.contains(".") {
                            amount.append(".")
                        }
                    }
                    .font(.system(size: 30).weight(.bold))
                    .foregroundStyle(.white)
                    .frame(width: 50)

                    Button("0") {
                        amount.append("0")
                    }
                    .font(.system(size: 30).weight(.bold))
                    .foregroundStyle(.white)
                    .frame(width: 50)

                    Button {
                        if !amount.isEmpty {
                            amount.removeLast()
                        }
                    } label: {
                        Image(systemName: "delete.left")
                            .font(.system(size: 30).weight(.bold))
                    }
                    .foregroundStyle(.white)
                    .frame(width: 50)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 150)
            
            HStack {
                Button("Pay") {
                    if let value = Double(amount) {
                        balance -= value
                        amount = ""
                    }
                }
            } 
        }
    }
}

#Preview { ContentView() }
