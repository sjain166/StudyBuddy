//
//  AddUserView.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 10/23/23.
//

import Foundation
import SwiftUI



struct AddUserView : View{
    
    @StateObject private var signUpViewModel = SignInEmailViewModel()
    @State private var showPassword = false
    
    
    var body : some View{
        VStack {
            
            Button(action: {
                
            }) {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 100)
                //.clipShape(Circle())
                //.overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 10)
                    .safeAreaPadding()
            }
            
            HStack{
                Text("\(signUpViewModel.username)").foregroundStyle(.green).font(.headline)
            }
            
            MyTextField(fieldText: $signUpViewModel.fullName, displayText: "Full Name")
            
            MyTextField(fieldText: $signUpViewModel.username, displayText: "Username")
                .foregroundColor(Color.red)
            
            MyTextField(fieldText: $signUpViewModel.email, displayText: "Email")
                .onChange(of: signUpViewModel.email, perform: { value in
                    signUpViewModel.email = signUpViewModel.email.lowercased()
                })
            
            SecureField("Password", text: $signUpViewModel.password).padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding()
                .foregroundColor(Color.orange)
            
            SecureField("Confirm Password", text: $signUpViewModel.confirmPassword).padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding()
                .foregroundColor(Color.orange)
            
            
            HStack{
                Rectangle().frame(width: 130, height: 2, alignment: .center).padding(.leading, 5).foregroundColor(.purple)
                Text("+")
                Rectangle().frame(width: 130, height: 2, alignment: .center).foregroundColor(.purple)
            }.padding()
            
            
            MyButton(buttonText: "Sign Up", width: 300, height: 20){
                signUpViewModel.signIn()
            }.padding()
            Spacer()
            
            
        }
        .alert(isPresented:  $signUpViewModel.showAlert ){
            Alert(title: Text("\(signUpViewModel.alertMsg)" + "\(signUpViewModel.signUpResult)") , dismissButton: .destructive(Text("Confirm"), action: {
                if signUpViewModel.signUpResult {
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: MainTabView())
                }
            }))
        }
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
        .safeAreaPadding(.all)
        
    }
    
}

#Preview {
    AddUserView()
}
