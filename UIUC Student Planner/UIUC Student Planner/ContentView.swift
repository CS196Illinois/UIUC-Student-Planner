 
import SwiftUI
import CoreData

extension Color {
    
    public static var ListBackground: Color {
        return Color(decimalRed: 19, green: 41 , blue: 75 )
    }
    
}



struct ContentView: View {
    //Viewcontext for the database
    @Environment(\.managedObjectContext) private var viewContext
    
    //The fetch request getting all the assignments and sorting them by their timestamps
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Assignment.pinned, ascending: false),
            NSSortDescriptor(keyPath: \Assignment.dueDate, ascending: false)
        ],
        animation: .default)
    private var items: FetchedResults<Assignment>
    var test = "hello"
    @State private var showingDetail = false
    @State private var showingFilters = false
    @State private var sort: Int = 0
    @State private var isPinned = Order()
    private var filters = ["None","Min Points", "Pinned", "Max Points"]
    var body: some View {
        let FilterObject = Order();
        NavigationView {
            List {
                ForEach(items) { item in
                    if (FilterObject.isNotFiltered(assignment: item, selectedSorts: filters[sort])) {
                        NavigationLink(destination:AssignmentView(assignment: item)) {
                            HStack {
                                
                                AssignmentAttributes(assignment: item)
                                    .cornerRadius(15)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 7)
                                    .foregroundColor(.white)
                            }
                            
                        }
                        }
                }
                .onDelete(perform: deleteItems)
                .background(Color.ListBackground)
                .cornerRadius(15)
            }
            .navigationTitle("UIUC Student Planner")
            .navigationBarTitleDisplayMode(.inline)
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {self.showingDetail.toggle()}) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
               
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Picker(selection: $sort, label: Text("Sorting options")) {
//                            Button(action: {selectedSorts.append("MinPoint")}) {
//                                Label("Min Points", systemImage: "bolt")
//                            }
//                            Button(action: {}) {
//                                Label("Create a folder", systemImage: "folder")
//                            }
                            ForEach(0 ..< filters.count) {
                               Text(self.filters[$0])
                            }
                        }
                    }
                    label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
            }
            }
        }
        .sheet(isPresented: $showingDetail) {
            AddAssignmentView()
        }
//        .sheet(isPresented: $showingFilters) {
//            FilterModalView(isPinned: $isPinned)
//        }
    }
    
    private func addSort(sort: String) {
       
    }
    private func addItem() {
        withAnimation {
            let newItem = Assignment(context: viewContext)
            newItem.dueDate = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Matt's Note: Ignore this, it shouldn't matter
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Matt's Note: Ignore this, it shouldn't matter
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

