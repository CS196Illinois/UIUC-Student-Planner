//
//  AssignmentView.swift
//  UIUC Student Planner
//
//  Created by Matthew Geimer on 10/7/20.
//

import SwiftUI

struct AssignmentView: View {
    //Viewcontext for the database
    @Environment(\.managedObjectContext) private var viewContext
    @State var isPresented = false
    //The assignment passed in from the parent view
    @State var assignment: Assignment
    
    var body: some View {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text((assignment.name ?? "Test Assignment"))
                                .font(.largeTitle)
                            .fontWeight(.medium)
                    Spacer()
                    //Text("📌")
                        if assignment.pinned == true {
                        Text("📌")
                        }
                    }
                    VStack(alignment: .leading, spacing: 5) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(assignment.dueDate ?? Date(), formatter: dayFormatter)")
                            Spacer()
                            Text("\(assignment.points) Points")
                                .foregroundColor(Color.green)
                        }
                        VStack (spacing: 30) {
                        HStack {
                            Text("\(assignment.dueDate ?? Date(), formatter: timeFormatter)  ")
                            Spacer()
                            Text("\( assignment.priority ) Priority ").foregroundColor(.red)
                        }
                            Text("Description: \( assignment.userDescription ?? "Description has not been provided.") ").multilineTextAlignment(.center)
                        }
                        
                        Text("\(assignment.dueDate ?? Date(), formatter: timeFormatter)")
                    }.toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Edit", action: {
                            self.isPresented.toggle();
                        })
                    }
                }
                .sheet(isPresented: $isPresented, content: {
                    EditAssignmentView(item: assignment)
                })
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
       
    
    private let dayFormatter: DateFormatter = {
        //Starter code, feel free to remove this based on that the assignment entry data has
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        return formatter
    }()
    
    private let timeFormatter: DateFormatter = {
        //Starter code, feel free to remove this based on that the assignment entry data has
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()
}

struct AssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentView(assignment: Assignment(context: PersistenceController.preview.container.viewContext))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            
    }
}
