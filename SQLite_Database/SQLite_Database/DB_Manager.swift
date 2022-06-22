//
//  DB_Manager.swift
//  SQLite_Database
//
//  Created by Micah Turpin on 6/16/22.
//

import Foundation

// import library
import SQLite
 
class DB_Manager {
     
    // sqlite instance
    private var db: Connection!
     
    // table instance
    private var doMaster: Table!
 
    // defining column variables for initializing later
    private var doID: Expression<Int64>!
    private var doName: Expression<String>!
    private var dailyID: Expression<String>!
    private var doState: Expression<String>!
    private var doTime: Expression<String>!
    private var doTimeOfDay: Expression<String>!
     
    // constructor of DB_Manager class
    init () {
         
        // exception handling
        do {
             
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
 
            // creating database connection
            db = try Connection("\(path)/do_info.sqlite3")
             
            // creating table object
            doMaster = Table("doMaster")
             
            // create instances of each column
            doID = Expression<Int64>("do id")
            doName = Expression<String>("do name")
            dailyID = Expression<String>("daily id")
            doState = Expression<String>("do state")
            doTime = Expression<String>("do time")
            doTimeOfDay = Expression<String>("do time of day")
             
            // check if the do's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
 
                // if not, then create the table
                try db.run(doMaster.create { (t) in
                    t.column(doID, primaryKey: true)
                    t.column(doName)
                    t.column(dailyID, unique: true)
                    t.column(doState)
                    t.column(doTime)
                    t.column(doTimeOfDay)
                })
                 
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
             
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
         
    }
    
    // function to add a do to the doMaster table in the database
    public func addDo(doNameValue: String, doTimeValue: String, doTimeOfDayValue: String) {
        do {
            try db.run(doMaster.insert(doName <- doNameValue, doTime <- doTimeValue, doTimeOfDay <- doTimeOfDayValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // return array of do models
    public func getDos() -> [DoModel] {
         
        // create empty array
        var doModels: [DoModel] = []
     
        // get all dos in descending order
        doMaster = doMaster.order(doID.desc)
     
        // exception handling
        do {
     
            // loop through all dos
            for eachDo in try db.prepare(doMaster) {
     
                // create new model in each loop iteration
                let doModel: DoModel = DoModel()
     
                // set values in model from database
                doModel.doID = eachDo[doID]
                doModel.doName = eachDo[doName]
                doModel.dailyID = eachDo[dailyID]
                doModel.doState = eachDo[doState]
                doModel.doTime = eachDo[doTime]
                doModel.doTimeOfDay = eachDo[doTimeOfDay]
     
                // append in new array
                doModels.append(doModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return doModels
    }
    
    // get single do data for editing
    public func getDo(doIDValue: Int64) -> DoModel {
     
        // create an empty object
        let doModel: DoModel = DoModel()
         
        // exception handling
        do {
     
            // get do using ID
            let eachDo: AnySequence<Row> = try db.prepare(doMaster.filter(doID == doIDValue))
     
            // get row
            try eachDo.forEach({ (rowValue) in
     
                // set values in model
                doModel.doID = try rowValue.get(doID)
                doModel.doName = try rowValue.get(doName)
                doModel.dailyID = try rowValue.get(dailyID)
                doModel.doState = try rowValue.get(doState)
                doModel.doTime = try rowValue.get(doTime)
                doModel.doTimeOfDay = try rowValue.get(doTimeOfDay)
            })
        } catch {
            print(error.localizedDescription)
        }
     
        // return model
        return doModel
    }
    
    // function to update do
    public func updateDo(doIDValue: Int64, doNameValue: String, dailyIDValue: String, doStateValue: String, doTimeValue: String, doTimeOfDayValue: String) {
        do {
            // get do using ID
            let eachDo: Table = doMaster.filter(doID == doIDValue)
             
            // run the update query
            try db.run(eachDo.update(doID <- doIDValue, doName <- doNameValue, dailyID <- dailyIDValue, doTime <- doTimeValue, doTimeOfDay <- doTimeOfDayValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // function to delete do
    public func deleteDo(doIDValue: Int64) {
        do {
            // get do using ID
            let eachDo: Table = doMaster.filter(doID == doIDValue)
             
            // run the delete query
            try db.run(eachDo.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // function to update do state
    public func updateDoState(doIDValue: Int64, doStateValue: String) {
        do {
            // get do using ID
            let eachDo: Table = doMaster.filter(doID == doIDValue)
                
            // run the complete query
            try db.run(eachDo.update(doState <- doStateValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
