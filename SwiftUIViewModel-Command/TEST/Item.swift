//
//  Item.swift
//  TEST
//
//  Created by insub on 2023/04/26.
//

import SwiftUI

protocol ItemCommand: AnyObject {
    func didTapIsLike(offset: Int)
}

struct Item: Identifiable, Hashable {
    let id = UUID().uuidString
    let color = Color.random
    var isLiked = Bool.random()
}
