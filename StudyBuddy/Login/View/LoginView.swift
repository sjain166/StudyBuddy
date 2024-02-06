import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel : LoginViewModel = LoginViewModel()
    
    
    
    var body: some View {
        
        NavigationView{
            VStack{
                VStack{
                    Image("LoginGraphic")
                        .resizable()
                        .frame(width: 430, height: 200)
                        .scaledToFit()
                    
                    Text("Study Buddy Locator")
                        .font(.largeTitle).bold().padding(.bottom , 1)
                    
                    Text("Find The Perfect Study Buddy Near You")
                        .font(.subheadline).bold().foregroundStyle(.purple)
                
                    
                }.position(x:183, y:60)
                
                
                VStack{
                    
                    VStack{
                        Text("\"\(loginViewModel.quote)\"")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.red)
                            .padding([.top])
                            .fixedSize(horizontal: false, vertical: true)
                              // Enable multiline consumption

                        Text("-\(loginViewModel.author)")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.red)
                            .lineLimit(nil)  // Enable multiline consumption
                    }
                    
                    HStack{
                        Image(systemName: "person.fill").resizable().frame(width: 30, height: 30)
                        MyTextField(fieldText: $loginViewModel.username, displayText: "E-Mail")
                        
                        
                    }.padding(.bottom , -15)
                    
                    HStack{
                        Image(systemName: "key.viewfinder").resizable().frame(width: 30, height: 30)
                        SecureField("Password", text: $loginViewModel.password)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                            .padding()
                        
                    }
                    
                    Button("Forgot Username/Password ? "){
                        
                        //Open the Forgot Password View
                        loginViewModel.isForgotPassword.toggle()
                        
                    }.padding(.leading, 120).foregroundColor(.red)
                }
                Spacer()
                
                
                MyButton(buttonText: "Log In", width: 300, height: 10){
                    do{
                        try loginViewModel.authenticateUser()
                    }catch{
                        print("Login Failed")
                    }
                    
                }.padding(.top, 20)
                
                HStack{
                    Rectangle().frame(width: 130, height: 2, alignment: .center).padding(.leading, 9).foregroundColor(.gray)
                    Text("OR")
                    Rectangle().frame(width: 130, height: 2, alignment: .center).foregroundColor(.gray)
                }.padding()
                
                
                HStack{
                    Text("Don't have an account ? ")
                        .font(.subheadline).bold().foregroundStyle(.white)
                    
                    NavigationLink(destination: AddUserView(), isActive: $loginViewModel.goToAddUserView) {
                        Button("Sign Up") {
                            loginViewModel.goToAddUserView.toggle()
                        }
                        .padding(.leading, 10)
                        .foregroundColor(.green)
                    }
                }
            }
            .sheet(isPresented: $loginViewModel.isForgotPassword) {
                ForgetPasswordView().presentationDetents([.height(500)]).presentationCornerRadius(100).preferredColorScheme(.dark)
            }
            .safeAreaPadding()
        }
        .fullScreenCover(isPresented: $loginViewModel.loginStatus){
            MainTabView()
        }
        .onAppear{
            loginViewModel.fetchData()
        }
        .alert(isPresented: $loginViewModel.loginFailedAlert , content: {
            Alert(title: Text("Incorrect Username | Password , Please Try Again"))
        })
        
    }
}

#Preview {
    LoginView()
}
