//
//  HistoryViewModel.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 28/06/2023.
//

import Foundation

final class HistoryViewModel: ObservableObject {
    @Published private(set) var records: [History] = []
    
    init() {
        self.records = getHistory()
    }
    
    private func getHistory() -> [History] {
        guard let savedHistoryData = UserDefaults.standard.data(forKey: UserDefaultsKeys.history.rawValue)
        else { return [] }
        
        do {
            return try JSONDecoder().decode([History].self, from: savedHistoryData)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    func saveCartToHistory(_ newItem: History) {
        let defaults = UserDefaults.standard
        
        do {
            if let savedHistoryData = defaults.data(forKey: UserDefaultsKeys.history.rawValue),
               !savedHistoryData.isEmpty {
                var newHistory = try JSONDecoder().decode([History].self, from: savedHistoryData)
                newHistory.append(newItem)
                
                try saveItems(newHistory)
                                
            } else {
                try saveItems([newItem])
            }
        } catch {
            print(error.localizedDescription)
        }
        
        func saveItems(_ history: [History]) throws {
            let historyData = try JSONEncoder().encode(history)
            defaults.set(historyData, forKey: UserDefaultsKeys.history.rawValue)
            self.records = history
        }
    }
}
