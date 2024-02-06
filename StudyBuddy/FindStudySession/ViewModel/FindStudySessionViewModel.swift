//
//  FindStudySessionViewModel.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation

@MainActor
final class FindStudySessionViewModel : ObservableObject{
    
    @Published private(set) var  studySessions : [SessionModel] = []
    @Published var selectCourse = ""
    
    var courses = ["MAT 266" , "MAT 211" , "MAT 210" , "MAT 117" , "MAT 142"]
    
    @Published var selectedLocation = ""
    var location = ["Hayden" , "Barret" , "Noble" , "BA" , "Brickyard"]
    
    @Published var showDetail = false
    
    func loadStudySessions() {
        Task{
            do{
                studySessions = try await StudySessionManager.shared.getSessions()
            }catch{
                print("Failed to Fetch Active Sessions")
            }
        }
    }
    
}
