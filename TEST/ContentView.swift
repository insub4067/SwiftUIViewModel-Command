//
//  ContentView.swift
//  TEST
//
//  Created by insub on 2023/03/09.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(Array(viewModel.items.enumerated()), id: \.offset) { offset, item in
                        // MARK: - Cell
                        NavigationLink {
                            DetailItemView(item: item, offset: offset, delegate: viewModel)
                        } label: {
                            Cell(item: item, offset: 0)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func Cell(item: Item, offset: Int) -> some View {
        HStack(spacing: 16) {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(item.color)
            Spacer()
            Text("\(String(item.id.prefix(8)))")
                .font(.body)
            Image(systemName: item.isLiked ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(item.isLiked ? .red : .black)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .frame(height: 80)
    }
}

class ContentViewModel: ObservableObject, ItemDelegate {
    
    @Published var items: [Item] = []
    
    init() { getItems() }

    func getItems() {
        for _ in 1...30 {
            DispatchQueue.main.async { [weak self] in
                self?.items.append(Item.init())
            }
        }
    }
    
    func didTapIsLike(offset: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.items[offset].isLiked.toggle()
        }
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
