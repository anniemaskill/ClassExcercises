//
//  Host.swift
//  FinalProject
//
//  Created by Annie on 4/25/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Host: Identifiable, Codable {
    @DocumentID var id: String?
    
    var review = ""
    var vote = 0
    var user = Auth.auth().currentUser?.email ?? ""
    var postedOn = Date()
    var isCompleted = false
   
    
    
    
    var dictionary: [String: Any] {
        return ["review": review, "vote": vote, "user": user, "postedOn": Timestamp(date: Date())]
    }
    
}

