//
//  RequirementText.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 21.5.22..
//

import SwiftUI

struct RequirementText: View {
    
    var iconName = "xmark.square"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)
    
    var text = ""
    var isStrikeThrough = false
    var foregroundColor = Color.secondary
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(foregroundColor)
                .strikethrough(isStrikeThrough)
                .minimumScaleFactor(0.1)
            Spacer()
        }
    }
}
