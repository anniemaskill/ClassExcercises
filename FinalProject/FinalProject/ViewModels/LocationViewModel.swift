//
//  LocationViewModel.swift
//  FinalProject
//
//  Created by Annie on 4/29/23.
//

import Foundation
import FirebaseFirestore

@MainActor

class LocationViewModel: ObservableObject {
    @Published var location = Location()
    
    func saveLocation(location: Location) async -> Bool {
        let db = Firestore.firestore()
        
        if let id = location.id { // location must already exist, so save
            do {
                try await db.collection("locations").document(id).setData(location.dictionary) // "locations" is name of the collection
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not update data in 'location' \(error.localizedDescription)")
                return false
            }
        } else { // no id? Then this much be a new location to add
            do {
                let _ = try await db.collection("locations").addDocument(data: location.dictionary)
        
                print("🐣 Data added successfully")
                return true
            } catch {
                print("😡 ERROR: Could not update data in 'location' \(error.localizedDescription)")
                return false
            }
        }
    }
}
