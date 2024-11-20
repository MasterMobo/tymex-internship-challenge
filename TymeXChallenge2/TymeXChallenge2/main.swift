//
//  main.swift
//  TymeXChallenge2
//
//  Created by KHANH VAN on 20/11/24.
//

import Foundation

print("===== Question 2.1 =====")

let productManager = ProductManager()
productManager.addProduct(product: Product(name: "Laptop", price: 999.99, quantity: 5))
productManager.addProduct(product: Product(name: "Smartphone", price: 499.99, quantity: 10))
productManager.addProduct(product: Product(name: "Tablet", price: 299.99, quantity: 0))
productManager.addProduct(product: Product(name: "Smartwatch", price: 199.99, quantity: 3))

print("Total Value: \(productManager.getTotalStockValue())\n")
print("Most Expensive Product: \(productManager.getMostExpensiveName() ?? "No product in list")\n")
print("Headphone exists: \(productManager.productExists(name: "Headphones"))\n")

productManager.sort(order: .ascending, by: .price)
print("Sorted by price in ascending order: ")
productManager.printProducts()
print()

print("Sorted by quantity in descending order: ")
productManager.sort(order: .descending, by: .quantity)
productManager.printProducts()
print()

print("===== Question 2.2 =====")
let nums = [3, 7, 1, 2, 6, 4]
print("Missing Number: \(findMissing(nums: nums))")
