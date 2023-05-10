//
//  String.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/10.
//

import Foundation

extension String {
    func match(_ pattern: String) -> [String] {
        let range = NSRange(location: 0, length: self.count)
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let matched = regex.firstMatch(in: self, range: range)
        else { return [] }
        return (0 ..< matched.numberOfRanges).compactMap { i in
            let r = matched.range(at: i)
            if r.location == NSNotFound { return nil }
            return NSString(string: self).substring(with: r)
        }
    }
}
