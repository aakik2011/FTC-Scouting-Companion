//
//  TestView.swift
//  FTC Scout - Simple test view for macOS debugging
//

import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("FTC Scout - macOS Test")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("If you can see this, the app is running on macOS!")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Button("Test Button") {
                    print("Button tapped successfully!")
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink("Navigation Test", destination: Text("Navigation Works!"))
                    .buttonStyle(.bordered)
            }
            .padding()
            .navigationTitle("Test")
        }
    }
}

#Preview {
    TestView()
}