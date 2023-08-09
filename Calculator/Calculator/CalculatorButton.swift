//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Ali on 2023-08-05.
//

import SwiftUI

struct CalculatorButton: View {
    var buttonText : String = "1"
    var color: Color = Color(hue: 1.0, saturation: 0.034, brightness: 0.26)
    var frameWidth : CGFloat = 70
    var frameAlignment : Alignment = .center
    var action: (CalculatorButton) -> Void = {_ in }
    var mode : CalculatorMode = .notSet
    var body: some View {
        Button{
            action(self)
        } label: {
            Text(buttonText)
                .font(.largeTitle)
                .frame(width: frameWidth, height: 70, alignment:frameAlignment)
                .background(color)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 50))
        }
    }
}
struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton()
    }
}
