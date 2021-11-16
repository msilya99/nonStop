//
//  NSEventModel.swift
//  NonStop
//
//  Created by Ilya Maslou on 17.11.21.
//

import Foundation

struct NSEventModel {
    let name: String
    let fromDate: Date
    let toDate: Date
    let isSpecialDateEvent: Bool
    let eventDescription: String
    var color: Data?
    let selectedIcon: String
}
