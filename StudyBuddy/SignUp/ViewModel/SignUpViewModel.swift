//
//  SignUpViewModel.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation
import SwiftUI

@MainActor
final class SignInEmailViewModel : ObservableObject {
    
    @Published var fullName = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var selectedImage: UIImage?
    @Published var signUpResult = false
    @Published var alertMsg = ""
    @Published var showAlert = false
    @Published var photURL = ""
    
    func signIn(){
        guard !email.isEmpty , !password.isEmpty, password == confirmPassword else{
            alertMsg = "Sign-Up Failed for the following reason : " + "\n\n" + "1. Empty Fields \n 2. Password did not match \n 3. Too Short Password \n 4. Email Already Existed"
            showAlert.toggle()
            return
        }
        
        Task{
            do{
                let returnedUser = try await AuthenticationManager.sharedAuth.createUser(email: email, password: password)
                let newUser : UserDataModel = UserDataModel(activeSession: "" , username: username, fullName: fullName, userAuthObject: returnedUser, URL: photURL, dateCreated: Date())
                try await UserManager.shared.createNewUser(user: newUser)
                
                signUpResult = true
                alertMsg = "Sign-Up Successful !"
                showAlert.toggle()
                
            }catch{
                print(error)
                alertMsg = "Sign-Up Failed for the following reason : " + "\n" + "1. Empty Fields , 2. Password did not match, 3. Too Short Password , 4. Email Already Existed"
                showAlert.toggle()
            }
        }
    }
    
}
