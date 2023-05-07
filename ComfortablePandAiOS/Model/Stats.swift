//
//  Stats.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/07.
//

import Foundation

struct StatsModel {
    var userName: String
    var lastAccessedTime: Date
}

extension StatsModel {
    func formatLastAccessed() -> String {
        var remain = getTimeRemain(self.lastAccessedTime)
        if remain.days > 0 {
            return String(format: "%d日前", arguments: [remain.days])
        }
        if remain.hour > 0 {
            return String(format: "%d時間前", arguments: [remain.hour])
        }
        return String(format: "%d分前", arguments: [remain.minute])
    }
}
