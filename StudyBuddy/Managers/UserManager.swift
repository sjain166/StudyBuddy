//
//  UserManager.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/19/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
    static let shared = UserManager()
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId : String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(user : UserDataModel) async throws {
        try userDocument(userId: user.uid).setData(from: user, merge: false)
    }
    
    func getuser(userId : String) async throws -> UserDataModel {
        try await userDocument(userId: userId).getDocument(as : UserDataModel.self)
    }
    
    func setUserActiveSessionID(userID : String, sessionID : String) async throws{
        var data : [String:Any] = [
            "activeSession" : sessionID
        ]
        
        try await userDocument(userId: userID).updateData(data)
    }

}
