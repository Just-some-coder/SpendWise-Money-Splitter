//
//  ContentView.swift
//  SpendWise
//
//  Created by Aditya Gupta on 29/06/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    
    let tipPercentages = [10,15,20,25,0]
    
    @FocusState private var amountIsFocused : Bool
    
    
    var totalPerson : Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * (tipSelection / 100)
        let grandTotal = tipValue + checkAmount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
        
    }
    
    var grandTotal : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * (tipSelection / 100)
        let grandTotal = tipValue + checkAmount
        
        return grandTotal
    }
    
    var body: some View{
        NavigationStack{
            Form{
                Section("Enter Amount"){
                    
                    TextField("Amount", value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                }
                
                
                Section{
                    
                    Picker("Number Of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                
                Section("How much tip do you want to leave?"){
                    
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0 , format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                
                Section("Amount Per Person"){
                    Text(totalPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Total Amount"){
                    Text(grandTotal,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("SpendWise")
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
            
    }
}

#Preview {
    ContentView()
}
