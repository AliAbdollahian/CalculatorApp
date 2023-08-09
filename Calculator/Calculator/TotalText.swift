//
//  TotalText.swift
//  Calculator
//
//  Created by Ali on 2023-08-05.
//

import SwiftUI

struct TotalText: View {
    var value : String = "0"
    var body: some View {
        Text(value)
            .font(.system(size: 60))
            .fontWeight(.light)
            .padding()
            .foregroundColor(.white)
            .lineLimit(1)
    }
}

struct TotalText_Previews: PreviewProvider {
    static var previews: some View {
        TotalText()
            .background(.black)
    }
}
