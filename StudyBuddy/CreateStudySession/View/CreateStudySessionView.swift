//
//  CreateNewStudySessionView.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 10/23/23.
//

import Foundation
import SwiftUI
import MapKit



struct CreateStudySessionView : View{
    
    @State private var cameraPosition : MapCameraPosition = .region(.myRegion)
    
    @StateObject var createStudySessionViewModel = CreateStudySessionViewModel()
    @Binding var selectedIndex : Int
    @Binding var childSelectedIndex : Int
    
    
    var body : some View{
        VStack{
            List {
                Section {
                    TextField("Enter Session Name", text: $createStudySessionViewModel.sessionName)
                    
                    HStack {
                        Text("Select Course").padding()
                        Picker("", selection: $createStudySessionViewModel.selectedCourse ) {
                            ForEach(createStudySessionViewModel.courses, id: \.self) { course in
                                Text(course)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        Text("Start Time : ")
                        Spacer()
                        DatePicker("", selection: $createStudySessionViewModel.startTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    HStack {
                        Text("End Time   : ")
                        Spacer()
                        DatePicker("", selection: $createStudySessionViewModel.endTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    HStack {
                        Text("Select Location ").padding()
                        Picker("", selection: $createStudySessionViewModel.selectedLocation) {
                            ForEach(createStudySessionViewModel.location, id: \.self) { location in
                                Text(location)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
            }
            .navigationTitle("Create New Session")
            .listStyle(.insetGrouped)
            .foregroundColor(.brown)
            
            
            ZStack{
                MapView(sessionLocation: $createStudySessionViewModel.selectedLocation)
                .frame(width: 350 , height: 250).cornerRadius(100)
            }
            
            MyButton(buttonText: "Add" , width: 300 , height: 10) {
                do{
                    try createStudySessionViewModel.registerNewSesion()
                }catch{
                    print("Error in the View File")
                }
            }.padding()
        }.alert(isPresented:  $createStudySessionViewModel.setAlert ){
            Alert(title: Text("\(createStudySessionViewModel.setAlertMessage)") , dismissButton: .destructive(Text("Confirm"), action: {
                if createStudySessionViewModel.sesssionCreation {
                    childSelectedIndex = 0
                    selectedIndex = 1
                }
                else{
                    selectedIndex = 0
                    childSelectedIndex = 0
                }
            }))
        }.onAppear{
            do {
                try createStudySessionViewModel.checkActiveSession()
            }catch{
                print("Failed to Fetch Session Information")
            }
        }
    }
}

extension CLLocationCoordinate2D {
    static var myLocation: CLLocationCoordinate2D {
        return .init(latitude: 33.42079222503598, longitude:  -111.93396882854465)
    }
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 1500 , longitudinalMeters: 1500)
    }
}

#Preview{
    CreateStudySessionView(selectedIndex: .constant(1) , childSelectedIndex: .constant(1))
}

