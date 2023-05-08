//
//  WidgetMainView.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/06.
//

import SwiftUI
import RealmSwift

struct WidgetView: View {
    @Environment(\.realm) var realm
    let manager = RealmManager()
    @ObservedResults(EntryModel.self,configuration: Realm.Configuration(fileURL:RealmManager().fileUrl)) var entries
    
    var body: some View {
        VStack(alignment:.leading ,spacing: 0){
            Spacer()
                .frame(height:8)
            WidgetHeaderView(updatedTime: "2021/05/06 12:00")
            Spacer()
                .frame(height:15)
            VStack(alignment:.leading, spacing:5){
                ForEach(entries){entry in
                    
                    let time = getTimeRemain(entry.dueDate)
                    let daysUntil = getDaysUntil(dueDate: entry.dueDate)
                    
                    VStack(alignment:.leading, spacing:0){
                        VStack(alignment:.leading, spacing:5){
                            HStack(spacing:0){
                                Text(entry.getCourseName())
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 3)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(getBadgeColor(dueDate: entry.dueDate))
                                    )
                                    .padding(.horizontal, 5)
                                Text(dispRemainTime(time: time))
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 100/255 , green: 100/255, blue: 100/255))
                                
                            }
                            HStack(alignment: .center, spacing: 0){
                                Text(entry.title)
                                    .font(.system(size: 13))
                                    .lineLimit(1)
                                    .padding(.leading)
                                    .padding(.bottom,5)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        Spacer()
    }
}

struct WidgetHeaderView: View {
    let updatedTime: String
    init(updatedTime: String) {
        self.updatedTime = updatedTime
    }

    var body: some View {
        VStack(alignment:.leading ,spacing: 15) {
            HStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, alignment: .center)
                    .padding(.leading, 5)
                    .padding(.trailing, 16)
                Spacer()
                Text("取得：\(updatedTime)")
                    .font(.system(size: 14))
                    .padding(16)
            }.frame(height: 40, alignment: .topLeading)
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}
