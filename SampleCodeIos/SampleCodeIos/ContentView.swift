//
//  ContentView.swift
//  SampleCodeIos
//
//  Created by Hổ's Macbook on 11/10/2024.
//

import SwiftUI
import CoreData
// ContentView is a SwiftUI View that displays a list of items fetched from Core Data.
// It allows users to add and delete items from the list.
struct ContentView: View {
    // Environment variable to access the managed object context.
    @Environment(\.managedObjectContext) private var viewContext

    // Fetch request to retrieve items from Core Data, sorted by timestamp.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    // The body of the view, which includes a navigation view with a list of items.
    var body: some View {
        NavigationView {
            List {
                // ForEach loop to iterate over the fetched items and display them in the list.
                ForEach(items) { item in
                    NavigationLink {
                        // Detail view for each item, displaying its timestamp.
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        // List item displaying the timestamp of each item.
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                // onDelete modifier to handle deletion of items from the list.
                .onDelete(perform: deleteItems)
            }
            // Toolbar with buttons for editing and adding items.
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                #endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            // Placeholder text when no items are selected.
            Text("Select an item")
        }
    }

    // Function to add a new item to the list.
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Error handling for saving the new item.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    // Function to delete items from the list.
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Error handling for deleting items.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// DateFormatter for formatting dates in the list.
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// Preview provider for ContentView.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
