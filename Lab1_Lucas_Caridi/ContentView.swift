//
//  ContentView.swift
//  Lab1_Lucas_Caridi
//
//  Created by Lucas Caridi on 2025-02-11.
//

import SwiftUI

struct ContentView: View {
    @State private var number: Int = Int.random(in: 1...100)
    @State private var isQuizActive = false
    @State private var result: String = ""
    @State private var correct = 0
    @State private var wrong = 0

    
    var body: some View {
        ZStack {
            VStack{
                Button(action: {toggleQuiz()}, label: {
                    Text(isQuizActive ? "Stop Prime Quiz" : "Start Prime Quiz")
                })
                .font(.largeTitle)
                .padding()
                .background(isQuizActive ? Color.red : Color.green)
                .foregroundColor(.white)
                .cornerRadius(5)
                .padding()
            }
        }
    }
    
    func toggleQuiz() {
        isQuizActive.toggle()
        if isQuizActive {
            number = Int.random(in: 1...100)
            result = ""
            correct = 0
            wrong = 0
        }
    }
}













#Preview {
    ContentView()
}
