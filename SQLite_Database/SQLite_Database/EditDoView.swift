//
//  EditUserView.swift
//  SQLite_Database
//
//  Created by Micah Turpin on 6/17/22.
//

import SwiftUI
 
struct EditDoView: View {
     
    // id receiving of do from HomeFeed view
    @Binding var doID: Int64
     
    // variables to store value from input fields
    @State var doIDForEdit: String = ""
    @State var doNameInputValue: String = ""
    @State var dailyIDInputValue: String = ""
    @State var doStateInputValue: String = ""
    @State var doTimeInputValue: String = ""
    @State var doTimeOfDayInputValue: String = ""
     
    // to go back to homefeed view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
     
    var body: some View {
        VStack {
            // create doName field
            TextField("Edit Do Name", text: $doNameInputValue)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .autocapitalization(.none)
                .disableAutocorrection(true)
             
            // create dailyID field & number pad
            TextField("Edit Daily ID", text: $dailyIDInputValue)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
            
            // create doState field & number pad
            TextField("Edit Do State", text: $doStateInputValue)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
            
            // create doTime field
            // https://www.youtube.com/watch?v=3re8815lHxA for future time picker
            TextField("Enter Do Time", text: $doTimeInputValue)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            // create doTimeOfDay field
            TextField("Enter Do Time of Day (Morning, Afternoon, Evening)", text: $doTimeOfDayInputValue)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
             
            // button to update do
            Button(action: {
                // call function to update row in sqlite database
                DB_Manager().updateDo(doIDValue: Int64(self.doID),
                                      doNameValue: self.doNameInputValue,
                                      dailyIDValue: self.dailyIDInputValue,
                                      doStateValue: self.doStateInputValue,
                                      doTimeValue: self.doTimeInputValue,
                                      doTimeOfDayValue: self.doTimeOfDayInputValue)
 
                // go back to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Edit User")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
 
        // populate user's data in fields when view loaded
        .onAppear(perform: {
             
            // get data from database
            let doModel: DoModel = DB_Manager().getDo(doIDValue: self.doID)
             
            // populate in text fields
            self.doID = doModel.doID ?? 0
            self.doNameInputValue = doModel.doName
            self.dailyIDInputValue = doModel.dailyID
            self.doStateInputValue = doModel.doState
            self.doTimeInputValue = doModel.doTime
            self.doTimeOfDayInputValue = doModel.doTimeOfDay
        })
    }
}
 
struct EditDoView_Previews: PreviewProvider {
     
    // when using @Binding, do this in preview provider
    @State static var id: Int64 = 0
     
    static var previews: some View {
        EditDoView(doID: $id)
    }
}
