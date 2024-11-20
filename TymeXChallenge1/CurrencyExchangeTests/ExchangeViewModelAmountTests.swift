//
//  ExchangeViewModelAmountTests.swift
//  CurrencyExchangeTests
//
//  Created by KHANH VAN on 20/11/24.
//

import XCTest
@testable import CurrencyExchange

final class ExchangeViewModelAmountTests: XCTestCase {

    var viewModel: ExchangeViewModel?
    
    let sourceCurrency = "USD"
    let targetCurrency = "VND"
    let rates = [
        "USD" : 1.0,
        "VND" : 0.2,
    ]
    let currencies = [
        "USD" : "United States Dollar",
        "VND" : "Vietnamese Dong",
    ]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let mockProvider = MockCurrencyExchangeProvider(rates: rates, currencies: currencies)
        let factory = ExchangeModelFactory(provider: mockProvider)

        viewModel = ExchangeViewModel(exchangeModelFactory: factory)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func test_ExchangeViewModel_amount_shouldBeInitialized() async {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        await vm.onStart()
        
        // Then
        XCTAssertEqual(vm.sourceAmount, 0)
        XCTAssertEqual(vm.targetAmount, 0)
    }
    
    func test_ExchangeViewModel_amounts_shouldResetWhenSourceIsEmpty() async {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        await vm.onStart()
        
        // When
        vm.sourceAmountStr = ""
        vm.handleAmountChange("", isSource: true)
        
        // Then
        XCTAssertEqual(vm.sourceAmountStr, "")
        XCTAssertEqual(vm.targetAmountStr, "")
        XCTAssertEqual(vm.targetAmount, 0)
        XCTAssertEqual(vm.sourceAmount, 0)
        XCTAssertEqual(vm.isTargetAmountInvalid, false)
        XCTAssertEqual(vm.isSourceAmountInvalid, false)
    }
    
    func test_ExchangeViewModel_amounts_shouldResetWhenTargetIsEmpty() async {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        await vm.onStart()
        
        // When
        vm.targetAmountStr = ""
        vm.handleAmountChange("", isSource: false)
        
        // Then
        XCTAssertEqual(vm.sourceAmountStr, "")
        XCTAssertEqual(vm.targetAmountStr, "")
        XCTAssertEqual(vm.targetAmount, 0)
        XCTAssertEqual(vm.sourceAmount, 0)
        XCTAssertEqual(vm.isTargetAmountInvalid, false)
        XCTAssertEqual(vm.isSourceAmountInvalid, false)
    }
    
    func test_ExchangeViewModel_sourceAmountStr_shouldFlagInvalidString() async {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        await vm.onStart()
        
        // When
        let input = "kjdhfksd"
        vm.sourceAmountStr = input
        vm.handleAmountChange(input, isSource: true)

        // Then
        XCTAssertEqual(vm.isSourceAmountInvalid, true)
    }
    
    func test_ExchangeViewModel_targetAmountStr_shouldFlagInvalidString() async {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        await vm.onStart()
        
        // When
        let input = "kjdhfksd"
        vm.targetAmountStr = input
        vm.handleAmountChange(input, isSource: false)

        // Then
        XCTAssertEqual(vm.isTargetAmountInvalid, true)
    }
    
    func test_ExchangeViewModel_sourceAmount_shouldUpdateTargetAmount() async {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        await vm.onStart()

        // When
        let input: Double = 100.0
        vm.sourceCurrency = sourceCurrency
        vm.targetCurrency = targetCurrency
        vm.sourceAmountStr = String(input)
        
        // Then
        let expected: Double = rates[targetCurrency]! / rates[sourceCurrency]! * input
        
        XCTAssertTrue(DoubleUtils.equals(vm.targetAmount, expected))
        XCTAssertEqual(vm.targetAmountStr, String(expected))
    }
    
    func test_ExchangeViewModel_targetAmount_shouldUpdateSourceAmount() async {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        await vm.onStart()
        
        // When
        let input: Double = 100.0
        vm.sourceCurrency = sourceCurrency
        vm.targetCurrency = targetCurrency
        vm.targetAmountStr = String(input)
        
        // Then
        let expected: Double = rates[sourceCurrency]! / rates[targetCurrency]! * input
        
        XCTAssertTrue(DoubleUtils.equals(vm.sourceAmount, expected))
        XCTAssertEqual(vm.sourceAmountStr, String(expected))
    }

}
