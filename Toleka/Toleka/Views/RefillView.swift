//
//  RefillView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import SwiftUI

struct RefillView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var navPath: NavigationPath
    @ObservedObject var orderVM: OrderViewModel
    
    private let cylinderLayout = Array(repeating: GridItem(.flexible()), count: 5)
    private let quantityLayout = Array(repeating: GridItem(.flexible()), count: 7)
    private let brandLayout = Array(repeating: GridItem(.flexible()), count: 2)
        
    private let quantities: [Int] = (1...14).map({ $0 })
    
    private let gasBrands: [String] = ["MANJI GAS", "DAP GAS", "MIHAN GAS", "ABBARCI", "DEEP SKY", "ORYX", "KV GAS", "RWDA O02", "K-GAS", "TOTAL GAS", "SULFO GAS", "KIGALI GAS", "LAKE GAS", "BEST GAS", "OlL COM", "YES GAS", "METRO", "SP GAS", "CITY GAS", "S.E GAS", "HOYO", "SURAMBAYA", "MEREZ GAS", "SAFE GAS", "HASHI_EN", "MERU GAS"]

    @State private var selectedBrand: String?
    @State private var selectedQuantity: Int?
    
    @State private var order: Order?
    
    private var totalPrice: Double {
        order?.totalPrice ?? 0.0
    }
    
    private var canProceed: Bool {
        totalPrice != 0 && selectedBrand != nil
    }

    var body: some View {
        List {
            Section {
                LazyVGrid(columns: cylinderLayout,
                          pinnedViews: .sectionHeaders) {
                    ForEach(Cylinder.gasCylinders) { cylinder in
                        CircleButton(title: String(cylinder.weight),
                                     subtitle: "Kgs",
                                     isSelected: order?.product.weight == cylinder.weight)
                        .onTapGesture {
                            withAnimation {
                                if order?.product.weight == cylinder.weight {
                                    order = nil
                                } else {
                                    order = Order(
                                        id: 1,
                                        product: Product(
                                            id: 1,
                                            coverImage: "gas-container",
                                            name: "Refill: \(String(cylinder.weight)) Kgs",
                                            subtitle: selectedBrand ?? "",
                                            price: cylinder.price,
                                            currency: Currency.usd,
                                            weight: cylinder.weight, available: 1),
                                        quantity: selectedQuantity ?? 0)
                                }
                            }
                        }
                    }
                }
            } header: {
                Text("Cylinder Size(Kgs)")
                    .textCase(nil)
                    .font(.headline)
                    .padding(.vertical, 10)
            }

            Section {
                LazyVGrid(
                    columns: quantityLayout,
                    pinnedViews: .sectionHeaders) {
                        ForEach(quantities, id: \.self) { quantity in
                            CircleButton(title: String(quantity),
                                         isSelected: quantity == selectedQuantity)
                            .onTapGesture {
                                withAnimation {
                                    if selectedQuantity == quantity {
                                        selectedQuantity = nil
                                        self.order?.quantity = 1
                                    } else {
                                        selectedQuantity = quantity
                                        self.order?.quantity = quantity
                                    }
                                }
                            }
                        }
                    }
            } header: {
                Text("Quantity")
                    .textCase(nil)
                    .font(.headline)
                    .padding(.vertical, 10)
            }
            
            Section {
                LazyVGrid(
                    columns: brandLayout,
                    alignment: .leading,
                    spacing: 20,
                    pinnedViews: .sectionHeaders) {
                        ForEach(gasBrands, id: \.self) { brandName in
                            LabeledCheckBox(title: brandName,
                                            isSelected: selectedBrand == brandName)
                            .onTapGesture {
                                withAnimation {
                                    if selectedBrand == brandName {
                                        selectedBrand = nil
                                    }else {
                                        selectedBrand = brandName
                                    }
                                }
                            }
                        }
                    }
            } header: {
                Text("Brand/Company")
                    .textCase(nil)
                    .font(.headline)
                    .padding(.vertical, 10)
            }
        }
        .listStyle(.insetGrouped)
        .background(Color(.secondarySystemBackground))
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .leading) {
                Text("Total: \(Text(totalPrice.formatted(.currency(code: "USD"))).bold())")
                    .font(.title3)
                LargeButton("Order Now") {
                    if let order {
                        orderVM.addOrderToCart(order)
                        self.clearOrder()
                        self.navPath.append(NavRoute.checkout)
                    }
                }
                .disabled(!canProceed)
            }
            .padding()
            .background(.ultraThinMaterial)
        }
        .toolbar {
            CartButton(count: orderVM.getCartCount())
        }
        .navigationTitle("New Purchase")
    }
    
    private func clearOrder() {
        order = nil
        selectedBrand = nil
        selectedQuantity = nil
    }
}

struct RefillView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RefillView(navPath: .constant(.init()), orderVM: OrderViewModel())
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct LabeledCheckBox: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 25) {
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                .imageScale(.large)
                .foregroundColor(isSelected ? Color.accentColor : Color(.darkGray))
            
            Text(title)
                .foregroundColor(Color(.darkGray))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


private struct CircleButton: View {
    let title: String
    var subtitle: String?
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
            if let subtitle {
                Text(subtitle)
            }
        }
        .lineLimit(1)
        .minimumScaleFactor(0.8)
        .fontWeight(.semibold)
        .fontDesign(.rounded)
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isSelected ? Color.accentColor : .clear)
        .clipShape(Circle())
        .overlay {
            Circle().strokeBorder(isSelected ? Color.accentColor : Color(.darkGray), lineWidth: 1)
        }
        .foregroundColor(isSelected ? .white : .primary)
    }
}

struct Cylinder: Identifiable, Equatable {
    var id: Double { weight }
    
    let weight: Double
    let price: Double
    
    static let gasCylinders: [Cylinder] = [
        Cylinder(weight: 6.0, price: 10.0),
        Cylinder(weight: 12.0, price: 20.0),
        Cylinder(weight: 15.0, price: 25.0),
        Cylinder(weight: 20.0, price: 33.0),
        Cylinder(weight: 25.0, price: 40.0),
        Cylinder(weight: 35.0, price: 55.0),
        Cylinder(weight: 38.0, price: 58.0),
        Cylinder(weight: 50.0, price: 75.0)
    ]
}
