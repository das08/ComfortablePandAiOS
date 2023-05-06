//
//  Entry.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/04/26.
//

import Foundation


struct EntryModel: Identifiable {
    enum EntryType {
        case Assignment
        case Quiz
        case Memo
    }
    
    var entryType: EntryType
    let id: String = UUID().uuidString
    var courseInfo: CourseInfo
    var title: String
    var description: String
    var hasFinished: Bool
    var isNew: Bool = false
    
    init(entryType: EntryType, courseInfo: CourseInfo, title: String, description: String, hasFinished: Bool) {
        self.entryType = entryType
        self.courseInfo = courseInfo
        self.title = title
        self.description = description
        self.hasFinished = hasFinished
    }
    
    mutating func toggleHasFinished() {
        self.hasFinished.toggle()
    }
}

struct CourseInfo: Identifiable {
    var id: String
    var courseName: String
    
    init(id: String, courseName: String) {
        self.id = id
        self.courseName = courseName
    }
}
