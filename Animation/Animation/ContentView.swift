//
//  ContentView.swift
//  Animation
//
//  Created by Joaquin Castrillon on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    let letters = Array("Hello SwiftUI")


    
    var body: some View {
        
        /* rotation 3D Effect
        VStack{
            Button("Tap Me") {
                // do nothing
                withAnimation(.spring(duration: 1, bounce: 0.5)){
                    animationAmount += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(.degrees(animationAmount), axis:(x: 0, y: 1, z: 0 )
        }
        */
        
        /*   Animation with buttons on clipShape effect
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .animation(nil, value: enabled)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
        
        Button("Tap Me") {
            
        }
        .frame(width: 200, height: 200)
        .background(.blue)
        .foregroundStyle(.white)
         */
        
        HStack(spacing: 0) {
                    ForEach(0..<letters.count, id: \.self) { num in
                        Text(String(letters[num]))
                            .padding(5)
                            .font(.title)
                            .background(enabled ? .blue : .red)
                            .offset(dragAmount)
                            .animation(.linear.delay(Double(num) / 20), value: dragAmount)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { _ in
                            dragAmount = .zero
                            enabled.toggle()
                        }
                )

    }
}

#Preview {
    ContentView()
}
