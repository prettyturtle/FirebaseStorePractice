//
//  Data.swift
//  FirebaseStorePractice
//
//  Created by yc on 2021/09/23.
//

import Foundation

struct FeelData: Codable {
    var id: String = UUID().uuidString
    let date: String
    let feel: String
    let description: String
}
