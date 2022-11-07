//
//  DonwloaderHandlerTests.swift
//  leboncoinTests
//
//  Created by Kandara Marouene on 07/11/2022.
//

import XCTest
@testable import leboncoin

final class DonwloaderHandlerTests: XCTestCase {
    
    func testDonaloadEmptyImage() {
        let imageView = createImageView()
        Downloader.downloadImage(imageView, link: "")
        
        DispatchQueue.main.async {
            XCTAssertNotNil(imageView.image)
            XCTAssertEqual(imageView.image, UIImage(named: "placehold"))
        }
    }

    func testDonaloadRealImage() {
        let imageView = createImageView()
        Downloader.downloadImage(imageView, link: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/e1471155018c91ff51a34c75f786c73010d6307e.jpg")
        DispatchQueue.main.async {
            XCTAssertNotNil(imageView.image)
            XCTAssertNotEqual(imageView.image, UIImage(named: "placehold"))
        }
        
    }
    
    func createImageView() -> UIImageView {
        return UIImageView()
    }

}
