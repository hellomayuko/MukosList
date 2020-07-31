//
//  Date+Extensions.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import Foundation

extension Date {
    var timeStampString: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: self)
        }
    }
    
    var currentTimeString: String {
        get {
            let dateFormatter = DateFormatter()
            
            let locale = NSLocale.current
            let timeFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale)!
            if timeFormat.contains("a") {
                //12 hour
                dateFormatter.dateFormat = "h a"
            } else{
                //24 hour
                dateFormatter.dateFormat = "HH:mm"
            }
            return dateFormatter.string(from: self)
        }
    }
    
    var greeting: String {
        let calendar = Calendar.current
        let hourComponent = calendar.dateComponents([.hour], from: self)
        guard let hour = hourComponent.hour else {
            return "Hello"
        }
        if(hour < 12) {
            return "Good Morning"
        } else if(hour < 16) {
            return "Good Afternoon"
        } else if(hour < 24) {
            return "Good Evening"
        } else {
            return "Hello"
        }
    }
}
