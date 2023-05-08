//
//  Realm.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/08.
//

import Foundation
import RealmSwift

class RealmManager {
    var realm:Realm {
        var config = Realm.Configuration()
        config.fileURL = fileUrl
        return try! Realm(configuration: config)
    }
    
    var fileUrl: URL {
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.das08.PandAssist")!
        return url.appendingPathComponent("db.realm")
    }
}
