////
////  LocationView.swift
////  FinalProject
////
////  Created by Annie on 4/26/23.
////
//
//import SwiftUI
//
//import Firebase
//
//struct LookupView: View {
//    @State var host: Host
////    @State var location: Location
//    @EnvironmentObject var hostVM: HostViewModel
//    @Environment(\.dismiss) var dismiss
//    @State private var showLocationLookupSheet = false
//
//
//    var body: some View {
//        VStack{
//            Group {
//                Text("Hello")
////                TextField("City", text: $host.city)
//                    .font(.title)
//                TextField("State", text: $host.state)
//                    .font(.title2)
//            }
//            .textFieldStyle(.automatic)
//            .overlay {
//                RoundedRectangle(cornerRadius: 5)
//                    .stroke(.gray.opacity(0.5), lineWidth: 2) //TODO: change to app colors
//            }
//            .padding(.horizontal)
//
//            Spacer()
//        }
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(host.id == nil)
//
//    }
//}
//
//struct LocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack{
//            LookupView(host: Host())
//                .environmentObject(HostViewModel())
//        }
//    }
//}
