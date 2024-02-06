//
//  CurrentSessionViewModel.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation
import SwiftUI

@MainActor
final class CurrentSessionViewModel : ObservableObject{
    @Published var studySessionObject : SessionModel? = nil
    @Published var activeSessionID = ""
    @Published var activeAtendee : [UserDataModel] = []
    @Published var setAlert = false
    @Published var setAlertMessage = ""
    @Published var location = ""
    
    func checkAndLoadActiveSession() {
        Task{
            do{
                let sessionID = try AuthenticationManager.sharedAuth.getAuthenticatedUser().uid
                self.activeSessionID = try await UserManager.shared.getuser(userId: sessionID!).activeSession!
                let result = activeSessionID.count > 0
                
                
                if !result {
                    self.setAlert = true
                    self.setAlertMessage = "No Active Session , Please Join an Active Session"
                }else{
                    studySessionObject = try await StudySessionManager.shared.getStudySessionByID(sessionID: activeSessionID)
                    self.activeAtendee =  try await StudySessionManager.shared.getActiveUsersForSession(sessionID: activeSessionID)
                    self.location = studySessionObject?.location ?? ""
                }
                
            }
            catch{
                print("Failed to Retrive Active Session Status")
            }
        }
    }
    
    func exitSession() throws {
        Task{
            do{
                let userID = try AuthenticationManager.sharedAuth.getAuthenticatedUser().uid
                try await UserManager.shared.setUserActiveSessionID(userID: userID ?? "" , sessionID: "")
                try await StudySessionManager.shared.removeUserFromSession(sessionID: activeSessionID , userID: userID!)
                activeSessionID = ""
                self.setAlert = true
                self.setAlertMessage = "Session Exit Successful"
            }catch{
                print("Failed to Exit Session")
            }
        }
    }
    
    

}
