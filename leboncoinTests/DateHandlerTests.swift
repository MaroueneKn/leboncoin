//
//  DateHandlerTest.swift
//  leboncoinTests
//
//  Created by Kandara Marouene on 06/11/2022.
//

import XCTest
@testable import leboncoin

final class DateHandlerTests: XCTestCase {
    
    func testStringToDate() {
        let dateString1 = "2019-09-15T18:31:30+0000"
        let dateString2 = ""
        
        XCTAssertNotNil(DateHandler.stringToDate(dateString1))
        XCTAssertNil(DateHandler.stringToDate(dateString2))
        
        let date = DateHandler.stringToDate(dateString1)
        let compenents = date?.get(.day, .month, .year, .hour, .minute)
        
        XCTAssertEqual(compenents?.day, 15)
        XCTAssertEqual(compenents?.month, 09)
        XCTAssertEqual(compenents?.year, 2019)
    }
    

    func testDateToString() {
        var dateComponents = DateComponents()
        dateComponents.year = 1980
        dateComponents.month = 7
        dateComponents.day = 11
        dateComponents.timeZone = TimeZone.current
        dateComponents.hour = 22
        dateComponents.minute = 34
        let userCalendar = Calendar.current
        let date = userCalendar.date(from: dateComponents)
        
        if let date = date {
            let dateString = DateHandler.dateToString(date)
            XCTAssertNotNil(DateHandler.dateToString(date))
            XCTAssertEqual(dateString, "11 juil. 1980, 22:34")
        }
    }
    
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
}
