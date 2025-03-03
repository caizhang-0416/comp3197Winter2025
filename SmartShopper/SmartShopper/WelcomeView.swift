//
//  WelcomeView.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-03-02.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image("Logo")
                
                Text("Group-18")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.gray)
                
                VStack(spacing: 12) {
                    MemberView(name: "Zhang, Cai", id: "101464891", crn: "58079")
                    MemberView(name: "Park, Dongre", id: "101393080", crn: "58079")
                    MemberView(name: "Chauhan, Tanveer", id: "101451948", crn: "58079")
                }
                .padding(.top, 40)
            }
        }
    }
}

struct MemberView: View {
    let name: String
    let id: String
    let crn: String
    
    var body: some View {
        VStack {
            Text(name)
                .font(.system(size: 18, weight: .regular))
            Text("\(id), CRN: \(crn)")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
