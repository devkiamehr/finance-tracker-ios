//
//  ContentView.swift
//  Finance Tracker
//
//  Created by Kiamehr on 6/26/25.
//

import SwiftUI

struct ContentView: View {
    @State private var balance: Double = 0
    @State private var amount: String = ""
    private let budgetURL = URL(string: "http://localhost:3000/api/budget/get")!
    // POST endpoint to decrement the user's budget
    private let budgetPostURL = URL(string: "http://localhost:3000/api/budget/patch")!

    private let columnSpacing: CGFloat = 55    // horizontal space between keys
    private let rowSpacing: CGFloat = 40       // vertical space between rows

    @MainActor
    private func fetchBalance() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: budgetURL)
            if let str = String(data: data, encoding: .utf8) {
                // Convert the string response directly to Double
                balance = Double(str.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0.0
            }
        } catch {
            print("Error fetching balance:", error)
        }
    }

    @MainActor
    private func pay(amount value: Double) async {
        var request = URLRequest(url: budgetPostURL)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Double] = ["amount": value]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let str = String(data: data, encoding: .utf8) {
                // Update balance with the new value returned from the server
                balance = Double(str.trimmingCharacters(in: .whitespacesAndNewlines)) ?? balance
            }
            // Clear the amount after successful payment
            amount = ""
        } catch {
            print("Error posting payment:", error)
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 24) {
                // "$1,234.56" with modern formatter
                Text("Remaining:")
                    .font(.system(size: 20).weight(.bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(balance, format: .currency(code: "USD"))
                    .font(.system(size: 35).weight(.bold))
                    .foregroundStyle(.white)
                    .shadow(color: .white.opacity(0.8), radius: 5)
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
            
            // Full-width "Pay" button – styled like the mock-up
            VStack {
                Button {
                    if let value = Double(amount) {
                        Task {
                            await pay(amount: value)
                        }
                    }
                } label: {
                    Text("Pay")
                        .font(.system(size: 20, weight: .bold))
                        .frame(maxWidth: .infinity, minHeight: 55)
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(Color.white.opacity(0.12))
                        )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)   // space above the home indicator
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .task {
            await fetchBalance()
        }
    }
}

#Preview { ContentView() }
