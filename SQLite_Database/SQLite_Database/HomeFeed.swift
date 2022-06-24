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
                NavigationLink (destination: EditDoView(doID: self.$selectedDoId), isActive: self.$doSelected) {
                    EmptyView()
                }
         
                // create list view
                List {
                    ForEach(self.doModels) { (model) in
                 
                    // show do information
                    VStack {
                        Text("\(model.doID ?? 0)").frame(width: 300)
                        Text(model.doName).frame(width: 300)
                        Text("\(model.dailyID)").frame(width: 300)
                        Text("\(model.doState)").frame(width: 300)
                        Text(model.doTime).frame(width: 300)
                        Text(model.doTimeOfDay).frame(width: 300)
            
                        HStack {
                            // button to edit do
                            Button(action: {
                                self.selectedDoId = model.doID ?? 0
                                print("Select Do ID: ")
                                print(self.selectedDoId)
                                self.doSelected = true
                                print("Selected Do: ")
                                print(self.doSelected)
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
                                print("dbManager: ")
                                print(dbManager)
                     
                                // call delete function
                                dbManager.deleteDo(doIDValue: model.doID ?? 0)
                                print("ID of Do being deleted: ")
                                print(model.doID ?? 0)
                     
                                // refresh the do models array
                                self.doModels = dbManager.getDos()
                                print(self.doModels)
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
                    self.doModels = DB_Manager().getDos()
                    print(self.doModels)
                })
            .navigationBarTitle("Eachday Homefeed")
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
