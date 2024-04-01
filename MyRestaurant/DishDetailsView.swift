//
//  DishDetailsView.swift
//  MyRestaurant
//
//  Created by Vinayak Bora on 01/04/24.
//

import SwiftUI

struct DishDetailsView: View {
    var dish: Dish
    
    var body: some View {
        
        VStack {
            
            AsyncImage(
                url: URL(string: dish.imageUrl ?? ""),
                content:{image in
                    image.resizable()},
                placeholder: {
                    ProgressView()
                }
            )
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(40)
            
            VStack(alignment: .center, spacing: 40) {
                Text(dish.name ?? "")
                    .font(.title)
                    .padding(.top, 16)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Veg/Non-Veg : \(dish.tag ?? "")")
                        .font(.body)
                        .padding(.horizontal)
                    
                    Text("Price : ₹\(dish.price ?? 0)")
                        .font(.body)
                        .padding(.horizontal)
                    
                    Text("PrepTime : \(dish.prepTime ?? "")")
                        .font(.body)
                        .padding(.horizontal)
                    
                    Text("Ingredients : \(dish.ingredients ?? "")")
                        .font(.body)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
}

let sampleDish = Dish(name: "Sample Product", price: 10,ingredients: "dsvjhbfvjdhsbfvhjdbsf", tag: "Veg", prepTime: "1hr",imageUrl: "https://www.licious.in/blog/wp-content/uploads/2022/06/chicken-hyderabadi-biryani-01.jpg")

#Preview {
    DishDetailsView(dish: sampleDish)
}
