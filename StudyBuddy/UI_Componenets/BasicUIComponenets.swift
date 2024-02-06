//
//  BasicUIComponenets.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/16/23.
//

import Foundation
import SwiftUI




// Button UI
struct MyButton: View {
    var buttonText: String
    var width: CGFloat
    var height : CGFloat
    var action: () -> Void

    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(buttonText)
                .frame(width: width, height: height)
                .foregroundColor(.white)
                .padding()
                .font(.custom("Avenir", size: 20))
                .background(Color.gray.opacity(0.4))
                .cornerRadius(20)
                .bold()
                
            
        }
    }
}


struct MyTextField: View {
    @Binding var fieldText : String
    @State var displayText : String

    var body: some View {
        TextField(displayText, text: $fieldText)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .padding()
    }
}




struct UIComponenetss : View {
    
    @State var yourBindingVariable : String = "123"
    
    var body : some View{
        
        Button("Plain Button") {
            // Button action
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.gray.opacity(0.4))
        .cornerRadius(20)
        .bold()
        
        Button("Gradient Button") {
            // Button action
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .leading, endPoint: .trailing))
        .foregroundColor(.white)
        .cornerRadius(10)
        
        
        Button(action: {
            // Button action
        }) {
            Text("Outlined Button")
                .foregroundColor(.black)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
        
        Button(action: {
            // Button action
        }) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .cornerRadius(10)
        }
        
        TextField("Placeholder", text: $yourBindingVariable)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .foregroundColor(.black)
        
        TextField("Placeholder", text: $yourBindingVariable)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            .foregroundColor(.black)
        
        
        HStack {
            Image(systemName: "person")
                .foregroundColor(.black)
            TextField("Username", text: $yourBindingVariable)
                .padding()
                .foregroundColor(.black)
        }
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
        .padding(.horizontal)
        
        SecureField("Password", text: $yourBindingVariable)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
            .padding(.horizontal)
            .foregroundColor(.black)
        
        Button("Bordered Button") {

        }.buttonStyle(.bordered)
        
        TextField("Enter text", text: $yourBindingVariable)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .padding()
    }
}

#Preview{
    UIComponenetss()
}
