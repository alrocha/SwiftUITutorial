//
//  ContentView.swift
//  WeSplit
//
//  Created by Alejandro Rocha on 29/03/2020.
//  Copyright © 2020 Alejandro Rocha. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    
    var totalAmountPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderTotal = Double(checkAmount) ?? 0
        let tipValue = orderTotal / 100 * tipSelection
        
        return (orderTotal + tipValue) / (peopleCount ?? 1.0)
    }
    
    var totalBillAmount: Double {
        
        let billAmount = Double(checkAmount) ?? 0
        
        return billAmount + (billAmount / 100 * Double(tipPercentages[tipPercentage]))
    }
    
    let tipPercentages = [10, 15 ,20 ,25 ,0]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
                    
                    TextField("Number of people", text: $numberOfPeople).keyboardType(.numberPad)
                }
                
                
                Section(header: Text("How much percentage")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0]) %")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalAmountPerPerson, specifier: "%.2f")").bold()
                }
                
                Section(header: Text("Detached bill")) {
                    
                    Text("Total amount: \(checkAmount)")
                    Text("Total tip: \(tipPercentages[tipPercentage])%")
                    Text("$\(totalBillAmount, specifier: "%.2f")").bold()
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
