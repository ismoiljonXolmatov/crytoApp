//
//  PortfoioService.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 20.03.2024.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioItem"
    
    @Published var savedEntities: [PortfolioItem] = []
    
    init () {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Portfolio")
            }
            self.getPortfolio()
        }
    }
    
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioItem>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching saved entities \(error.localizedDescription)")
        }
    }
    
    //MARK: - PUBLIC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        // check if entity already in portfolio
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
            if amount > 0 {
                update(entity: entity, newAmount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            // if not add it to portfolio
            add(coin: coin, amount: amount)
        }
    }
    
    
    //MARK: - PRIVATE
    private func save() {
        do  {
            try container.viewContext.save()
        } catch let error {
            print("Error saving: \(error.localizedDescription)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioItem(context: container.viewContext)
        entity.coinID = coin.id
        entity.holdingAmount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioItem, newAmount: Double) {
        entity.holdingAmount = newAmount
        applyChanges()
    }
    
    private func delete(entity: PortfolioItem) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
}

