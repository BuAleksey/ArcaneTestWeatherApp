//
//  DateManager.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 29.09.2023.
//

import Foundation

enum DateOrTime {
    case today
    case moreDays
}

final class DateManager {
    static let shared = DateManager()
    
    private let currentDate = Date()
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    
    private init() {}

    func getCurrentUnixTimeInteval() -> Range<Int> {        
        let start = calendar.startOfDay(for: currentDate)
        let startUnixTimestamp = start.timeIntervalSince1970
        let startUnixTimestampInt = Int(startUnixTimestamp)

        let end = calendar.date(byAdding: .day, value: 1, to: start)!
        let endUnixTimestamp = end.timeIntervalSince1970
        let endUnixTimestampInt = Int(endUnixTimestamp)
        
        return startUnixTimestampInt..<endUnixTimestampInt
    }
    
    func getDateFromUnix(_ unixDate: Int, dateOrTime: DateOrTime) -> String {
        switch dateOrTime {
        case .today:
            dateFormatter.timeStyle = .short
        case .moreDays:
            dateFormatter.dateFormat = "dd/MM HH:MM"
        }
        let date = Date(timeIntervalSince1970: TimeInterval(unixDate))
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
