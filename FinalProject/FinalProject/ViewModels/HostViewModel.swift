//
//  BucketListViewModel.swift
//  FinalProject
//
//  Created by Annie on 4/25/23.
//

import Foundation
import FirebaseFirestore 

class HostViewModel: ObservableObject {
    @Published var host = Host()
//    @Published private var showingAlert = false
    
    func saveHost(location: Location, host: Host) async -> Bool {
        let db = Firestore.firestore()
        
        guard let locationID = location.id else {
            print("😡 ERROR: location.id = nil")
            return false
        }
        
        let collectionString = "locations/\(locationID)/hosts"
        
        if let id = host.id { // location must already exist, so save
            do {
                try await db.collection(collectionString).document(id).setData(host.dictionary) // "hosts" is name of the collection
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not update data in 'hosts' \(error.localizedDescription)")
                return false
            }
        } else { // no id? Then this much be a new location to add
            do {
                _ = try await db.collection(collectionString).addDocument(data: host.dictionary)
                print("🐣 Data added successfully")
                return true
            } catch {
                print("😡 ERROR: Could not update data in 'hosts' \(error.localizedDescription)")
                return false
            }
        }
    }
    
    func deleteHost(location: Location, host: Host) async {
        let db = Firestore.firestore()
        
        let locationID = location.id
        
        let collectionString = "locations/\(locationID ?? "")/hosts"
        guard let id = host.id else {
            print("😡 ERROR: Could not delete document \(host.id ?? "No ID!")")
            return
        }
        do {
            let _ = try await db.collection(collectionString).document(id).delete()
            print("🗑 Document successfully removed!")
        } catch {
            print("😡 ERROR: removing document \(error.localizedDescription)")
        }
    }
    
    func toggleCompleted(location: Location, host: Host){
        // Don't try to update if location.id == nil
        guard host.id != nil else {return}
        // copy review (a constant) into a newReview (var) so we can update the isCompleted property
        var newHost = host
        newHost.isCompleted.toggle() // flips false to true and true to false
        // find the ID for new ToDo in the array of toDos, then update the element at that index with the data in newToDo
        //        if let index = location.firstIndex(where: {$0.id == newHost.id}){
        //            location[index] = newHost
        //        }
        Task{
            let success = await saveHost(location: location, host: host)
            if success {
                return
            } else {
                print("😡 ERROR saving data in HostDetailView")
            }
        }
    }
}







//        let db = Firestore.firestore()
//
//        guard let locationID = location.id else {
//            print("😡 ERROR: location.id = nil")
//            return false
//        }
//
//        let collectionString = "places/\(locationID)/hosts"
//
//        if let id = host.id { // location must already exist, so save
//            do {
//                try await db.collection(collectionString).document(id).setData(host.dictionary) // "places" is name of the collection in firebase
//                print("😎 Data updated successfully!")
//                return true
//            } catch {
//                print("😡 ERROR: Could not update data in 'hosts' \(error.localizedDescription)")
//                return false
//            }
//        } else { // no id? Then this much be a new location to add
//            do {
//                try await db.collection(collectionString).addDocument(data: host.dictionary)
//                print("🐣 Data added successfully")
//                return true
//            } catch {
//                print("😡 ERROR: Could not update data in 'hosts' \(error.localizedDescription)")
//                return false
//            }
//        }
//    }
//}
//    init(){
//        // purgeData()
//        loadData()
//    }
//    func toggleCompleted(bucketListItem: BucketList){
//        // Don't try to update if toDos.id == nil
//        guard bucketListItem.id != nil else {return}
//        // copy bucketListItem (a constant) into a newBucketListItem (var) so we can update the isCompleted property
//        var newBucketListItem = bucketListItem
//        newBucketListItem.isCompleted.toggle() // flips false to true and true to false
//        // find the ID for new ToDo in the array of toDos, then update the element at that index with the data in newToDo
//        if let index = .firstIndex(where: {$0.id == newBucketListItem.id}){
//            toDos[index] = newToDo
//        }
//        saveData()
//    }
//    func saveToDo(toDo: ToDo) {
//        if toDo.id == nil {
//            var newToDo = toDo
//            newToDo.id = UUID().uuidString
//            toDos.append(newToDo)
//        } else {
//            if let index = toDos.firstIndex(where: {$0.id == toDo.id}){
//                toDos[index] = toDo
//            }
//        }
//        saveData()
//    }
//
//    func deleteToDo(indexSet: IndexSet) {
//        toDos.remove(atOffsets: indexSet)
//        saveData()
//    }
//
//    func moveToDo(fromOffsets: IndexSet, toOffset: Int) {
//        toDos.move(fromOffsets: fromOffsets, toOffset: toOffset)
//        saveData()
//    }
//
//    func loadData(){
//        let path = URL.documentsDirectory.appending(component: "toDos")
//        guard let data = try? Data(contentsOf: path) else {return}
//        do {
//            toDos = try JSONDecoder().decode(Array<ToDo>.self, from: data)
//        } catch {
//            print("😡 ERROR: Could not save data \(error.localizedDescription)")
//        }
//    }
//    func saveData(){
//        let path = URL.documentsDirectory.appending(component: "toDos")
//        let data = try? JSONEncoder().encode(toDos) // try? means if error is thrown, data = nil
//        do{
//            try data?.write(to: path)
//        } catch {
//            print("😡 ERROR: Could not save data \(error.localizedDescription)")
//        }
//    }
//    func purgeData(){
//        let path = URL.documentsDirectory.appending(component: "toDos")
//        let data = try? JSONEncoder().encode("")
//        do {
//            try data?.write(to: path)
//        } catch {
//            print("😡 ERROR: Could not save data \(error.localizedDescription)")
//        }
//    }
//}
