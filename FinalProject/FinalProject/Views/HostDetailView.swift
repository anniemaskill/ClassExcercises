//
//  HostToDoView.swift
//  FinalProject
//
//  Created by Annie on 4/28/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct HostDetailView: View {
    @State var location: Location
    @EnvironmentObject var locationVM: LocationViewModel
    @EnvironmentObject var hostVM: HostViewModel
    @FirestoreQuery(collectionPath: "locations") var hosts: [Host]
    
    
    @Environment(\.dismiss) private var dismiss
    @State private var showHostViewSheet = false
    var previewRunning = false
    var isCompleted = true
    let hostColor: Color = .accentColor
    
    var body: some View {
        VStack{
            Group {
                TextField("City", text: $location.city)
                    .font(.title)
                TextField("State", text: $location.state)
                    .font(.title2)
            }
            .textFieldStyle(.roundedBorder)
            .overlay{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.green.opacity(0.5), lineWidth: location.id == nil ? 2: 0)
            }
            
            Button {
                showHostViewSheet.toggle()
            } label: {
                Text("Add Recommendation")
                
            }
            .tint(hostColor)
            .buttonStyle(.borderedProminent)
            
            List {
                ForEach(hosts) { host in
                    HStack{
                        Image(host.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                hostVM.toggleCompleted(location: location, host: host)
                            }
                        NavigationLink {
                            HostView(location: location, host: host)
                        } label: {
                            HStack{
                                Text(host.review)
                                Spacer()
                                Text("Votes: \(host.vote)")
                                
                            }
                            .foregroundColor(.green)
                            
                        }
                    }

                    
                }
                .onDelete { indexSet in
                    guard let index = indexSet.first else {return}
                    Task {
                        await hostVM.deleteHost(location: location, host: hosts[index])
                    }
                }
                
                
                
            }
            .listStyle(.plain)
            
            
            
            Spacer()
        }
        .onAppear{
            if !previewRunning && location.id != nil {
                $hosts.path = "locations/\(location.id ?? "")/hosts"
                print("hosts.path = \($hosts.path)")
            } else {
                print("Add new location")
            }
            
        }
        .navigationBarBackButtonHidden(location.id == nil)
        
        //        .disabled(location.id == nil ? false : true)
        
        .toolbar {
            if location.id == nil { // New spot, so show cancel/save buttons
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task{
                            let success = await locationVM.saveLocation(location: location)
                            if success{
                                dismiss()
                            } else {
                                print("😡 DANG! Error saving location")
                            }
                        }
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showHostViewSheet) {
            HostView(location: location, host: Host())
        }
        
        
    }
}
struct HostToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HostDetailView(location: Location(), previewRunning: true)
                .environmentObject(LocationViewModel())
                .environmentObject(HostViewModel())
        }
    }
}
