//
//  DoctorCardList.swift
//  HMS-Team 5
//
//  Created by Ishan on 22/04/24.
//

import SwiftUI

struct DoctorCardList: View {
    @ObservedObject var doctorsViewModel = DoctorsViewModel()

    var body: some View {
        List(doctorsViewModel.doctors, id: \.id) { doctor in
            VStack(alignment: .leading) {
                Text(doctor.name)
                    .font(.headline)
                Text(doctor.department)
                    .font(.subheadline)
                Text("Rating: \(String(format: "%.1f", doctor.rating))")
                                   .font(.subheadline)
                Text("Years of Experience: \(String(format: "%d", doctor.yearsOfExperience))")
                                   .font(.subheadline)
                AsyncImage(url: URL(string: doctor.image)) { phase in
                            switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                case .failure:
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 150, height: 150)
                            .padding()
            }
        }
        .onAppear {
            doctorsViewModel.fetchDoctors()
        }
    }
}

#Preview {
    DoctorCardList()
}
