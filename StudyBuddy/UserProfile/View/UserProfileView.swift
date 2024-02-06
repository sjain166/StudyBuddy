//
//  UserProfileView.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/18/23.
//

import SwiftUI

struct UserProfileView: View {
    
    @StateObject var profileViewModel = UserProfileViewModel()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Customize the format as needed
        return formatter
    }()
    
    
    var body: some View {
        ZStack{
            VStack{
                RoundedRectangle(cornerRadius: 900).frame(width: 600, height: 600).foregroundColor(.purple).position(x:200, y:-200)
            }
            
            ZStack{
                Circle().stroke().frame(width: 200).position(x:200, y:-330)
                Image(systemName: "person.circle.fill").resizable().frame(width: 200, height: 200).position(x:200, y:150)
            }
            
            if let unwrappedData = profileViewModel.user?.fullName{
                Text("\(unwrappedData)").font(.largeTitle).padding().position(x:200, y:290).foregroundColor(.purple.opacity(0.9))
            }
            else{
                Text("**********").font(.largeTitle).padding().position(x:200, y:290).foregroundColor(.purple.opacity(0.9))
            }
            
        }
        Spacer()
        VStack{
            Form{
                Section{
                    HStack{
                        Text("Date Joined : ").foregroundColor(.brown)
                        if let unwrappedData = profileViewModel.user?.dateCreated{
                            Text("\(dateFormatter.string(from : unwrappedData))")
                        }
                        else{
                            Text("Failed to Fetch Data")
                        }
                        
                    }
                    
                    HStack{
                        Text("Active Session : ").foregroundColor(.brown)
                        if let unwrappedData = profileViewModel.user?.activeSession{
                            unwrappedData == "" ? Text("No Active Session") : Text("\(unwrappedData)")
                        }
                        else{
                            Text("Failed to Fetch Data")
                        }
                    }
                    
                    HStack{
                        Text("Registered Email : ").foregroundColor(.brown)
                        if let unwrappedData = profileViewModel.user?.email{
                            Text("\(unwrappedData)")
                        }
                        else{
                            Text("Failed to Fetch Data")
                        }
                    }
                    
                    HStack{
                        Text("Username : ").foregroundColor(.brown)
                        if let unwrappedData = profileViewModel.user?.username{
                            Text("\(unwrappedData)")
                        }
                        else{
                            Text("Failed to Fetch Data")
                        }
                    }
                }
            }.position(x:180, y:90).safeAreaPadding()
            MyButton(buttonText: "Logout", width: 300, height: 10){
                Task{
                    do{
                        //Alert Window With Confirmation
                        try profileViewModel.logOut()
                        
                    }catch{
                        print(error)
                        print("Log Out Failed")
                    }
                }
            }.safeAreaPadding()
            Spacer()
        }
        .alert(isPresented:  $profileViewModel.logOutStatus ){
            Alert(title: Text("\(profileViewModel.alertMessgae)") , dismissButton: .destructive(Text("Confirm"), action: {
                UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: LoginView())
            }))
        }
        .onAppear(){
            try? profileViewModel.loadCurrentUser()
        }
        
    }
}

#Preview {
    UserProfileView()
}
