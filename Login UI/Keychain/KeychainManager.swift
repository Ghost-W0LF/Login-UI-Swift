//
//  keychain.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/21/24.
//

import Foundation
import Security

class KeychainManager {
    
    enum KeychainError: Error {
        case duplicateItem
        case unknown(OSStatus)
    }
    enum KeychainUpdateError : Error {
    case itemNotFound
    case unknown(OSStatus)
    }
    enum KeychainRetriveError: Error {
           case itemNotFound
           case unexpectedDataFormat
           case unknown(OSStatus)
       }
    
    static func retriveData(email: String) throws -> Data {
        // Create a query dictionary to retrieve the credit card data from the Keychain
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword, // Specifies the item class as a generic password
            kSecAttrAccount as String: email, // The account name identifying the credit card item
            kSecReturnData as String: true, // Specifies that the item data should be returned
            kSecMatchLimit as String: kSecMatchLimitOne // Specifies that only one item should be returned
        ]
        
        // Attempt to retrieve the credit card data from the Keychain
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        // Check the result of the Keychain operation and throw appropriate errors if needed
        if status == errSecItemNotFound {
            throw KeychainRetriveError.itemNotFound // Throw if the credit card item is not found in Keychain
        } else if status != errSecSuccess {
            throw KeychainError.unknown(status) // Throw for any other unknown error
        }
        
        // Ensure the retrieved item data is in the expected format
        guard let data = item as? Data else {
            throw KeychainRetriveError.unexpectedDataFormat // Throw if the retrieved data is not in the expected format
        }
        
        return data
    }
    
    
    
    static func storePassword(password: String, email:String) throws {
        let passwordData = password.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecValueData as String: passwordData,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]

        // adding the item to keychain here
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            throw KeychainError.duplicateItem
        } else if status != errSecSuccess {
            throw KeychainError.unknown(status)
        }
    }
    
    static func updateAccessToken(newPassword: String , email: String) throws {
        let newTokenData = newPassword.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
        ]
        
        let attributesToUpdate: [String: Any] = [
                    kSecValueData as String: newTokenData // The new access token data to be updated
                ]
        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        
        if status == errSecItemNotFound {
                   throw KeychainUpdateError.itemNotFound // Throw if the item to update is not found in Keychain
               } else if status != errSecSuccess {
                   throw KeychainUpdateError.unknown(status) // Throw for any other unknown error
               }
    }
}
