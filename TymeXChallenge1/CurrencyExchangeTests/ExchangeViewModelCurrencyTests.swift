//
//  ExchangeViewModelTests.swift
//  CurrencyExchangeTests
//
//  Created by KHANH VAN on 20/11/24.
//

import XCTest
@testable import CurrencyExchange

final class ExchangeViewModelCurrencyTests: XCTestCase {
    
    var viewModel: ExchangeViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mockProvider: CurrencyExchangeProvider = MockCurrencyExchangeProvider()
        let factory = ExchangeModelFactory(provider: mockProvider)

        viewModel = ExchangeViewModel(exchangeModelFactory: factory)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func test_ExchangeViewModel_currency_shouldBeDefault() async {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        await vm.onStart()
        
        // Then
        XCTAssertTrue(vm.sourceCurrency == "USD")
        XCTAssertTrue(vm.targetCurrency == "VND")
    }
    
    func test_ExchangeViewModel_sourceCurrency_shouldSwap() async {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        await vm.onStart()
        
        vm.sourceCurrency = "USD"
        vm.targetCurrency = "VND"
        
        // When
        vm.sourceCurrency = "VND"   // Simulate UI change
        vm.handleSourceCurrencyChange("USD", "VND")
        
        // Then
        XCTAssertTrue(vm.sourceCurrency == "VND")
        XCTAssertTrue(vm.targetCurrency == "USD")
    }
    
    func test_ExchangeViewModel_targetCurrency_shouldSwap() async {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        await vm.onStart()
        
        vm.sourceCurrency = "USD"
        vm.targetCurrency = "VND"
        
        // When
        vm.targetCurrency = "USD"   // Simulate UI change
        vm.handleTargetCurrencyChange("VND", "USD")
        
        // Then
        XCTAssertTrue(vm.sourceCurrency == "VND")
        XCTAssertTrue(vm.targetCurrency == "USD")
    }

}
