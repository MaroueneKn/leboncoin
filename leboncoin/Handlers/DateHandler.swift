//
//  DateHandler.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation

class DateHandler {
    static func stringToDate(_ date : String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        if let result = dateFormatter.date(from: date) {
            return result
        }
        return nil
    }
    
    static func dateToString(_ date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
}
