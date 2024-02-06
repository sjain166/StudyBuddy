//
//  userInformationModel.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 10/23/23.
//

import Foundation
import SwiftUI
import Firebase

struct UserDataModel : Codable, Identifiable, Hashable{
    
    let id = UUID()
    let activeSession : String?
    let uid : String
    let email : String
    let fullName : String
    let username : String
    let photoURL : String?
    let dateCreated : Date
    
    init(activeSession: String?, username: String, fullName : String, userAuthObject : AuthDataResultModel, URL : String, dateCreated : Date) {
        self.activeSession = activeSession
        self.uid = userAuthObject.uid!
        self.email = userAuthObject.email!
        self.fullName = fullName
        self.username = username
        self.photoURL = URL
        self.dateCreated = dateCreated
    }
    
}



