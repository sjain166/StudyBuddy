//
//  SplashScreen.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 10/23/23.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State var userAuthenticated = false
    
    
    var body: some View {
        
        if isActive {
            if !userAuthenticated {
                LoginView()
            }
            else{
                MainTabView()
            }
        }
        else{
            ZStack{
                Color.white.ignoresSafeArea()
                VStack{
                    Image("Logo")
                        .font(.system(size: 80))
                        .padding()
                    Text("Study Buddy")
                        .font(Font.custom("Baskerville-Bold", size: 70))
                        .foregroundColor(.black.opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = true
                }
                
                let authUser = try? AuthenticationManager.sharedAuth.getAuthenticatedUser()
                self.userAuthenticated = authUser == nil ? false : true
                
            }
        }
        
    }
}

#Preview {
    SplashScreenView()
}
