//
//  ContentView.swift
//  xpcBasedUppercase
//
//  Created by Anubhav Gain on 14/03/24.
//

import SwiftUI

// Define color constants
let primaryColor = Color(red: 0.2, green: 0.6, blue: 0.9)
let secondaryColor = Color(red: 0.9, green: 0.9, blue: 0.9)

struct ContentView: View {
    
    @State private var inputText: String = ""
    @State private var upperText: String = ""
    @State private var buttonScaleAmount: CGFloat = 1.0
    
    let xpcClient: XPCClientProtocol
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter a text...", text: $inputText)
                .font(.custom("Avenir Next", size: 50))
                .background(secondaryColor)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(primaryColor, lineWidth: 2)
                )
                .padding()
            
            HStack(spacing: 10) {
                Spacer()
                
                Button("Uppercase it!") {
                    xpcClient.uppercase(for: inputText) { result in
                        DispatchQueue.main.async {
                            upperText = result
                        }
                    }
                    withAnimation(.spring()) {
                        buttonScaleAmount = 0.9
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        buttonScaleAmount = 1.0
                    }
                }
                .buttonStyle(.plain)
                .font(.custom("Avenir Next", size: 20))
                .bold()
                .padding()
                .background(primaryColor)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 1)
                )
                .padding()
                .scaleEffect(buttonScaleAmount)
                .animation(.spring(), value: buttonScaleAmount)
                
                Spacer()
                
                if upperText.count > 0 {
                    HStack {
                        Label("Result:", systemImage: "bolt.fill")
                            .font(.system(size: 30))
                            .labelStyle(.iconOnly)
                        Text(upperText)
                            .font(.system(size: 30))
                            .padding()
                    }
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockedXPC = MockedXPCCLient()
        ContentView(xpcClient: mockedXPC)
    }
}
