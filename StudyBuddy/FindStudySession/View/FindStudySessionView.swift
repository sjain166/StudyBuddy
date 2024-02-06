//
//  FindStudyGroupView.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 10/23/23.
//

import Foundation
import SwiftUI



struct FindStudySessionView : View{

    @StateObject var viewModel = FindStudySessionViewModel()
    
    @State var selectedChildViewIndex = 0
    
    @Binding var selectedParentViewIndex : Int
    
    var body : some View{
        
        VStack {
            Picker("Select View", selection: $selectedChildViewIndex) {
                Text("Show Active Session").tag(0)
                Text("Create New Session").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedChildViewIndex == 0 {
//                HStack{
//                    VStack{
//                        Text("Select Course").padding()
//                        Picker("Course", selection: $viewModel.selectCourse) {
//                            ForEach(viewModel.courses, id: \.self) { course in
//                                Text(course)
//                            }
//                        }
//                        .pickerStyle(DefaultPickerStyle())
//                    }
//                    .foregroundStyle(LinearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom))
//                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
//                    
//                    VStack{
//                        Text("Select Location ").padding()
//                        Picker("Location ", selection: $viewModel.selectedLocation) {
//                            ForEach(viewModel.location, id: \.self) { course in
//                                Text(course)
//                            }
//                        }.pickerStyle(DefaultPickerStyle())
//                    }
//                    .foregroundStyle(LinearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom))
//                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous) ).padding()
//                    
//                }
                
                List{
                    ForEach(viewModel.studySessions) { session in
                        
                        StudySessionExpandableRow(session: session) {
                            StudySessionExpandableRowView(session: session, parentSelectedIndex: $selectedParentViewIndex)
                        }
                    }
                }
                
                .listStyle(.inset).safeAreaPadding()
            } else {
                CreateStudySessionView(selectedIndex: $selectedParentViewIndex , childSelectedIndex: $selectedChildViewIndex)
            }
        }.task {
            viewModel.loadStudySessions()
        }
        
    }
}



struct ShowStudySession_Previews: PreviewProvider {
    static var previews: some View {
        FindStudySessionView(selectedParentViewIndex: .constant(0))
            .preferredColorScheme(.light)
            .previewDisplayName("Light Mode Preview")

        FindStudySessionView(selectedParentViewIndex: .constant(0))
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode Preview")
    }
}










