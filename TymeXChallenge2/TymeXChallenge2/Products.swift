//
//  Products.swift
//  TymeXChallenge2
//
//  Created by KHANH VAN on 21/11/24.
//

import Foundation

/// Represents a product in inventory
class Product {
    var name: String
    var price: Double
    var quantity: Int
    
    init(name: String, price: Double, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

enum ProductSortOrder {
    case ascending, descending
}

enum ProductSortOption {
    case price, quantity
}

/// Manages an array of Products
class ProductManager {
    // Array containting all products
    private var products: [Product] = []
    
    func addProduct(product: Product) {
        products.append(product)
    }
    
    /// Calculates the total value of all products in stock
    func getTotalStockValue() -> Double {
        return products.reduce(0.0) { partialResult, product in
            return partialResult + product.price * Double(product.quantity)
        }
    }
    
    /// Get the name of the most expensive product by price
    ///
    /// - returns: The name of the most expensive product if there is at least 1 product.
    /// *nil* if there is no product in the array.
    ///
    func getMostExpensiveName() -> String? {
        let result = products.max { product1, product2 in
            return product1.price < product2.price
        }
        
        return result?.name
    }
    
    /// Check whether a product with *name* exists in the array
    ///
    /// - returns: True if product exists. False if it does not
    func productExists(name: String) -> Bool {
        let found = products.first { product in
            return product.name == name
        }
        
        return found != nil
    }
    
    /// Sorts the product array in place
    ///
    /// - parameter order: Order in which to sort the array.
    /// - parameter by: Attribute to sort the array with.
    func sort(order: ProductSortOrder = .ascending, by: ProductSortOption = .price) {
        if order == .ascending {
            sortAscending(by: by)
        } else {
            sortDescending(by: by)
        }
    }
    
    /// Sorts the product array in place in ascending order
    ///
    /// - parameter by: Attribute to sort the array with.
    private func sortAscending(by: ProductSortOption) {
        products.sort { product1, product2 in
            switch by {
            case .price:
                return product1.price < product2.price
            case .quantity:
                return product1.quantity < product2.quantity
            }
        }
    }
    
    /// Sorts the product array in place in ascending order
    ///
    /// - parameter by: Attribute to sort the array with.
    private func sortDescending(by: ProductSortOption) {
        products.sort { product1, product2 in
            switch by {
            case .price:
                return product1.price > product2.price
            case .quantity:
                return product1.quantity > product2.quantity
            }
        }
    }
    
    /// Prints all the products in a nice format
    func printProducts() {
        if products.isEmpty {
            print("There is no product!")
            return
        }
        
        for product in productManager.products {
            print("\(product.name), price: \(product.price), quantity: \(product.quantity)")
        }
    }
}
