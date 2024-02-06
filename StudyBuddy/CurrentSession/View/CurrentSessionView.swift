//
//  UserActiveStudyView.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 10/23/23.
//

import Foundation
import SwiftUI
import MapKit



struct CurrentSessionView : View{
    
    @StateObject var viewModel = CurrentSessionViewModel()
    @Binding var parentSelectedIndex : Int
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // Customize the format as needed
        return formatter
    }()
    
    
    var body : some View{
        VStack{
            Text("MAT 266").font(.largeTitle).bold().multilineTextAlignment(.center)
                .foregroundStyle(LinearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom))
            ScrollView{
                VStack{
                    
                    
                    Spacer()
                    
                    HStack{
                        Text("Session Description").frame(alignment: .leading).font(.headline).padding(.trailing, 150)
                    }.foregroundStyle(LinearGradient(colors: [.orange, .white], startPoint: .top, endPoint: .bottom))
                    
                    
                    HStack{
                        ScrollView{
                            Text(viewModel.studySessionObject?.sessionName ?? "Failed To Fetch Session Description")
                        }
                        
                    }
                    .foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom))
                    .background(.ultraThinMaterial)
                    .safeAreaPadding().cornerRadius(40)
                    Spacer()
                    
                    HStack{
                        Text("Active Users").frame(alignment: .leading).font(.headline).padding(.trailing, 150)
                    }.foregroundStyle(LinearGradient(colors: [.orange, .white], startPoint: .top, endPoint: .bottom))
                    
                    ScrollView(.horizontal){
                        HStack{
                        ForEach(viewModel.activeAtendee, id: \.self){ user in
                                VStack{
                                    Image(systemName: "person.circle")
                                    Text(user.username)
                                }
                            }
                        }
                    }.foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom))
                        .background(.ultraThinMaterial)
                        .safeAreaPadding().cornerRadius(40)

                    Spacer()
                    
                    //                    HStack{
                    //                        Text("Timings").frame(alignment: .leading).font(.headline)
                    //                    }.foregroundStyle(LinearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .trailing))
                    
                    HStack{
                        VStack{
                            Image(systemName: "deskclock").resizable().frame(width: 30, height: 30)
                            if let date = viewModel.studySessionObject?.startTime {
                                Text(dateFormatter.string(from: date)).foregroundStyle(Color.red)
                            }
                            else{
                                Text("Failed to Fetch Time").foregroundStyle(Color.red)
                            }
                            
                        }
                        
                        Image(systemName: "arrowshape.left.arrowshape.right.fill").resizable().frame(width: 60, height: 20).padding(.bottom, 10)
                        
                        VStack{
                            Image(systemName: "deskclock.fill").resizable().frame(width: 30, height: 30)
                            if let date = viewModel.studySessionObject?.endTime {
                                Text(dateFormatter.string(from: date)).foregroundStyle(Color.red)
                            }
                            else{
                                Text("Failed to Fetch Time").foregroundStyle(Color.red)
                            }
                        }
                    }
                    .foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .trailing))
                    .padding()
                    //.background(.ultraThinMaterial).safeAreaPadding().cornerRadius(40)
                    
                    ZStack{
                        MapView(sessionLocation: $viewModel.location).frame(width: 350 , height: 250).cornerRadius(20)
                    }
                    MyButton(buttonText: "Exit Session ", width: 300, height: 10){
                        do{
                            try viewModel.exitSession()
                        }catch{
                            print("Failed to Exit Session")
                        }
                    }
                }
            }
        }
        .safeAreaPadding()
        .onAppear{
            viewModel.checkAndLoadActiveSession()
        }
        .alert(isPresented:  $viewModel.setAlert ){
            Alert(title: Text("\(viewModel.setAlertMessage)") , dismissButton: .destructive(Text("Confirm"), action: {
                print("Active study session \(viewModel.activeSessionID)")
                if viewModel.activeSessionID == "" {
                    parentSelectedIndex = 0
                }
                
            }))
        }
        
    }
}

#Preview {
    CurrentSessionView(parentSelectedIndex: .constant(2))
}
