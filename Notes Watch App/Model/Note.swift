//
//  Note.swift
//  Notes Watch App
//
//  Created by Matheus Xavier on 25/08/23.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
