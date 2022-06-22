//
//  AddUserView.swift
//  SQLite_Database
//
//  Created by Micah Turpin on 6/16/22.
//

import SwiftUI
 
struct AddDoView: View {
     
    // create variables to store do input values
    @State var doNameInputValue: String = ""
    @State var dailyIDInputValue: String = ""
    @State var doTimeInputValue: String = ""
    @State var doTimeOfDayInputValue: String = ""
     
    // to go back on the home feed when the do is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
     
    var body: some View {
         
        VStack {
            // create doName field
            TextField("Enter Do Name", text: $doNameInputValue)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            // create doTime field
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
             
            // button to add a do
            Button(action: {
                // call function to add row in sqlite database
                DB_Manager().addDo(doNameValue: self.doNameInputValue, doTimeValue: self.doTimeInputValue, doTimeOfDayValue: self.doTimeOfDayInputValue)
                 
                // go back to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Add Do")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
         
    }
}
