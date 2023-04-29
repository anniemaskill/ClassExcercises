//
//  DetailView.swift
//  FinalProject
//
//  Created by Annie on 4/25/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct HostView: View {
    @State var location: Location
    @State var host: Host
    @StateObject var hostVM = HostViewModel()
    @Environment(\.dismiss) private var dismiss
//    @FirestoreQuery(collectionPath: "locations") var hosts: [Host]
    
    // This doesn't have the right path
    //    @FirestoreQuery(collectionPath: "hosts") var hosts: [Host]
    
    @State private var showHostDetailViewSheet = false
    @State var postedByThisUser = false
//    @State var currentUser = Auth.auth().currentUser?.email ?? ""
    
    let hostColor: Color = .accentColor
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) { //TODO: improve UI
                Text("\(location.city), \(location.state)")
                    .foregroundColor(hostColor)
                    .multilineTextAlignment(.leading)
                
                Text("Recommendation:")
                    .bold()
                
                TextField("Recommendation", text: $host.review, axis: .vertical)
                    .frame(maxHeight: 50)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: 2)
                    }  //TODO: add title with rec? and then they can click on it to see more info
                    .padding(.bottom)
//                    .disabled(!postedByThisUser)
                
                
                Button {
                    host.vote += 1
                } label: {
                    Text("Votes: \(host.vote)")
                }
                .buttonStyle(.borderedProminent)
                
                
                HStack{
                    Text("Posted by:")
                        .bold()
                    Text(host.user)
                }
                
                
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(location.id == nil)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            let success = await hostVM.saveHost(location: location, host: host)
                            if success {
                                dismiss()
                            } else {
                                print("😡 ERROR: saving data in ReviewView")
                            }
                        }
                        dismiss()
                    }
                }
            }
            
        }
    }
}







struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HostView(location: Location(city: "city", state: "state"), host: Host())
        }
        
    }
}
