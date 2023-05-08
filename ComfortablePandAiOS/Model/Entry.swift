//
//  Entry.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/04/26.
//

import Foundation
import RealmSwift

class EntryModel: Object, ObjectKeyIdentifiable {
    enum EntryType: String, CaseIterable, PersistableEnum {
        case Assignment
        case Quiz
        case Memo
    }
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var entryType: EntryType
    @Persisted var courseInfo: CourseInfo?
    @Persisted var title: String
    @Persisted var detail: String
    @Persisted var dueDate: Date
    @Persisted var hasFinished: Bool
    @Persisted var isNew: Bool
    
    init(entryType: EntryType, courseInfo: CourseInfo, title: String, detail: String, dueDate: Date, hasFinished: Bool, isNew: Bool) {
        self.entryType = entryType
        self.courseInfo = courseInfo
        self.title = title
        self.dueDate = dueDate
        self.detail = detail
        self.hasFinished = hasFinished
        self.isNew = isNew
        super.init()
    }
    
    required override init() {
        super.init()
    }
    
    func getCourseName() -> String {
        guard let courseName = courseInfo?.courseName
        else {
            return "---"
        }
        return courseName
    }
}

class CourseInfo: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var courseID: String
    @Persisted var courseName: String
    
    init(id: String, courseName: String) {
        self.courseID = id
        self.courseName = courseName
        super.init()
    }
    
    required override init() {
        super.init()
    }
}

struct DemoEntry {
    private static let days14 = Calendar.current.date(byAdding: .day, value: 14, to: Date())!
    private static let days5 = Calendar.current.date(byAdding: .day, value: 5, to: Date())!
    private static let hours24 = Calendar.current.date(byAdding: .hour, value: 24, to: Date())!
    static var entries = [
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", detail: "課題1の詳細", dueDate: hours24, hasFinished: false, isNew: true),
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", detail: "課題1の詳細", dueDate: days5, hasFinished: false, isNew: true),
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", detail: "課題1の詳細", dueDate: days14, hasFinished: false, isNew: true),
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", detail: "課題1の詳細", dueDate: days14, hasFinished: false, isNew: true)
    ]
}

