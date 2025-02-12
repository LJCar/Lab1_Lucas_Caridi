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
    @State private var timer: Timer?
    @State private var showDialog = false

    
    var body: some View {
        ZStack {
            if isQuizActive{
                Text("\(number)")
                    .font(.largeTitle).fontWeight(.heavy)
                    .padding()
                HStack{
                    Button(action: {checkAnswer(answer: true)}, label: {
                        Text("PRIME").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    })
                    .padding().background(.blue).foregroundColor(.black).cornerRadius(5)
                    Button(action: {checkAnswer(answer: false)}, label: {
                        Text("NOT PRIME").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    })
                    .padding().background(.black).foregroundColor(.red).cornerRadius(5)
                }
                
                Text(result).font(.headline).padding()
            }
            VStack{
                Button(action: {toggleQuiz()}, label: {
                    Text(isQuizActive ? "Stop Prime Quiz" : "Start Prime Quiz")
                })
                .font(.largeTitle)
                .padding()
                .background(isQuizActive ? Color.red : Color.green)
                .foregroundColor(isQuizActive ? Color.black : Color.white)
                .cornerRadius(5)
                .padding()
            }
        }
        .alert("Quiz Completed!", isPresented: $showDialog) {
            Button("OK") {
                correct = 0
                wrong = 0
                isQuizActive = false
            }
        } message: {
            Text("\u{2705} Correct: \(correct)")
            Text("\u{274C} Wrong: \(wrong)")
        }
    }
    
    func toggleQuiz() {
        isQuizActive.toggle()
        if isQuizActive {
            number = Int.random(in: 1...100)
            result = ""
            correct = 0
            wrong = 0
            quizTimer()
        }
        else {
            timer?.invalidate()
        }
    }
    
    func isPrime(_ num: Int) -> Bool {
        for i in 2..<num {
            if num % i == 0 {
                return false
            }
        }
        return true
        
    }
    
    func checkAnswer(answer: Bool) {
        let isCorrect = answer == isPrime(number)
        if isCorrect {
            result = "\u{2705}"
            correct += 1
        }
        else {
            result = "\u{274C}"
            wrong += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            updateGame()
        }
    }
    
    func updateGame() {
        if correct + wrong == 10 {
            showDialog = true
        }
        else {
            number = Int.random(in: 1...100)
            result = ""
            quizTimer()
        }
    }
    
    func quizTimer(){
        timer?.invalidate()
        if isQuizActive {
            timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in wrong += 1
                result = "\u{274C} OUT OF TIME!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    updateGame()
                }
            }
        }
    }
}













#Preview {
    ContentView()
}
