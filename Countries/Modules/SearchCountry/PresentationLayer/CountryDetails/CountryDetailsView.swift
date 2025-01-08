//
//  CountryDetailsView.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 8/1/25.
//

import SwiftUI
import Kingfisher

struct CountryDetailsView: View {
    
    @ObservedObject private var viewModel: CountryDetailsViewModel
    
    init(viewModel: CountryDetailsViewModel) {
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ZStack {
            
            VStack(alignment: .center) {
                
                KFImage(URL(string: viewModel.flag ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height / 4)
                
                Text(viewModel.name ?? "")
                    .font(.system(size: 40))
                    .bold()
                
                Text(viewModel.capital ?? "")
                    .font(.system(size: 30))
                    .italic()
                                
                HStack {
                    Text(viewModel.code ?? "")
                        .font(.system(size: 20))
                        .italic()
                    
                    Text(viewModel.currencyName ?? "")
                        .font(.system(size: 20))
                        .italic()
                    
                    Text(viewModel.symbol ?? "")
                        .font(.system(size: 20))
                        .italic()
                }
                .offset(y: UIScreen.main.bounds.height / 6)
            }
            .offset(y: -UIScreen.main.bounds.height / 4)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
    }
}
