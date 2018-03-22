//
//  ChatModel.swift
//  Foodie
//
//  Created by Youngjoon Park on 2018. 3. 21..
//  Copyright © 2018년 Foodie. All rights reserved.
//

import UIKit

class ChatModel: NSObject {

    public var users :Dictionary<String,Bool> = [:] //채팅방에 참여한 사람들
    public var comments :Dictionary<String,Comment> = [:] //채팅방의 대화내용
    
    public class Comment{
        public var uid : String?
        public var message : String?
    }
    
}
