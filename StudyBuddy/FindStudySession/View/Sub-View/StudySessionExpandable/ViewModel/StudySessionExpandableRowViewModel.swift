//
//  StudySessionExpandableViewModel.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation
import SwiftUI

final class StudySessionExpandableRowViewModel : ObservableObject{
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var sessionJoined = false
    
    func joinSession(sessionID : String){
        Task{
            do{
                let authenticatedUser = try AuthenticationManager.sharedAuth.getAuthenticatedUser()
                
                let userProfileData = try await UserManager.shared.getuser(userId: authenticatedUser.uid!)
                
                let currentSession = try await StudySessionManager.shared.getStudySessionByID(sessionID: sessionID)
                
                if userProfileData.activeSession == "" && currentSession.endTime > .now {
                    try await UserManager.shared.setUserActiveSessionID(userID: userProfileData.uid, sessionID: sessionID)
                    try await StudySessionManager.shared.addUserToStudySession(sessionId: sessionID, userID: userProfileData.uid)
                    alertMessage = "Session Joined Successfully !"
                    showAlert.toggle()
                    sessionJoined = true
                }
                else{
                    alertMessage = "Session Closed !"
                    showAlert.toggle()
                }
                
            }catch{
                alertMessage = "Internal Server Error !"
                showAlert.toggle()
                print("Failed to Join Sesion")
            }
        }
    }
}
