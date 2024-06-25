//
//  SearchManagerTests.swift
//  ml-challengeTests
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation
import XCTest
import RxSwift
@testable import ml_challenge

final class SearchItemsManagerTests: XCTestCase {
    
    var manager: SearchItemsManager!
    var mockRepository: MockSearchItemRepository!
    var disposeBag: DisposeBag!
        
    override func setUpWithError() throws {
        mockRepository = MockSearchItemRepository()
        manager = SearchItemsManager.shared
        manager.replaceRepository(with: mockRepository) 
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        disposeBag = nil
        manager = nil
        mockRepository = nil
    }
    
    func testGetItemsByName_Success() throws {
        let data = Data(MockSearchItemRepository.searchItemSuccessJSON.utf8)
        let searchItemResponse = try JSONDecoder().decode(SearchItemResponse.self, from: data)
        mockRepository.searchItemResponse = Single.just(searchItemResponse)
        
        let expectation = self.expectation(description: "getItemsByName success")
        
        manager.getItemsByName("macbook", 0)
            .subscribe(onSuccess: { items in
                XCTAssertEqual(items.count, 1)
                XCTAssertEqual(items.first?.title, "Macbook Air M1 2020 Cinza-espacial 13.3 , Apple M1  8gb De Ram 256gb Ssd, Apple M1 8-core Gpu 60 Hz 2560x1600px Macos - Distribuidor Autorizado")
                XCTAssertEqual(items.first?.siteId, "MLB")
                expectation.fulfill()
            }, onError: { error in
                XCTFail("Unexpected error: \(error)")
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetItemsByName_EmptyResponse() throws {
        let data = Data(MockSearchItemRepository.searchItemEmptyResultsJSON.utf8)
        let searchItemResponse = try JSONDecoder().decode(SearchItemResponse.self, from: data)
        mockRepository.searchItemResponse = Single.just(searchItemResponse)
        
        let expectation = self.expectation(description: "getItemsByName empty response")
        
        manager.getItemsByName("macbook", 0)
            .subscribe(onSuccess: { _ in
                XCTFail("Expected error but got success")
            }, onError: { error in
                if let searchError = error as? SearchError, searchError == .noResults {
                    expectation.fulfill()
                } else {
                    XCTFail("Different error received: \(error)")
                }
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetItemsByName_Error() throws {
        mockRepository.searchItemResponse = Single.error(TestError.mockError)
        
        let expectation = self.expectation(description: "getItemsByName error")
        
        manager.getItemsByName("macbook", 0)
            .subscribe(onSuccess: { _ in
                XCTFail("Expected error but got success")
            }, onError: { error in
                XCTAssertEqual(error.localizedDescription, TestError.mockError.localizedDescription)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchBySellerId_Success() throws {
        let data = Data(MockSearchItemRepository.searchBySellerSuccesJSON.utf8)
        let searchItemResponse = try JSONDecoder().decode(SearchItemResponse.self, from: data)
        mockRepository.searchBySellerResponse = Single.just(searchItemResponse)

        let expectation = self.expectation(description: "searchBySellerId success")
        
        manager.searchBySellerId("480263032", "MLB1652")
            .subscribe(onSuccess: { items in
                XCTAssertEqual(items.count, 1)
                XCTAssertEqual(items.first?.title, "Notebook Gamer Anv15-51-582r Ci5 16gb 512ssd 15,6 Linux")
                XCTAssertEqual(items.first?.siteId, "MLB")
                expectation.fulfill()
            }, onError: { error in
                XCTFail("Unexpected error: \(error)")
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchBySellerId_EmptyResponse() throws {
        let data = Data(MockSearchItemRepository.searchBySellerEmptyJSON.utf8)
        let searchItemResponse = try JSONDecoder().decode(SearchItemResponse.self, from: data)
        mockRepository.searchBySellerResponse = Single.just(searchItemResponse)
        
        let expectation = self.expectation(description: "searchBySellerId empty response")
        
        manager.searchBySellerId("480263032", "MLB1652")
            .subscribe(onSuccess: { _ in
                XCTFail("Expected error but got success")
                expectation.fulfill()
            }, onError: { error in
                if let searchError = error as? SearchError, searchError == .noResults {
                    expectation.fulfill()
                } else {
                    XCTFail("Different error received: \(error)")
                }
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchBySellerId_Error() throws {
        mockRepository.searchBySellerResponse = Single.error(TestError.mockError)
        
        let expectation = self.expectation(description: "searchBySellerId error")
        
        manager.searchBySellerId("480263032", "MLB1652")
            .subscribe(onSuccess: { _ in
                XCTFail("Expected error but got success")
            }, onError: { error in
                XCTAssertEqual(error.localizedDescription, TestError.mockError.localizedDescription)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchByCategory_Success() throws {
        let data = Data(MockSearchItemRepository.searchByCategorySuccessJSON.utf8)
        let searchItemResponse = try JSONDecoder().decode(SearchItemResponse.self, from: data)
        mockRepository.searchByCategoryResponse = Single.just(searchItemResponse)

        let expectation = self.expectation(description: "searchByCategory success")
        
        manager.searchByCategory("MLB1652", 400)
            .subscribe(onSuccess: { items in
                XCTAssertEqual(items.count, 1)
                XCTAssertEqual(items.first?.title, "Notebook Asus Vivobook Go 15 E1504ga Intel Core I3 N305 8gb Ram 256gb Ssd Windows 11 Home Tela 15,6  Fhd Silver - Nj434w")
                XCTAssertEqual(items.first?.siteId, "MLB")
                expectation.fulfill()
            }, onError: { error in
                XCTFail("Unexpected error: \(error)")
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchByCategory_EmptyResponse() throws {
        let data = Data(MockSearchItemRepository.searchByCategoryEmptyJSON.utf8)
        let searchItemResponse = try JSONDecoder().decode(SearchItemResponse.self, from: data)
        mockRepository.searchByCategoryResponse = Single.just(searchItemResponse)
        
        let expectation = self.expectation(description: "searchByCategory empty response")
        
        manager.searchByCategory("MLB1652", 400)
            .subscribe(onSuccess: { _ in
                XCTFail("Expected error but got success")
                expectation.fulfill()
            }, onError: { error in
                if let searchError = error as? SearchError, searchError == .noResults {
                    expectation.fulfill()
                } else {
                    XCTFail("Different error received: \(error)")
                }
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchByCategory_Error() throws {
        mockRepository.searchByCategoryResponse = Single.error(TestError.mockError)
        
        let expectation = self.expectation(description: "searchByCategory error")
        
        manager.searchByCategory("MLB1652", 400)
            .subscribe(onSuccess: { _ in
                XCTFail("Expected error but got success")
            }, onError: { error in
                XCTAssertEqual(error.localizedDescription, TestError.mockError.localizedDescription)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
