//
//  UserModel.swift
//  SampleCodeIos
//
//  Created by Hổ's Macbook on 13/10/2024.
//

import Foundation
/**
 Represents a user with a unique identifier, name, email, and avatar URL.
 
 This struct conforms to the Identifiable protocol, which requires a unique identifier.
 */
struct User: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let avatarUrl: String
}
