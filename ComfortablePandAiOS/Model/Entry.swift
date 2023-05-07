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
    var dueDate: Date
    var hasFinished: Bool
    var isNew: Bool
    
    init(entryType: EntryType, courseInfo: CourseInfo, title: String, description: String, dueDate: Date, hasFinished: Bool, isNew: Bool) {
        self.entryType = entryType
        self.courseInfo = courseInfo
        self.title = title
        self.dueDate = dueDate
        self.description = description
        self.hasFinished = hasFinished
        self.isNew = isNew
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

struct DemoEntry {
    private static let days14 = Calendar.current.date(byAdding: .day, value: 14, to: Date())!
    private static let days5 = Calendar.current.date(byAdding: .day, value: 5, to: Date())!
    private static let hours24 = Calendar.current.date(byAdding: .hour, value: 24, to: Date())!
    static var entries = [
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", description: "課題1の詳細", dueDate: hours24, hasFinished: false, isNew: true),
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", description: "課題1の詳細", dueDate: days5, hasFinished: false, isNew: true),
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", description: "課題1の詳細", dueDate: days14, hasFinished: false, isNew: true),
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", description: "課題1の詳細", dueDate: days14, hasFinished: false, isNew: true)
    ]
}

