//
//  ProfileData.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import Foundation

struct ProfileData: Codifiable, Hashable {
    var id: UUID = UUID()
    var names = ""
    var phone = ""
    var bottleWeight = ""
    var address = ""
}
