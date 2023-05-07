//
//  colors.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/06.
//

import SwiftUI

struct miniPandAColor {
    let background: Color = Color(red: 200/255 , green: 200/255, blue: 200/255)
}

struct DueDateColor {
    let red: Color = Color(red: 232/255 , green: 85/255, blue: 85/255)
    let yellow: Color = Color(red: 215/255 , green: 170/255, blue: 81/255)
    let green: Color = Color(red: 98/255 , green: 182/255, blue: 101/255)
    let gray: Color = Color(red: 119/255 , green: 119/255, blue: 119/255)
    let black: Color = Color(red: 10/255 , green: 10/255, blue: 10/255)
}

func getBadgeColor(dueDate: Date) -> Color {
    let badgeColor: Color
    let dueColor = DueDateColor()
    
    let days = getTimeRemain(dueDate).days
    
    switch days {
    case ..<0:
        badgeColor = dueColor.black
    case 0...1:
        badgeColor = dueColor.red
    case 2...5:
        badgeColor = dueColor.yellow
    case 6...14:
        badgeColor = dueColor.green
    default:
        badgeColor = dueColor.gray
    }
    return badgeColor
}
