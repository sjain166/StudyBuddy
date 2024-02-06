//
//  AuthenticationManager.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/18/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

final class AuthenticationManager {
    
    static let sharedAuth = AuthenticationManager()
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else{
            throw URLError(.userAuthenticationRequired)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func createUser(email : String , password : String) async throws -> AuthDataResultModel {
        let authDataresult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataresult.user)
    }
    
    @discardableResult
    func signIn(email : String , password : String) async throws -> AuthDataResultModel{
        let authDataresult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataresult.user)
    }
    
    func userSignOut() throws {
        try Auth.auth().signOut()
    }
    
}


