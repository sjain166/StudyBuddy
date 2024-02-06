//
//  ActiveUserView.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation


//                    HStack{
//                        Text("Attendee").frame(alignment: .leading).font(.headline).padding(.trailing, 230)
//                    }
//                        .foregroundStyle(LinearGradient(colors: [.orange, .white], startPoint: .top, endPoint: .bottom))

//                    VStack {
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack{
//                                if viewModel.activeAtendee.count > 0{
//                                    ForEach( $viewModel.activeAtendee ){ i in
//                                        VStack{
//                                            Image(systemName: "person.crop.circle").resizable().frame(width: 20, height: 20)
//
//                                        }.padding(.all , 2)
//                                    }
//                                }
//                                else{
//                                    Text("Unable To Fetch  Active Student Data")
//                                }
//
//                            }
//                        }
//                        .padding()
//                    }
//                    .foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .trailing))
//                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 55, style: .continuous))
