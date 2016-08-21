//
//  StreakManager.swift
//  Sticks HD Swift
//
//  Created by Henrique Morbin on 02/02/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit
import SwiftDate

public struct Streak {
    
    // MARK: Public Methods
    
    static private let keychain = KeychainSwift()
    
    static public func didBecomeActive() {
        add(date: currentDay, inKey: Key.days)
        add(date: currentWeek, inKey: Key.weeks)
        add(date: currentMonth, inKey: Key.months)
        add(date: currentYear, inKey: Key.years)
    }
    
    static public func ofDays() -> Int{
        return of(inKey: Key.days, dayToCheck: { (add) -> NSDate in
            return currentDay.add(days: add)
        })
    }
    
    static public func ofWeeks() -> Int{
        return of(inKey: Key.weeks, dayToCheck: { (add) -> NSDate in
            return currentWeek.add(days: add*7)
        })
    }
    
    static public func ofMonths() -> Int{
        return of(inKey: Key.months, dayToCheck: { (add) -> NSDate in
            return currentMonth.add(months: add)
        })
    }
    
    static public func ofYears() -> Int{
        return of(inKey: Key.years, dayToCheck: { (add) -> NSDate in
            return currentYear.add(add)
        })
    }
    
    // MARK: Private Methods
    
    static private func add(date date: NSDate, inKey key: String) {
        guard let data = keychain.getData(key), var list = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [NSDate] else {
            keychain.set(NSKeyedArchiver.archivedDataWithRootObject([date]), forKey: key)
            return
        }

        if !list.contains(date) {
            list.append(date)
            keychain.set(NSKeyedArchiver.archivedDataWithRootObject([date]), forKey: key)
        }
    }
    
    static private func of(inKey key: String, dayToCheck: ((add: Int) -> NSDate)) -> Int{
        guard let data = keychain.getData(key), var list = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [NSDate] else {
            return 0
        }
        
        var streak = 1
        for savedDate in list.reverse() {
            let checkDate = dayToCheck(add: -1 * streak)
            
            if savedDate == checkDate {
                streak++
            } else {
                return streak
            }
        }
        
        return streak
    }
}

private struct Key {
    static let days = "streak.days"
    static let weeks = "streak.weeks"
    static let months = "streak.months"
    static let years = "streak.years"
}

private var currentDay : NSDate {
    return NSDate().startOf(.Day)
}

private var currentWeek : NSDate {
    return NSDate().startOf(.WeekOfYear)
}

private var currentMonth : NSDate {
    return NSDate().startOf(.Month)
}

private var currentYear : NSDate {
    return NSDate().startOf(.Year)
}
