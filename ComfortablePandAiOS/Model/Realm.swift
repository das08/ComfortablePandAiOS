//
//  Realm.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/08.
//

import Foundation
import RealmSwift

class RealmManager {
    var realm: Realm {
        return try! Realm(configuration: configuration)
    }
    
    var fileUrl: URL {
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.das08.PandAssist")!
        return url.appendingPathComponent("panda3.realm")
    }
    
    var configuration: Realm.Configuration {
        let encryptionKey = getKey()
//        return Realm.Configuration(fileURL: fileUrl)
        return Realm.Configuration(fileURL: fileUrl, encryptionKey: encryptionKey as Data)
    }

    
    func getKey() -> NSData {
        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = "com.das08.PandAssist"
        let keychainGroup = "V6B4TS7288.group.com.das08.PandAssist" // Add this line
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!

        // Update the query dictionary to include the kSecAttrAccessGroup key with the keychain group value
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject,
            kSecAttrAccessGroup: keychainGroup as AnyObject // Add this line
        ]

        // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! NSData
        }

        // No pre-existing key from this application, so generate a new one
        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
        assert(result == 0, "Failed to get random bytes")

        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: keyData
        ]

        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")

        return keyData
    }
}
