//
//  EntryView.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/04/26.
//

import SwiftUI

struct EntryView: View {
    @State var checked: Bool
    var body: some View {
        ZStack(alignment: .topLeading) {
            CourseNameView()
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    CheckBoxView(checked: $checked)
                        .onTapGesture {
                            if self.checked {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    self.checked.toggle()
                                }
                            } else {
                                withAnimation {
                                    self.checked.toggle()
                                }
                            }
                        }
                        .padding(.leading, -10)
                    DeadlineView()
                }
                .padding(.top, 5)
                EntryTitleView()
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 3))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding(.all, 5)
        
    }
}

struct CourseNameView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.system(size: 15))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.brown)
            )
            .offset(x:-5)
            .offset(y:-12)
            .zIndex(1)
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
    var body: some View {
        HStack {
            Text("2023/04/08 8:30")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 176/255 , green: 17/255, blue: 16/255))
            Spacer()
            Text("あと0日0時間55分")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 100/255 , green: 100/255, blue: 100/255))
        }
    }
}

struct EntryTitleView: View {
    var body: some View {
        Text("sss")
            .padding(.leading, 35)
    }
}


struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(checked: false)
    }
}
