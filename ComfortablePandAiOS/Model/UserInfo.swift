//
//  UserInfo.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/07.
//

import Foundation
import RealmSwift

class UserInfoModel: Object, ObjectKeyIdentifiable {
    @Persisted var displayName: String
    @Persisted var morning: String
    @Persisted var midnight: String
    @Persisted var lastAccessedTime: Date?
    
    override init() {
        self.displayName = "---"
        self.lastAccessedTime = nil
    }
}

extension UserInfoModel {
    func formatLastAccessed() -> String {
        guard let lastAccessedTime = self.lastAccessedTime
        else {
            return "未取得"
        }
        
        let remain = getTimeRemain(lastAccessedTime)
        if remain.days > 0 {
            return String(format: "%d日前", arguments: [remain.days])
        }
        if remain.hour > 0 {
            return String(format: "%d時間前", arguments: [remain.hour])
        }
        return String(format: "%d分前", arguments: [remain.minute])
    }
}
