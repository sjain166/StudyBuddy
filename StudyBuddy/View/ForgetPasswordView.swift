//
//  ForgetPasswordView.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 10/23/23.
//

import Foundation
import SwiftUI

struct ForgetPasswordView: View{
    @State var userEmail : String = ""
    @State var userNewPassword : String = ""
    
    var body : some View{
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.7), Color.purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 10)
                    .overlay(Color.black.opacity(0.1))
                
                VStack{
                    Spacer()
                    Image(systemName: "questionmark")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .foregroundColor(.black).padding(.bottom , 40)
                    
                    Text("Reset Password").bold().font(.largeTitle).fontWeight(.heavy)
                    
                    MyTextField(fieldText: $userEmail , displayText: "E-mail ID")
                    MyTextField(fieldText: $userEmail , displayText: "New Password")
                    MyButton(buttonText: "Change Password", width: 300, height: 20){
                        
                    }
                }
                
            }.safeAreaPadding()
        }
    }
}

#Preview {
    ForgetPasswordView()
}
