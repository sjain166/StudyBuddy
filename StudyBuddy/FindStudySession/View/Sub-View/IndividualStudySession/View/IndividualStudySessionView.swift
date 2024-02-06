//
//  IndividualStudySessionView.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation
import SwiftUI

struct IndividualStudySessionView: View {
    
    @State var studySessionData : SessionModel
    
    var body : some View{
        
        HStack{
            VStack(alignment:.center){
                let isActive = studySessionData.endTime > .now
                Circle().fill(isActive ? .green : .red).frame(width: 10 , height: 10)
                Text(isActive ? "Active" : "Inactive")
            }
            
            Rectangle().fill(Color.red).frame(width: 1, height: 45)
            
            ZStack{
                VStack{
                    Image(systemName: "person.circle.fill").resizable().frame(width: 50, height: 50)
                }
                
            }
            
            VStack{
                Text(studySessionData.subject).font(.title).bold()
                HStack{
                    Text("Active User :").foregroundColor(Color.purple)
                    Text("\(studySessionData.participants.count)")
                }
                
            }.padding([.leading, .trailing], 5)
            
            Rectangle().fill(Color.red).frame(width: 1, height: 45)
            
            VStack{
                Image(systemName: "map")
                Text(studySessionData.location).padding(.top , 2)
            }
        }.padding()
            .foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom))
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous) )

    }
}
