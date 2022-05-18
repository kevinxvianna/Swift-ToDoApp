//
//  ContentView.swift
//  ToDo List
//
//  Created by kevin.quinalia on 18/05/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var taskStore = TaskStore()
    @State var newTask: String = ""
    
    var insertBar: some View {
        HStack {
            TextField("Insert a new task", text: self.$newTask)
            Button(action: self.handleAddNewTask, label: {Text("Add")})
        }
    }
    
    func handleAddNewTask() {
        if(self.newTask.count == 0) {
            return
        }
            
        taskStore.tasks.append(TaskType(id: String(taskStore.tasks.count + 1), task: self.newTask))
        self.newTask = ""
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 8)
                insertBar
                    .padding(.top, 24)
                    .padding(.horizontal, 24)
                List {
                    ForEach(self.taskStore.tasks) {
                        index in
                        Text(index.task)
                    }
                    .onMove(perform: self.handleMove)
                    .onDelete(perform: self.handleDelete)
                }
                
            }
            .navigationTitle("To Do List")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    func handleMove(from source: IndexSet, to destination: Int) {
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func handleDelete (at offset: IndexSet) {
        taskStore.tasks.remove(atOffsets: offset)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
