//
//  LoginViewModel.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var loginStatus = false
    @Published var isForgotPassword : Bool = false
    @Published var goToAddUserView : Bool = false
    @Published var loginFailedAlert = false
    @Published var quote = "Loading..."
    @Published var author = "Author"
    
    func authenticateUser() throws {
        guard !username.isEmpty , !password.isEmpty else{
            loginFailedAlert = true
            print("Empty Fields")
            return
        }
        Task{
            do{
                try await AuthenticationManager.sharedAuth.signIn(email: self.username , password: self.password)
                loginStatus = true
            }catch{
                print("Login Failed")
                print(error)
                loginFailedAlert = true
            }
        }
    }
    
    func fetchData() {
        guard let url = URL(string: "https://zenquotes.io/api/quotes/today") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    
                    if let quoteData = result?.first {
                        DispatchQueue.main.async {
                            self.quote = quoteData["q"] as? String ?? "No quote"
                            self.author = quoteData["a"] as? String ?? "Unknown author"
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
}
