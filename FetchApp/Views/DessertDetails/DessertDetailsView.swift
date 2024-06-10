//
//  DessertDetailsView.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/9/24.
//
/*
 • Meal name
 • Instructions
 • Ingredients/measurements
 */
import SwiftUI

struct DessertDetailsView: View {
    @StateObject var viewModel = DessertDetailsViewModel()
    
    let dessertID: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                DisplayImage(vm: viewModel)
                Divider()
                InstructionsText(vm: viewModel)
                Divider()
                IngredientsText(vm: viewModel)
            }
            .padding()
        }
        .navigationTitle(viewModel.dessertDetails?.name ?? "Mystery Dessert")
        .onAppear {
            viewModel.getDessertDetails(using: dessertID)
        }
    }
}

#Preview {
    DessertDetailsView(dessertID: "")
}

struct DisplayImage: View {
    @ObservedObject var vm: DessertDetailsViewModel
    
    var body: some View {
        if let imageUrl = vm.dessertDetails?.thumbnailURL {
            CachableAsyncImage(url: imageUrl) { phase in
                switch phase {
                case .failure(let error):
                    Text("Error View: \(error.localizedDescription)")
                case.empty:
                    Color.gray.opacity(0.2)
                case .success(let image):
                    image.resizable()
                @unknown default: fatalError("unknown phase event for async image")
                }
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 11))
        } else {
            // Display default
            Image(systemName: "camera.fill")
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
        }
        
    }
}

struct InstructionsText: View {
    @ObservedObject var vm: DessertDetailsViewModel
    
    var body: some View {
        if let details = vm.dessertDetails {
            Text(details.instructions)
        }
    }
}

struct IngredientsText: View {
    @ObservedObject var vm: DessertDetailsViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Ingredients")
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom)
            
            
            if let details = vm.dessertDetails {
                VStack {
                    ForEach(Array(details.measurementsForIngredient.keys), id: \.self) { key in
                        HStack {
                            Text("\(key) ")
                            Text("(\((details.measurementsForIngredient[key] ?? "")))")
                            Spacer()
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.yellow)
        
    }
}
