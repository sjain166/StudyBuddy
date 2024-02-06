//
//  UserProfileViewModel.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation

@MainActor
final class UserProfileViewModel : ObservableObject {
    
    @Published private(set) var user : UserDataModel? = nil
    @Published var logOutStatus = false
    @Published var alertMessgae = "Log Out Successful !"
    
    func logOut() throws{
        try AuthenticationManager.sharedAuth.userSignOut()
        logOutStatus = true
    }
    
    func loadCurrentUser() throws {
        let authDataResult = try AuthenticationManager.sharedAuth.getAuthenticatedUser()
        
        Task{
            do{
                self.user = try await UserManager.shared.getuser(userId: authDataResult.uid!)
            }catch{
                print(error)
            }
        }
    }
}

