//
//  studySessionModel.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 10/23/23.
//

import Foundation
import SwiftUI

class SessionModel: Codable, Identifiable{
    var adminName : String
    var sessionName : String
    var admin : String
    var sessionID : String
    var subject : String
    var startTime : Date
    var endTime : Date
    var participants : [String]
    var location : String
    
    
    init(adminName : String, sessionName : String, admin: String, sessionID: String, subject: String, startTime: Date, endTime: Date, participants: [String], location : String) {
        self.adminName = adminName
        self.sessionName = sessionName
        self.admin = admin
        self.sessionID = sessionID
        self.subject = subject
        self.startTime = startTime
        self.endTime = endTime
        self.participants = participants
        self.location = location
    }
    
    init(dictionary: [String: Any]) throws {
        guard let adminName = dictionary["adminName"] as? String,
              let sessionName = dictionary["sessionName"] as? String,
              let admin = dictionary["admin"] as? String,
              let sessionID = dictionary["sessionID"] as? String,
              let subject = dictionary["subject"] as? String,
              let startTime = dictionary["startTime"] as? Date,
              let endTime = dictionary["endTime"] as? Date,
              let participants = dictionary["participants"] as? [String],
              let location = dictionary["location"] as? String else {
          throw NSError(domain: "StudySessionModel", code: 1, userInfo: nil)
        }

        self.adminName = adminName
        self.sessionName = sessionName
        self.admin = admin
        self.sessionID = sessionID
        self.subject = subject
        self.startTime = startTime
        self.endTime = endTime
        self.participants = participants
        self.location = location
      }
    
}
