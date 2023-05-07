//
//  dates.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/06.
//

import Foundation

struct RemainTime: Codable {
    let days: Int
    let hour: Int
    let minute: Int
}

func getTimeRemain(_ dueDate: Date) -> RemainTime {
    let currentDate = Date()
    let timeDiff = dueDate-currentDate
    let days = floor(Double(timeDiff.second!) / (3600 * 24))
    let hours = floor((Double(timeDiff.second!) - (days * 3600 * 24)) / 3600)
    let minutes = floor((Double(timeDiff.second!) - (days * 3600 * 24 + hours * 3600)) / 60)
    return RemainTime(days: Int(days), hour: Int(hours), minute: Int(minutes))
}

func getDaysUntil(dueDate: Date) -> Int {
    let currentDate = Date()
    let timeDiff = dueDate-currentDate
    var daysUntil: Int
    
    switch timeDiff.second! {
    case 0...:
        daysUntil = (timeDiff.second! + (3600 * 24) - 1) / (3600 * 24)
    default:
        daysUntil = -1
    }
    return daysUntil
}

func formatDate(date: Date) -> String {
    let df = DateFormatter()
    df.dateFormat = "yyyy/MM/dd HH:mm"
    return df.string(from: date)
}

func dispRemainTime(time: RemainTime) -> String {
    var remainTime: String
    
    if time.days < 0 {
        remainTime = "終了"
    }else {
        remainTime = "あと\(time.days)日\(time.hour)時間\(time.minute)分"
    }

    return remainTime
}

extension Date {
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
}
