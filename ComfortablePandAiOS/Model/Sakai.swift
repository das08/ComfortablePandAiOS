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
    
    func getLoginToken(completion: @escaping (Result<Token, Error>) -> Void) {
        let urlString = "https://panda.ecs.kyoto-u.ac.jp/cas/login?service=https%3A%2F%2Fpanda.ecs.kyoto-u.ac.jp%2Fsakai-login-tool%2Fcontainer"
        
        AF.request(urlString, method: .get).responseString { response in
            switch response.result {
            case .success(let value):
                let regexLT = try! NSRegularExpression(pattern: "<input type=\"hidden\" name=\"lt\" value=\"(.+)\" \\/>")
                let regexEXE = try! NSRegularExpression(pattern: "<input type=\"hidden\" name=\"execution\" value=\"(.+)\" \\/>")
                guard let resultLT = regexLT.firstMatch(in: value, options: [], range: NSRange(0..<value.count)) else {
                    completion(.failure(Status.LTNotFound))
                    return
                }
                guard let resultEXE = regexEXE.firstMatch(in: value, options: [], range: NSRange(0..<value.count)) else {
                    completion(.failure(Status.EXENotFound))
                    return
                }
                
                let start = resultLT.range(at: 1).location
                let end = start + resultLT.range(at: 1).length
                let start2 = resultEXE.range(at: 1).location
                let end2 = start2 + resultEXE.range(at: 1).length
                
                let loginToken = String(value[value.index(value.startIndex, offsetBy: start)..<value.index(value.startIndex, offsetBy: end)])
                let execution = String(value[value.index(value.startIndex, offsetBy: start2)..<value.index(value.startIndex, offsetBy: end2)])
                let tokens = Token(LT: loginToken, EXE: execution)
                completion(.success(tokens))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct Token {
    var LT: String?
    var EXE: String?
}

enum Status: Error {
    case Default
    case Network
    case JSONParse
    case LTNotFound
    case EXENotFound
}

