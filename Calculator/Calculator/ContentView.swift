//
//  ContentView.swift
//  Calculator
//
//  Created by Ali on 2023-08-05.
//

import SwiftUI

enum CalculatorMode{
    case notSet
    case addition
    case subtraction
    case multiplication
    case division
}

struct ContentView: View {
    @State var currentValue = "0"
    @State var currentMode : CalculatorMode = CalculatorMode.notSet
    @State var lastButtonWasMode = false
    @State var savedNum = 0.0
    @State var currentValueInt = 0.0
    @State var decimalPointPressed = false
    @State var negation = false
    var body: some View {
        ZStack {
            Color(.black)
            VStack {
                TotalText(value: currentValue)
                HStack {
                    CalculatorButton(buttonText: "AC",color: .gray,action: didPressClear)
                    CalculatorButton(buttonText: "+/-",color: .gray,action: didPressNegation)
                    CalculatorButton(buttonText: "%",color: .gray,action: didPressMode)
                    CalculatorButton(buttonText: "÷", color: .orange,action: didPressMode, mode: .division)
                }
                HStack {
                    CalculatorButton(buttonText: "1",action: didPressNumber)
                    CalculatorButton(buttonText: "2",action: didPressNumber)
                    CalculatorButton(buttonText: "3",action: didPressNumber)
                    CalculatorButton(buttonText: "x", color: .orange, action: didPressMode, mode: .multiplication)
                }
                HStack {
                    CalculatorButton(buttonText: "4",action: didPressNumber)
                    CalculatorButton(buttonText: "5",action: didPressNumber)
                    CalculatorButton(buttonText: "6",action: didPressNumber)
                    CalculatorButton(buttonText: "-", color: .orange,action: didPressMode, mode: .subtraction)
                }
                HStack {
                    CalculatorButton(buttonText: "7",action: didPressNumber)
                    CalculatorButton(buttonText: "8",action: didPressNumber)
                    CalculatorButton(buttonText: "9",action: didPressNumber)
                    CalculatorButton(buttonText: "+", color: .orange,action: didPressMode, mode: .addition)
                }
                HStack {
                    CalculatorButton(buttonText: "0",frameWidth: 148,action: didPressNumber)
                    CalculatorButton(buttonText: ".",action: didPressDecimalPoint)
                    CalculatorButton(buttonText: "=", color: .orange,action: didPressEquals)
                }
            }
        }.ignoresSafeArea()
    }
    func didPressNumber(button: CalculatorButton){
        if lastButtonWasMode {
            lastButtonWasMode = false
            currentValueInt = 0
        }
        if decimalPointPressed {
            // Handle decimal point input
            currentValueInt = currentValueInt + (Double(button.buttonText) ?? 0.0) * 0.1
            updateText()
        } else {
            // Handle regular number input
            currentValueInt = currentValueInt * 10 + (Double(button.buttonText) ?? 0.0)
            updateText()
        }
    }
    func didPressDecimalPoint(button: CalculatorButton) {
        // Allow decimal point input only if it hasn't been pressed yet
        if !decimalPointPressed {
            decimalPointPressed = true
        }
    }
    func didPressNegation(button: CalculatorButton) {
        negation.toggle()
        updateText()
    }
    func didPressMode(button: CalculatorButton){
        currentMode = button.mode
        lastButtonWasMode = true
        decimalPointPressed = false
        negation = false
    }
    func didPressClear(button: CalculatorButton){
        currentValue = "0"
        currentMode = .notSet
        savedNum = 0
        currentValueInt = 0
        decimalPointPressed = false
        negation = false
    }
    func didPressEquals(button: CalculatorButton){
        if currentMode == .notSet || lastButtonWasMode {
            return
        }
        let currentValueToUse = negation ? -currentValueInt : currentValueInt // Apply negation if needed
            if currentMode == .addition {
                savedNum += currentValueToUse
            } else if currentMode == .subtraction {
                savedNum -= currentValueToUse
            } else if currentMode == .multiplication {
                savedNum *= currentValueToUse
            } else if currentMode == .division {
                savedNum /= currentValueToUse
            }
        currentValueInt = savedNum
        updateText()
        lastButtonWasMode = true
        decimalPointPressed = false
        negation = false
    }
        
    func updateText(){
        if currentMode == .notSet {
            if negation {
                savedNum = currentValueInt * (-1)
            }else{
                savedNum = currentValueInt
            }
        }
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        let num = NSNumber(value: negation ? -currentValueInt : currentValueInt)
        currentValue = numberFormater.string(from: num) ?? "Error"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
