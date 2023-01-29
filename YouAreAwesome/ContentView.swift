//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Annie Maskill on 1/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var messageString = ""
    var body: some View {
        VStack {
            Spacer()
            
                
            Text(messageString)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundColor(.pink)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .padding()
            
            Spacer()
            
            Button("Show Message") {
                let message1 = "You Are Awesome!"
                let message2 = "You Are Great!"
                
                // this is the action performed when the button is pressed
                if messageString == message1 {
                    messageString = message2
                } else {
                    messageString = message1
                }
            }
            .buttonStyle(.borderedProminent)

            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
