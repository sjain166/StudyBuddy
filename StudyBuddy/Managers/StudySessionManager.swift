//
//  StudySessionManager.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/20/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

final class StudySessionManager {
    
    
    static let shared = StudySessionManager()
    private let sessionCollection = Firestore.firestore().collection("studySessions")
    
    private func sessionDocument(sessionID : String) -> DocumentReference {
        sessionCollection.document(sessionID)
    }
    
    func addNewSession(sessionObject : SessionModel) throws{
        try sessionDocument(sessionID: sessionObject.sessionID).setData(from: sessionObject, merge: false)
    }
    
    func getStudySessionByID(sessionID : String) async throws -> SessionModel{
        try await sessionDocument(sessionID: sessionID).getDocument(as : SessionModel.self)
    }
    
    func getActiveUsersForSession(sessionID: String) async throws -> [UserDataModel] {
        do {
            let activeSession = try await getStudySessionByID(sessionID: sessionID)
            print("Total Active Participants in the Session \(activeSession.participants.count)")

            var activeParticipant: [UserDataModel] = []
            
            try await withThrowingTaskGroup(of: UserDataModel?.self) { group in
                for userId in activeSession.participants {
                    group.addTask {
                        do {
                            return try await UserManager.shared.getuser(userId: userId)
                        } catch {
                            print("Error fetching user: \(error)")
                            return nil
                        }
                    }
                }

                for try await user in group {
                    if let user = user {
                        activeParticipant.append(user)
                    }
                }
            }
            return activeParticipant
        } catch {
            throw error
        }
    }
    
    
    func getSessions() async throws -> [SessionModel]{
        var sessions : [SessionModel] = []
        
        let snapshot = try await sessionCollection.getDocuments()
        
        for document in snapshot.documents{
            let studySession = try document.data(as : SessionModel.self)
            sessions.append(studySession)
        }
        
        return sessions
    }
    
    func removeUserFromSession(sessionID : String , userID : String) async throws{
        let sessionInfo = try await getStudySessionByID(sessionID: sessionID)
        let updtedParticipants = sessionInfo.participants.filter {$0 != userID}
        
        let data : [String:Any] = [
            "participants" : updtedParticipants
        ]
        try await sessionDocument(sessionID: sessionID).updateData(data)
    }
    
    func addUserToStudySession(sessionId : String , userID : String) async throws{
        print("The Session ID is \(sessionId)")
        print("The userID is \(userID)")
        
        let sessionInfo = try await getStudySessionByID(sessionID: sessionId)
        var updtedParticipants = sessionInfo.participants
        updtedParticipants.append(userID)
        
        
        let data : [String:Any] = [
            "participants" : updtedParticipants
        ]
        
        try await sessionDocument(sessionID: sessionId).updateData(data)
    }
    
    
}
