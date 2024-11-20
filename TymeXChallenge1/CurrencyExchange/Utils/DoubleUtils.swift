//
//  DoubleUtils.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 17/11/24.
//

import Foundation

class DoubleUtils {
    /// Compare two doubles within a small error margin
    /// - returns: true if they are within error margin, false otherwise
    static func equals(_ d1: Double, _ d2: Double) -> Bool{
        let delta: Double = 1e-10
        return abs(d1 - d2) < delta
    }
}
