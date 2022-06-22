//
//  HomeFeed.swift
//  SQLite_Database
//
//  Created by Micah Turpin on 6/17/22.
//

import SwiftUI

struct HomeFeed: View {
    
    // array of do models
    @State var doModels: [DoModel] = []
    
    // check if do is selected for edit
    @State var doSelected: Bool = false
     
    // id of selected do to edit or delete
    @State var selectedDoId: Int64 = 0
    
    var body: some View {
        
        // create navigation view
        NavigationView {
         
            VStack {
         
                // create link to add user
                HStack {
                    Spacer()
                    NavigationLink (destination: AddDoView(), label: {
                        Text("Add Do")
                    })
                }
                
                // navigation link to go to edit do view this is a test for git
                NavigationLink (destination: EditDoView(id: self.$selectedDoId), isActive: self.$doSelected) {
                    EmptyView()
                }
         
                // create list view
                List {
                    ForEach(self.doModels) { (model) in
                 
                    // show name, email and age horizontally
                    VStack {
                        Group { // doID group (need groups because SwiftUI doesn't allow more than 10 static objects in a view)
                            Text("\(model.doID)").frame(width: 300)
                            Spacer()
                        }; Group { // doName group
                            Text(model.doName).frame(width: 300)
                            Spacer()
                        }; Group { // dailyID group
                            Text("\(model.dailyID)").frame(width: 300)
                            Spacer()
                        }; Group { // doState group
                            Text("\(model.doState)").frame(width: 300)
                            Spacer()
                        }; Group { // doTime group
                            Text(model.doTime).frame(width: 300)
                            Spacer()
                        }; Group { // doTimeOfDay group
                            Text(model.doTimeOfDay).frame(width: 300)
                            Spacer()
                        }
                
                        HStack {
                            // button to edit do
                            Button(action: {
                                self.selectedDoId = model.doID
                                self.doSelected = true
                            }, label: {
                                Text("Edit This Do")
                                    .foregroundColor(Color.blue)
                                })
                                // to keep button from defaulting to full-width
                                .buttonStyle(PlainButtonStyle())
                            
                            // button to delete do
                            Button(action: {
                     
                                // create db manager instance
                                let dbManager: DB_Manager = DB_Manager()
                     
                                // call delete function
                                dbManager.deleteDo(doIDValue: model.doID)
                     
                                // refresh the do models array
                                self.doModels = dbManager.getDos()()
                            }, label: {
                                Text("Delete This Do")
                                    .foregroundColor(Color.red)
                            })
                            // to keep button from defaulting to full-width
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                }
            }.padding()
                .onAppear(perform: {
                    self.doModels = DB_Manager().getDos()()
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
