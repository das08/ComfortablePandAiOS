//
//  Stats.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/07.
//

import Foundation
import RealmSwift

class StatsModel: Object, ObjectKeyIdentifiable {
    @Persisted var userName: String
    @Persisted var lastAccessedTime: Date?
    
    override init() {
        self.userName = "---"
        self.lastAccessedTime = nil
    }
}

extension StatsModel {
    func formatLastAccessed() -> String {
        guard let lastAccessedTime = self.lastAccessedTime
        else {
            return "未取得"
        }
        
        var remain = getTimeRemain(lastAccessedTime)
        if remain.days > 0 {
            return String(format: "%d日前", arguments: [remain.days])
        }
        if remain.hour > 0 {
            return String(format: "%d時間前", arguments: [remain.hour])
        }
        return String(format: "%d分前", arguments: [remain.minute])
    }
}
