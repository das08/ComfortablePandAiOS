//
//  Entry.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/04/26.
//

import Foundation


struct EntryModel {
    enum EntryType {
        case Assignment
        case Quiz
        case Memo
    }
    
    var entryType: EntryType
    let entryId: String = UUID().uuidString
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

struct CourseInfo {
    var courseId: String
    var courseName: String
    
    init(courseId: String, courseName: String) {
        self.courseId = courseId
        self.courseName = courseName
    }
}
