//
//  Sakai.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/08.
//

import Foundation
import Alamofire

final class SakaiAPI {
    static let shared = SakaiAPI()
    
    private func getLoginToken(completion: @escaping (Result<Token, Error>) -> Void) {
        let urlString = "https://panda.ecs.kyoto-u.ac.jp/cas/login?service=https%3A%2F%2Fpanda.ecs.kyoto-u.ac.jp%2Fsakai-login-tool%2Fcontainer"
        let regexLT = try? NSRegularExpression(pattern: "<input type=\"hidden\" name=\"lt\" value=\"(.+)\" \\/>")
        let regexEXE = try? NSRegularExpression(pattern: "<input type=\"hidden\" name=\"execution\" value=\"(.+)\" \\/>")

        guard let ltRegex = regexLT, let exeRegex = regexEXE else {
            completion(.failure(FetchError(message: "Failed to create regular expressions")))
            return
        }

        AF.request(urlString, method: .get).responseString { [self] response in
            switch response.result {
            case .success(let value):
                guard let resultLT = ltRegex.firstMatch(in: value, options: [], range: NSRange(0..<value.count)),
                      let resultEXE = exeRegex.firstMatch(in: value, options: [], range: NSRange(0..<value.count)) else {
                    completion(.failure(FetchError(message: "Regular expression matches not found")))
                    return
                }
                
                let loginToken = self.extractSubString(from: value, using: resultLT)
                let execution = extractSubString(from: value, using: resultEXE)
                let tokens = Token(LT: loginToken, EXE: execution)
                completion(.success(tokens))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func extractSubString(from value: String, using result: NSTextCheckingResult) -> String {
        let start = result.range(at: 1).location
        let end = start + result.range(at: 1).length
        return String(value[value.index(value.startIndex, offsetBy: start)..<value.index(value.startIndex, offsetBy: end)])
    }
    
    
    func isLoggedin(completion: @escaping (Result<Bool, Error>) -> Void) {
        let urlString = "https://panda.ecs.kyoto-u.ac.jp/portal/"
        let regex = try? NSRegularExpression(pattern: "\"loggedIn\": true")

        guard let loginRegex = regex else {
            completion(.failure(FetchError(message: "Failed to create regular expression")))
            return
        }

        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else {
                    completion(.failure(FetchError(message: "Data could not be converted to string")))
                    return
                }
                let matches = loginRegex.matches(in: str, options: [], range: NSRange(0..<str.count))
                completion(.success(matches.count > 0))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func login(completion: @escaping (Result<Bool, Error>) -> Void) {
        getLoginToken { result in
            switch result {
            case .success(let tokens):
                var ECS_ID = ""
                var Password = ""
                
//                if let ecsIdResult = getKeychain(account: "ECS_ID"),
//                   let passwordResult = getKeychain(account: "Password"),
//                   ecsIdResult.success && passwordResult.success {
//                    ECS_ID = ecsIdResult.data
//                    Password = passwordResult.data
//                } else {
//                    completion(.failure(FetchError(message: ErrorMsg.FailedToGetKeychain.rawValue)))
//                    return
//                }
                
                let urlString = "https://panda.ecs.kyoto-u.ac.jp/cas/login?service=https%3A%2F%2Fpanda.ecs.kyoto-u.ac.jp%2Fsakai-login-tool%2Fcontainer"
                let parameters: [String: Any] = [
                    "_eventId": "submit",
                    "execution": tokens.EXE ?? "",
                    "lt": tokens.LT ?? "",
                    "password": Password,
                    "username": ECS_ID
                ]
                
                AF.request(urlString, method: .post, parameters: parameters).responseData { response in
                    switch response.result {
                    case .success(let data):
                        guard let str = String(data: data, encoding: .utf8) else {
                            completion(.failure(FetchError(message: "Data could not be converted to string")))
                            return
                        }

                        let regex = try? NSRegularExpression(pattern: "\"loggedIn\": true")
                        let matches = regex?.matches(in: str, options: [], range: NSRange(0..<str.count))
                        print("loged in: \(matches?.count ?? 0), \(matches?.count ?? 0 > 0)")
                        completion(.success(matches?.count ?? 0 > 0))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func ensureUserIsLoggedIn() {
        isLoggedin { result in
            switch result {
            case .success(let isLoggedIn):
                if !isLoggedIn {
                    self.login { loginResult in
                        switch loginResult {
                        case .success(let isLoginSuccessful):
                            if isLoginSuccessful {
                                print("User logged in successfully")
                            } else {
                                print("Login process completed but user is not logged in. Please check credentials or network connection.")
                            }
                        case .failure(let error):
                            print("Failed to log in: \(error)")
                        }
                    }
                } else {
                    print("User is already logged in")
                }
            case .failure(let error):
                print("Failed to check if user is logged in: \(error)")
            }
        }
    }


    
}

struct Token {
    var LT: String?
    var EXE: String?
}

struct FetchError: Error {
    let message: String
}

enum Status: Error {
    case Default
    case Network
    case JSONParse
    case LTNotFound
    case EXENotFound
}

