//
//  UserModel.swift
//  SQLite_Database
//
//  Created by Micah Turpin on 6/16/22.
//

import Foundation

class DoModel: Identifiable {
    public var doID: Int64?
    public var doName: String = ""
    public var dailyID: String = ""
    public var doState: String = ""
    public var doTime: String = ""
    public var doTimeOfDay: String = ""
}
