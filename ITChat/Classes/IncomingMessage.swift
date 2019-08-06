//
//  IncomingMessage.swift
//  ITChat
//
//  Created by NeilPhung on 8/6/19.
//  Copyright © 2019 NeilPhung. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class IncomingMessage {
    var collectionView: JSQMessagesCollectionView
    
    init(collectionView_ : JSQMessagesCollectionView) {
        self.collectionView = collectionView_
    }
    
    //MARK: CreateMessage
    
    func createMessage(messageDictionary: NSDictionary, chatRoomId: String) -> JSQMessage? {
        var message: JSQMessage?
        
        let type = messageDictionary[kTYPE] as! String
        
        switch type {
        case kTEXT:
           message = createTextMessage(messageDicnationary: messageDictionary, chatRoomId: chatRoomId)
        case kPICTURE:
           print("create kPICTURE message")
        case kVIDEO:
          print("create kVIDEO message")
        case kAUDIO:
             print("create kAUDIO message")
        case kLOCATION:
             print("create kLOCATION message")
        default:
            print("unknown message type")
        }
        
        if message != nil {
            return message
        }
        return nil
    }
    
    
    //MARK: Create Message types
    
    func createTextMessage(messageDicnationary: NSDictionary, chatRoomId: String) -> JSQMessage {
        
        let name = messageDicnationary[kSENDERNAME] as? String
        let userId = messageDicnationary[kSENDERID] as? String
        
        var date: Date!
        
        if let created = messageDicnationary[kDATE] {
            if (created as! String).count != 14{
                date = Date()
            }
            else {
                date = DateFormatter().date(from: created as! String)
            }
        }
        
        else {
            date = Date()
        }
        
        let text = messageDicnationary[kMESSAGE] as! String
        
        return JSQMessage(senderId: userId, senderDisplayName: name, date: date, text: text)
    }
}
