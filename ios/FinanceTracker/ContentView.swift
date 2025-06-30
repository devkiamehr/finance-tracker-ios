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
            
            VStack(spacing: 0) {
                // Top bar with account placeholder and burger menu
                HStack {
                    // Account placeholder
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 32, height: 32)
                        Text("Account")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    // Burger menu
                    Button {
                        // Burger menu action placeholder
                    } label: {
                        VStack(spacing: 4) {
                            Rectangle()
                                .fill(.white)
                                .frame(width: 20, height: 2)
                            Rectangle()
                                .fill(.white)
                                .frame(width: 20, height: 2)
                            Rectangle()
                                .fill(.white)
                                .frame(width: 20, height: 2)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 20)
                
                Spacer()
                
                // Bottom navigation
                HStack {
                    // Home button (left)
                    Button {
                        // Home action placeholder
                    } label: {
                        Image(systemName: "house")
                            .font(.system(size: 24))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Current page (middle) - active
                    Button {
                        // Current page action placeholder
                    } label: {
                        Image(systemName: "creditcard.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // List button (right)
                    Button {
                        // List action placeholder
                    } label: {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 24))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                .background(Color.white.opacity(0.05))
            }
            
            // Balance section - positioned higher up
            VStack(spacing: 8) {
                Text("Remaining:")
                    .font(.system(size: 18).weight(.medium))
                    .foregroundStyle(.white.opacity(0.8))
                Text(balance, format: .currency(code: "USD"))
                    .font(.system(size: 28).weight(.bold))
                    .foregroundStyle(.white)
                    .shadow(color: .white.opacity(0.8), radius: 3)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 20)
            .padding(.top, 80)
            
            // Amount input display - positioned between balance and number pad
            VStack {
                Text(Double(amount) ?? 0, format: .currency(code: "USD"))
                    .font(.system(size: 60).weight(.bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 20)
            .padding(.top, 180)
            
            // Number pad - positioned in lower middle
            VStack(spacing: 25) {                 // spacing between rows
                HStack(spacing: columnSpacing) {             // row 1
                    ForEach(1...3, id: \.self) { i in
                        Button("\(i)") {
                            amount.append("\(i)")
                        }
                        .font(.system(size: 28).weight(.bold))
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                    }
                }

                HStack(spacing: columnSpacing) {             // row 2
                    ForEach(4...6, id: \.self) { i in
                        Button("\(i)") {
                            amount.append("\(i)")
                        }
                        .font(.system(size: 28).weight(.bold))
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                    }
                }

                HStack(spacing: columnSpacing) {             // row 3
                    ForEach(7...9, id: \.self) { i in
                        Button("\(i)") {
                            amount.append("\(i)")
                        }
                        .font(.system(size: 28).weight(.bold))
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                    }
                }

                // Row 4 with ".", "0", and backspace
                HStack(spacing: columnSpacing) {
                    Button(".") {
                        if !amount.contains(".") {
                            amount.append(".")
                        }
                    }
                    .font(.system(size: 28).weight(.bold))
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Circle())

                    Button("0") {
                        amount.append("0")
                    }
                    .font(.system(size: 28).weight(.bold))
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Circle())

                    Button {
                        if !amount.isEmpty {
                            amount.removeLast()
                        }
                    } label: {
                        Image(systemName: "delete.left")
                            .font(.system(size: 24).weight(.bold))
                    }
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Circle())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 160)
            
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
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color.white.opacity(0.15))
                        )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 80)   // space above the bottom navigation
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .task {
            await fetchBalance()
        }
    }
}

#Preview { ContentView() }
