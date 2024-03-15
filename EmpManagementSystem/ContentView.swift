//
//  ContentView.swift
//  EmpManagementSystem
//
//  Created by MacBook Pro on 09/02/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject private var employeeManager = EmployeeManager()
    @State private var Add_View_Edit_Mode: Add_View_Edit = .add
    @State private var isEditing = false
    @State private var selectedEmployee: Employee?
    
    var body: some View {
        NavigationView {
            VStack {
                List(employeeManager.allEmployeesList, id: \.self) { user in
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 50.0, height: 50.0)
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.designation)
                        }
                        Spacer()
                        Button {
                            // Handle edit action for this specific user
                            // For example:
                            selectedEmployee = user
                            isEditing = true
                            Add_View_Edit_Mode = .edit
                        } label:{
                            Image(systemName: "pencil.circle")
                                .resizable()
                                .frame(width: 25.0, height: 25.0)
                        }
                        Button {
                            selectedEmployee = user
                            isEditing = true
                            Add_View_Edit_Mode = .viewDetails
                        } label: {
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 25.0, height: 25.0)
                        }
                    }
                    
                }
                .sheet(isPresented: $isEditing, onDismiss: {
                    // Reset selectedEmployee and isEditing when the sheet is dismissed
                    selectedEmployee = nil
                    isEditing = false
                }) {
                    // Present the AddEmployee view with the appropriate mode
                    AddEmployee(employee_Mode: Add_View_Edit_Mode, selected_employee: selectedEmployee)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom)
                .navigationTitle("People")
                
                .toolbar {
                    NavigationLink(destination: AddEmployee(employee_Mode: .add)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .environmentObject(employeeManager)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
