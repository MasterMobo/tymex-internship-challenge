//
//  MissingNumber.swift
//  TymeXChallenge2
//
//  Created by KHANH VAN on 21/11/24.
//

import Foundation

/// Find the missing number in an array of length n with numbers ranging from 1 to n + 1
func findMissing(nums: [Int]) -> Int {
    let n = nums.count + 1
    
    // Sum of 1 + 2 + ... + n
    let expectedSum = n * (n + 1) / 2
    
    // Sum of all numbers in nums
    let realSum = nums.reduce(0) { partialResult, nextNum in
        return partialResult + nextNum
    }
    
    // The diffence must be the missing number
    return expectedSum - realSum
}
