//
//  ContentView.swift
//  BetterRest
//
//  Created by Joaquin Castrillon on 10/21/23.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var body: some View {
        NavigationStack {
            Form {
                
                VStack {
                    Text("When do you want to wake up")
                        .font(.headline)
                    
                    DatePicker("Please enter a time",
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute)
                    .labelsHidden()
                }
                
                
                VStack {
                    Text("Desire amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours",
                            value: $sleepAmount,
                            in: 4...12)
                }
                VStack {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Stepper("\(coffeeAmount) cup(s)", value: $coffeeAmount, in:1...20)
                }
                
                
                
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
                
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message:{
                Text(alertMessage)
            }
        }
        
    }
    func calculateBedtime(){
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0 ) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeeAmount)))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertMessage = "Your ideal bedtime is " + sleepTime.formatted(date: .omitted, time:.shortened)
            
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry"
        }
        showingAlert = true
    }
}





#Preview {
    ContentView()
    
    
    
}
