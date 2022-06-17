//
//  ContentView.swift
//  SQLite_Database
//
//  Created by Micah Turpin on 6/16/22.
//

import SwiftUI

struct ContentView: View {
    
    // array of user models
    @State var userModels: [UserModel] = []
    
    // check if user is selected for edit
    @State var userSelected: Bool = false
     
    // id of selected user to edit or delete
    @State var selectedUserId: Int64 = 0
    
    var body: some View {
        
        // create navigation view
        NavigationView {
         
            VStack {
         
                // create link to add user
                HStack {
                    Spacer()
                    NavigationLink (destination: AddUserView(), label: {
                        Text("Add user")
                    })
                }
                
                // navigation link to go to edit user view
                NavigationLink (destination: EditUserView(id: self.$selectedUserId), isActive: self.$userSelected) {
                    EmptyView()
                }
         
                // list view goes here
                List (self.userModels) { (model) in
                 
                    // show name, email and age horizontally
                    HStack {
                        Text(model.name)
                        Spacer()
                        Text(model.email)
                        Spacer()
                        Text("\(model.age)")
                        Spacer()
                 
                        // button to edit user
                        Button(action: {
                            self.selectedUserId = model.id
                            self.userSelected = true
                        }, label: {
                            Text("Edit")
                                .foregroundColor(Color.blue)
                            })
                            // by default, buttons are full width.
                            // to prevent this, use the following
                            .buttonStyle(PlainButtonStyle())
                        
                        // button to delete user
                        Button(action: {
                 
                            // create db manager instance
                            let dbManager: DB_Manager = DB_Manager()
                 
                            // call delete function
                            dbManager.deleteUser(idValue: model.id)
                 
                            // refresh the user models array
                            self.userModels = dbManager.getUsers()
                        }, label: {
                            Text("Delete")
                                .foregroundColor(Color.red)
                        })// by default, buttons are full width.
                        // to prevent this, use the following
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
            }.padding()
                .onAppear(perform: {
                    self.userModels = DB_Manager().getUsers()
                })
            .navigationBarTitle("SQLite Sandbox")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
