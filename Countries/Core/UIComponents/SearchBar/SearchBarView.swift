//
//  SearchBarView.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            
            TextField("Search...", text: $searchText)
                .padding(12)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)
            
            Button(action: { onSearch() }) {
                Image(systemName: "magnifyingglass.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title)
            }
            .padding(.trailing)
        }
        .padding(.top)
    }
}
