//
//  ContentView.swift
//  MyRestaurant
//
//  Created by Vinayak Bora on 01/04/24.
//

import SwiftUI

struct RestaurantView: View {
    @State var dishResponse: DishResponse? = nil
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var selectedCategory: String? = nil
    
    var body: some View {
        
        NavigationView {
            if let dish = dishResponse?.data {
                List(dish.filter { dish in
                    selectedCategory == nil || dish.tag == selectedCategory
                }, id: \.id) { dish in
                    NavigationLink(
                        destination: DishDetailsView(dish: dish),
                        label:{
                            HStack(spacing:40){
                                AsyncImage(
                                    url: URL(string: dish.imageUrl ?? ""),
                                    content:{image in
                                        image.resizable()},
                                    placeholder: {
                                        ProgressView()
                                    }
                                )
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(dish.name ?? "")
                                        .font(.headline)
                                    Text(dish.tag ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("₹\(dish.price ?? 0)")
                                        .font(.headline)
                                }
                            }
                            .padding(5)
                        })
                }
                .navigationTitle("My Dishes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                               selectedCategory = nil
                           }) {
                               Image("allDishes")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 40, height: 40)
                        
                           }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 20) {
                            Button(action: {
                                   selectedCategory = "Veg"
                               }) {
                                   Image("broccoli")
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(width: 40, height: 40)
                               }
                               
                               Button(action: {
                                   selectedCategory = "Non-Veg"
                               }) {
                                   Image("no_meat")
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(width: 40, height: 40)
                               }
                        } .padding(16)
                        
                    }
                }
            }
            else if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                ProgressView()
                    .onAppear {
                        getDishes()
                    }
            }
        }
    }
    
    func getDishes()
    {
        Task {
            guard let url = URL(string: "http://192.168.171.65:8081/api/v1/dish/")
            else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                dishResponse = try JSONDecoder().decode(DishResponse.self, from: data)
                
            } catch {
                errorMessage = "Error loading products"
                showError = true
                print(error)
            }
        }
    }
}
#Preview {
    RestaurantView()
}
