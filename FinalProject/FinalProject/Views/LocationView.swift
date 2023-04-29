//
//  BucketListView.swift
//  FinalProject
//
//  Created by Annie on 4/25/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct LocationView: View {
    @FirestoreQuery(collectionPath: "locations") var locations: [Location]
    @Environment(\.dismiss) private var dismiss
    @State private var sheetIsPresented = false
    
    var body: some View {
        NavigationStack{
            List(locations){ location in
                NavigationLink {
                    HostDetailView(location: location)
                } label: {
                    Text("\(location.city), \(location.state)")
                        .font(.title2)
                }
                
            }
            .navigationTitle("HOST")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sign Out") {
                        do {
                            try Auth.auth().signOut()
                            print("🪵➡️ Log out successful!")
                            dismiss()
                        } catch {
                            print("😡 ERROR: Could not sign out!")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack{
                    HostDetailView(location: Location())
                }
                
            }
        }

        
    }
}



struct HostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            LocationView()
        }
        
    }
}

