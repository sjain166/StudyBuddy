//
//  CreateStudySessionViewModel.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation
import SwiftUI
import MapKit

@MainActor
final class CreateStudySessionViewModel : ObservableObject {
    
    let locations: [String: CLLocationCoordinate2D] = [
        "Hayden": CLLocationCoordinate2D(latitude: 33.41922038283769,  longitude: -111.93461983169928),
        "Noble": CLLocationCoordinate2D(latitude: 33.42016061604622, longitude: -111.93060107217248),
        "Brickyard": CLLocationCoordinate2D(latitude: 33.42380936678801, longitude: -111.93959199168822),
    ]
    
    @Published var courses = ["MAT 266" , "MAT 211" , "MAT 210" , "MAT 117" , "MAT 142"]
    @Published var location = ["Phoenix" , "Tempe", "Mesa"]
    @Published var sessionName : String = ""
    @Published var startTime : Date = .now
    @Published var endTime : Date = .now
    @Published var selectedCourse : String = "MAT 266"
    @Published var selectedLocation : String = "Phoenix"
    @Published var latitude : Double = 0.00
    @Published var longitude : Double = 0.00
    @Published var setAlert = false
    @Published var setAlertMessage = ""
    @Published var sesssionCreation = false
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.2125822, longitude:  -111.6891173),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    func registerNewSesion() throws {
        
        var newSession : SessionModel? = nil
        Task{
            do{
                newSession = try await createSession()
                guard !sessionName.isEmpty, startTime < endTime , !selectedCourse.isEmpty, !selectedLocation.isEmpty else{
                    print("Error In Creating New Session")
                    self.setAlertMessage = "Failed To Create a Session"
                    self.setAlert = true
                    return
                }
                
                do{
                    if let unwrappedObject = newSession{
                        try StudySessionManager.shared.addNewSession(sessionObject: unwrappedObject)
                        self.sesssionCreation = true
                        self.setAlertMessage = "Session Created !!!"
                        self.setAlert = true
                        try await UserManager.shared.setUserActiveSessionID(userID: unwrappedObject.sessionID, sessionID: unwrappedObject.sessionID)
                    }
                    else{
                        self.setAlertMessage = "Failed To Create a Session"
                        self.setAlert = true
                        print("NewSesssion Object Null, Failed to Create SessionObject")
                    }
                }catch{
                    print(error)
                }
                
            }catch{
                throw error
            }
        }
    }
    
    func createSession() async throws  -> SessionModel{
        let authenticatedUser = try AuthenticationManager.sharedAuth.getAuthenticatedUser()
        let adminEmail = authenticatedUser.email!
        let sessionID = authenticatedUser.uid
        var adminName = ""
        do{
            adminName = try await UserManager.shared.getuser(userId: sessionID!).fullName
            let participants = [sessionID!]
            
            let sessionObject = SessionModel(
                adminName : adminName,
                sessionName: sessionName,
                admin: sessionID!,
                sessionID: sessionID!,
                subject: selectedCourse,
                startTime: startTime,
                endTime: endTime,
                participants: participants,
                location: selectedLocation
            )
            return sessionObject
        }catch{
            print(error)
            throw error
        }
    }
    
    func checkActiveSession() throws {
        Task{
            do{
                let sessionID = try AuthenticationManager.sharedAuth.getAuthenticatedUser().uid
                let result = try await UserManager.shared.getuser(userId: sessionID!).activeSession?.count ?? -1 > 0
                
                if result {
                    self.setAlert = true
                    self.setAlertMessage = "User Has Ongoing Session, Please exit the current session to create new one"
                }
                
            }
            catch{
                print("Failed to Retrive Active Session Status")
            }
        }
    }    
}
