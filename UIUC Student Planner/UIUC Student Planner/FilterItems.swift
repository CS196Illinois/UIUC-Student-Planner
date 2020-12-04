//
//  FilterItems.swift
//  UIUC Student Planner
//
//  Created by Jathin Nama on 12/1/20.
//

import SwiftUI
class Order: ObservableObject {
    @Published var minPoints = (4, false)
    @Published var isPinned: Bool
    @Published var maxPoints = (4, false)
    init() {
        isPinned = false
    }
    public  func isNotFiltered(assignment: Assignment) -> Bool {
//        if(selectedSorts == "Min Points") {
//            minPoints.1 = true
//            if (minPoints.1 && assignment.points > minPoints.0) { return true }
//        }
        if (isPinned) {
            if(assignment.pinned == true) {return true}
        }
//        if ( selectedSorts == "None") {
//            return true;
//        }
        return true;
    }
}

