//
//  CountryListView.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import SwiftUI
import Kingfisher

struct CountryListView: View {
    
    @ObservedObject var viewModel: CountryListViewModel
    @State private var searchText: String = ""
    
    init(viewModel: CountryListViewModel) {
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                
                SearchBar(searchText: $searchText,
                          onSearch: { search() })
                
                ZStack {
                    List {
                        ForEach(viewModel.searchResults, id: \.name) { country in
                            
                            HStack {
                                Text(country.name ?? "")
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.1)))
                                
                                Spacer()
                                
                                KFImage(URL(string: country.flag ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        .onDelete(perform: deleteCountry)
                        .padding(.vertical, 8)
                        .listStyle(PlainListStyle())
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(2)
                            .padding(50)
                            .background(Color.gray.opacity(0.7), in: RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 10)
                    }
                }
                
                .alert(isPresented: $viewModel.showError) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage ?? "error occurred"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                
            }
            .navigationTitle("Search Country")
            .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
}

//MARK: - Methods
extension CountryListView {
    
    private func search() {
        
        Task {
            await viewModel.search(with: searchText)
            searchText = ""
        }
    }
    
    private func deleteCountry(at offsets: IndexSet) {
        viewModel.removeCountry(at: offsets)
    }
}
