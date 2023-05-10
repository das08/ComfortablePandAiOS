//
//  LoginView.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/08.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    let realm = RealmManager().realm
    @ObservedRealmObject var userInfo: UserInfoModel

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            TextField("ECS ID", text: $username)
                .padding()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal, 20)
            
            Button(action: {
                try? realm.write {
                    userInfo.thaw()?.morning = self.username
                    userInfo.thaw()?.midnight = self.password
                }
                SakaiAPI.shared.login { result in
                    switch result {
                    case .success(let loginResult):
                        if loginResult.Success {
                            print("User logged in successfully")
                        } else {
                            print("Login process completed but user is not logged in. Please check credentials or network connection.")
                        }
                    case .failure(let error):
                        print("Failed to log in: \(error)")
                    }
                }
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            .padding(.top, 30)
        }
        .padding(.top, 50)
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

