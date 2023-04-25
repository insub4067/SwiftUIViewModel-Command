//
//  DetailItemView.swift
//  TEST
//
//  Created by insub on 2023/04/26.
//

import SwiftUI

struct DetailItemView: View {
    
    @State var item: Item
    let offset: Int
    
    weak var delegate: ItemDelegate?
    
    init(item: Item, offset: Int, delegate: ItemDelegate? = nil) {
        self._item = State(wrappedValue: item)
        self.offset = offset
        self.delegate = delegate
    }
    
    var body: some View {
        VStack {
            Image(systemName: item.isLiked ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(item.isLiked ? .red : .black)
                .onTapGesture { didTapItem() }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(item.color.opacity(0.3))
    }
    
    func didTapItem() {
        item.isLiked.toggle()
        delegate?.didTapIsLike(offset: offset)
    }
}
