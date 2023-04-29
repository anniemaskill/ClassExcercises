//
//  Location.swift
//  FinalProject
//
//  Created by Annie on 4/29/23.
//

import Foundation
import FirebaseFirestoreSwift


struct Location: Identifiable, Codable {
    @DocumentID var id: String?
    var city = ""
    var state = ""
    
    var dictionary: [String: Any] {
        return ["city": city, "state": state]
    }
}
