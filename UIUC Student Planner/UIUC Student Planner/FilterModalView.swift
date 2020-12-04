//
//  FilterModalView.swift
//  UIUC Student Planner
//
//  Created by Jathin Nama on 12/3/20.
//

import SwiftUI

struct FilterModalView: View {
    var filters = ["None", "Min Points", "Pinned"]
    @Binding var isPinned: Order
    var body: some View {
        List{
            Toggle("Pinned Assignments", isOn:$isPinned.isPinned )
        }
    }
}
struct FilterModalView_Previews_Wrapper: View {
    @State var varA = Order()
    var body: some View {
        FilterModalView(isPinned: $varA)
    }
}
struct FilterModalView_Previews: PreviewProvider {
    static var previews: some View {
        FilterModalView_Previews_Wrapper()
    }
}
