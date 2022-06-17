//
//  UserModel.swift
//  SQLite_Database
//
//  Created by Micah Turpin on 6/16/22.
//

import Foundation

class UserModel: Identifiable {
    public var id: Int64 = 0
    public var name: String = ""
    public var email: String = ""
    public var age: Int64 = 0
}
