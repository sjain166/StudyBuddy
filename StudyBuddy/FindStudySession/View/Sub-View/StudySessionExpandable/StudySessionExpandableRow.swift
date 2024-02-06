//
//  StudySessionExpandableRow.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation
import SwiftUI

struct StudySessionExpandableRow<Content: View>: View {
    
    var session : SessionModel
    @State private var isExpanded: Bool = false
    
    var content: () -> Content

    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                content()
            },
            label: {
                IndividualStudySessionView(studySessionData: session ).frame(minWidth: 400 , maxWidth: 200 , minHeight: 50, maxHeight:  80).frame(alignment: .center)
            }
        )
        .accentColor(.blue)
    }
}
