//
//  EntryView.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/04/26.
//

import SwiftUI

struct EntryView: View {
    @ObservedObject var entry: EntryModel
    var body: some View {
        ZStack(alignment: .topLeading) {
//            CourseNameView()
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    CourseNameView(entry: entry)
                    Spacer()
                    DeadlineView(dueDate: entry.dueDate)
                }
                .offset(x:-5)
                .offset(y:-5)
                HStack(alignment: .center) {
                    CheckBoxView(checked: $entry.hasFinished)
                        .onTapGesture {
                            if entry.hasFinished {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    entry.hasFinished.toggle()
                                }
                            } else {
                                withAnimation {
                                    entry.hasFinished.toggle()
                                }
                            }
                        }
                    EntryTitleView(title: entry.title)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding(2)
//        .background(Rectangle().fill(Color.white))
//        .cornerRadius(10)
//        .shadow(color: .gray, radius: 1, x: 1, y: 1)
    }
}

struct CourseNameView: View {
    var entry: EntryModel
    var body: some View {
        Text(entry.courseInfo.courseName)
            .font(.system(size: 15))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(getBadgeColor(dueDate: entry.dueDate))
            )
    }
}

struct CheckBoxView: View {
    @Binding var checked: Bool
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: self.checked ? 1:0)
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: 35, height: 35)
                .foregroundColor(self.checked ? .green : .gray)
                .overlay(
                    Circle()
                        .fill(self.checked ? .green : .gray.opacity(0.2))
                        .frame(width: 28, height: 28)
                )
            if checked {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
            }
        }
    }
}

struct DeadlineView: View {
    @State var showDueDate: Bool = true
    var dueDate: Date
    var body: some View {
        Text(formatDate(date: dueDate))
            .font(.system(size: 15))
            .fontWeight(.bold)
            .foregroundColor(Color(red: 176/255 , green: 17/255, blue: 16/255))
    }
}

struct EntryTitleView: View {
    var title: String
    var body: some View {
        Text(title)
    }
}


struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(entry: EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", description: "課題1の詳細", dueDate: Date(), hasFinished: false, isNew: true))
    }
}
