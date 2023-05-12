//
//  SakaiResponse.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/11.
//

import Foundation

struct SakaiAssignmentCollection: Codable {
    let assignment_collection: [SakaiAssignmentEntry]
}

struct SakaiAssignmentEntry: Codable, Identifiable {
    let context: String
    let id: String
    let title: String
    let dueTime: SakaiEntryDueTime
    let openTime: SakaiEntryOpenTime
    let instructions: String
}

struct SakaiEntryDueTime: Codable {
    let epochSecond: Int
}

struct SakaiEntryOpenTime: Codable {
    let epochSecond: Int
}
