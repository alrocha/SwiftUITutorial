//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alejandro Rocha on 15/04/2020.
//  Copyright © 2020 Alejandro Rocha. All rights reserved.
//

import SwiftUI

enum Constants {
    
    static let correct = "Correct"
    static let incorrect = "Incorrect, the flag which you selected is from"
}
struct ContentView: View {
    
    @State private var showingScore = false
    @State private var result = ""
    @State private var score = 0
    
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{

            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack {
                    Text("Tap the flag of").whiteStyled()
                    Text(countries[correctAnswer].capitalized).whiteStyled().font(.largeTitle).fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        
                        self.flagTapped(number)
                        
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                    }.clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1)).shadow(color: .black, radius: 2)
                }
                
                Text("CurrentScore: \(score)").fontWeight(.medium).whiteStyled()
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            
            Alert(title: Text(result),
                  
                  message: Text("Your score is \(score)"),
                  dismissButton: .default(Text("Continue")) {
                    if self.result == "Correct" {
                        self.askQuestion()
                    } else {
                        
                    }
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        
        result = (number == correctAnswer) ? Constants.correct : (Constants.incorrect + " " + countries[number].capitalized)
        
        score = (number == correctAnswer) ? score + 1 : (score == 0) ? 0 : score - 1
        
        showingScore = true
    }
    
    func askQuestion() {
        
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Text {
    
    func whiteStyled() -> Self {
        
        return self.foregroundColor(.white)
    }
}
