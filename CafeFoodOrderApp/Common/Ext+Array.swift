//
//  Ext+Array.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 28/11/24.
//

import Foundation

// Sorting extension for arrays of DataItem
extension Array where Element == HistoryData {
    /// Sorts the array of DataItems by the or_created_on date string
    /// - Parameter ascending: Whether to sort in ascending (true) or descending (false) order
    /// - Returns: Sorted array of DataItems
    func sortedByDate(ascending: Bool = true) -> [HistoryData] {
        return self.sorted { (item1, item2) -> Bool in
            guard let date1 = item1.createdOn.toDate(),
                  let date2 = item2.createdOn.toDate() else {
                return false
            }
            
            return ascending ? (date1 < date2) : (date1 > date2)
        }
    }
}
