import MapKit

import MapKit
import SwiftUI

struct MapView: View {
    
    @StateObject var viewModel = MapViewModel()
    @Binding var sessionLocation : String
    
    var body: some View {
        VStack{
            Map(position: $viewModel.cameraPostion){
                Annotation("My Location" , coordinate: .userLocation){
                    ZStack{
                        Circle().frame(width:12, height: 12).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/.opacity(0.25))
                        Circle().frame(width:6, height: 6).foregroundColor(.white)
                        Circle().frame(width:2, height: 2).foregroundColor(.blue)
                    }
                }
                Marker(sessionLocation , coordinate: viewModel.selectionLocation)
            }
        }.onAppear{
            viewModel.setMapView(cityName: sessionLocation)
        }.onChange(of: sessionLocation){
            viewModel.setMapView(cityName: sessionLocation)
        }
        
    }
    

}


#Preview {
    MapView(sessionLocation: .constant("Phoenix"))
}
