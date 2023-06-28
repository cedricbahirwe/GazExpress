//
//  HistoryViewModel.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 28/06/2023.
//

import Foundation

final class HistoryViewModel : ObservableObject {
    @Published private(set) var records: [History] = []
    
    init() {
        self.loadHistory()
    }
    
    func loadHistory() {
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
}

