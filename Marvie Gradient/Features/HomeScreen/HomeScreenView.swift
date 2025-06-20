//
//  HomeScreenView.swift
//  Marvie
//
//  Created by Shekhar Manwar on 10/06/25.
//

import SwiftUI

struct HomeScreenView: View {
    @Binding var path: NavigationPath
    
    private let arr = [
        "Flat 50% Off on Summer Collection!",
        "Buy 1 Get 1 Free – Limited Time!",
        "Exclusive Deals on Electronics",
        "Mega Sale – Up to 70% Off",
        "New Arrivals in Men's Fashion",
        "Weekend Flash Sale – Hurry!",
        "Extra 10% Off with Code: SAVE10",
        "Top Picks Under ₹999",
        "Shop Smart – Great Discounts Await",
        "Free Shipping on Orders Above ₹499",
        "Trending Now: Designer Footwear",
        "Daily Deals You Can’t Miss!"
    ]
    
    private let primaryColors: [Color] = [AppColor.red, AppColor.yellow, AppColor.lightGreen, AppColor.purple]
    
    @State private var currentIndex = 0
    @StateObject var viewModel = ProductViewModel()
    
    var body: some View {
        VStack {
            // Horizontal feed with carousel
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(0..<arr.count, id: \.self) { index in
                            VStack {
                                Text("\(arr[index])")
                                    .font(AppFont.boldSF(size: 24))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .frame(width: 319, height: 187)
                            .background {
                                FeedBackground()
                            }
                            .cornerRadius(20)
                            .id(index)
                            .padding(.leading, 30)
                        }
                    }
                    .frame(height: 190)
                    .padding(.vertical)
                }
                .onAppear {
                    startAutoScroll(with: scrollProxy)
                }
            }
            .padding(.top, 40)
            
            // Vertical feed
            VStack{
                ScrollView(.vertical) {
                    LazyVStack (alignment: .leading) {
                        ForEach(viewModel.products, id: \.id) { product in
                            VStack(alignment: .leading) {
                                
                                Text(product.title)
                                    .font(.title)
                                    .foregroundColor(AppColor.white)
                                    .padding(.top, 5)
                                    .lineLimit(2)
                                
                                Text(product.description)
                                    .font(.caption)
                                    .foregroundStyle(Color.white)
                            }
                            .padding()
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        }
                    }
                    .padding()
                }
                
            }
            .background(LinearGradient(colors: [.black, .blue], startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 40))
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: -2)
            .onAppear{
                DispatchQueue.main.async{
                    viewModel.fetchProducts()
                }
            }
            
        }
        .navigationBarBackButtonHidden()
        .background(LinearGradient(colors: [.black, .blue], startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea()
    }
    
    private func startAutoScroll(with scrollProxy: ScrollViewProxy) {
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            withAnimation {
                currentIndex += 1
                Logger.log("currentIndex is \(currentIndex)")
                
                if currentIndex >= arr.count {
                    currentIndex = 0
                    Logger.log("Current Index is greater than array count")
                }
                
                scrollProxy.scrollTo(currentIndex, anchor: .leading)
            }
        }
    }
}

#Preview {
    @Previewable @State var previewPath = NavigationPath()
    return HomeScreenView(path: $previewPath)
}
