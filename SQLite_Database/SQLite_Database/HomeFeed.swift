//
//  HomeFeed.swift
//  SQLite_Database
//
//  Created by Micah Turpin on 6/17/22.
//

import SwiftUI

struct HomeFeed: View {
    
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
                
                // navigation link to go to edit user view this is a test for git
                NavigationLink (destination: EditUserView(id: self.$selectedUserId), isActive: self.$userSelected) {
                    EmptyView()
                }
         
                // list view goes here
                List (self.userModels) { (model) in
                 
                    // show name, email and age horizontally
                    VStack {
                        Spacer()
                        Text(model.name).frame(width: 300)
                        Spacer()
                        Text(model.email).frame(width: 300)
                        Spacer()
                        Text("\(model.age)").frame(width: 300)
                        Spacer()
                 
                        
                        HStack {
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
                }
                
            }.padding()
                .onAppear(perform: {
                    self.userModels = DB_Manager().getUsers()
                })
            .navigationBarTitle("Eachday Homefeed")
        }
        
    }
}

struct HomeFeed_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeFeed()
            HomeFeed()
        }
    }
}
