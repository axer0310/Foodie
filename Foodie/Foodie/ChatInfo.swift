//
//  ChatInfo.swift
//  Foodie
//
//  Created by Youngjoon Park on 2018. 3. 22..
//  Copyright © 2018년 Foodie. All rights reserved.
//

import Foundation

import Firebase

//class REF
//{
//
//    var path = ""
//
//    static let databaseRoot = Database.database().reference()
//    static let databaseChats = databaseRoot.child("chats")
//}



struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
