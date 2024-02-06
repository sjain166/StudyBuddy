import Foundation
import SwiftUI


struct MainTabView : View {
    @State var selectedIndex : Int = 0
    
    var body : some View {
        TabView(selection : $selectedIndex){
            VStack{
                FindStudySessionView(selectedParentViewIndex: $selectedIndex)
            }
                .tabItem {
                    Label("Search" , systemImage: "magnifyingglass.circle.fill")
                }
                .tag(0)
            
            VStack{
                CurrentSessionView(parentSelectedIndex: $selectedIndex)
            }
            .tabItem {
                Label("Current Session" , systemImage: "person.circle.fill")
            }
            .tag(1)
            
            VStack{
                UserProfileView()
            }
            .tabItem {
                Label("Profile" , systemImage: "person.circle.fill")
            }
            .tag(2)
            
            
        }.onAppear(){
            UITabBar.appearance().backgroundColor = .quaternaryLabel
            UITabBar.appearance().scrollEdgeAppearance?.backgroundColor = .brown
            UITabBar.appearance().isTranslucent = false
            UITabBar.appearance().isOpaque = true
        }.safeAreaPadding()
        
    }
}


#Preview {
    MainTabView()
}
