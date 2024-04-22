//
//  PatientHomeVIew.swift
//  HMS-Team 5
//
//  Created by Ishan on 22/04/24.
//

import SwiftUI

struct PatientHomeView: View {
    @ObservedObject var doctorsViewModel = DoctorsViewModel()

    var body: some View {
        NavigationView {
            
        }
    }
}

struct PatientHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PatientHomeView()
    }
}
