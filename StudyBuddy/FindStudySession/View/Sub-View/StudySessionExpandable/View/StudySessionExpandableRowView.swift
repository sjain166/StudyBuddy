//
//  StudySessionExpandableView.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation
import SwiftUI

struct StudySessionExpandableRowView : View{
    
    @StateObject var viewModel = StudySessionExpandableRowViewModel()
    @State var session : SessionModel
    @Binding var parentSelectedIndex : Int
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a" // Customize the format as needed
            return formatter
        }()
    
    var body : some View{
        
        VStack{
            HStack{
                VStack{
                    Image(systemName: "deskclock").resizable().frame(width: 30, height: 30)
                    Text(dateFormatter.string(from: session.startTime)).foregroundStyle(Color.red)
                    
                }
                
                Image(systemName: "arrowshape.left.arrowshape.right.fill").resizable().frame(width: 60, height: 20).padding(.bottom, 10)
                
                VStack{
                    Image(systemName: "deskclock.fill").resizable().frame(width: 30, height: 30)
                    Text(dateFormatter.string(from: session.endTime)).foregroundStyle(Color.red)
                }
            }
            .foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .trailing))
            .padding()
            
            MyButton(buttonText: "Join Session", width: 200, height: 20){
                viewModel.joinSession(sessionID: session.sessionID)
            }
        }.alert(isPresented:  $viewModel.showAlert ){
            Alert(title: Text("\(viewModel.alertMessage)") , dismissButton: .destructive(Text("Confirm"), action: {
                if viewModel.sessionJoined{
                    parentSelectedIndex = 1
                }
            }))
        }
    }
}
