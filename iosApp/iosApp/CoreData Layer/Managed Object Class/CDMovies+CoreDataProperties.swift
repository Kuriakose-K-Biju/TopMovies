//
//  CDMovies+CoreDataProperties.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//
//

import Foundation
import CoreData


extension CDMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovies> {
        return NSFetchRequest<CDMovies>(entityName: "CDMovies")
    }

    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var uuid: UUID?
    @NSManaged public var toProductionCompany: Set<CDProductionCompany>?
    @NSManaged public var toCasts: Set<CDCasts>?

}

// MARK: Generated accessors for toProductionCompany
extension CDMovies {

    @objc(addToProductionCompanyObject:)
    @NSManaged public func addToToProductionCompany(_ value: CDProductionCompany)

    @objc(removeToProductionCompanyObject:)
    @NSManaged public func removeFromToProductionCompany(_ value: CDProductionCompany)

    @objc(addToProductionCompany:)
    @NSManaged public func addToToProductionCompany(_ values: Set<CDProductionCompany>)

    @objc(removeToProductionCompany:)
    @NSManaged public func removeFromToProductionCompany(_ values: Set<CDProductionCompany>)

}

// MARK: Generated accessors for toCasts
extension CDMovies {

    @objc(addToCastsObject:)
    @NSManaged public func addToToCasts(_ value: CDCasts)

    @objc(removeToCastsObject:)
    @NSManaged public func removeFromToCasts(_ value: CDCasts)

    @objc(addToCasts:)
    @NSManaged public func addToToCasts(_ values: Set<CDCasts>)

    @objc(removeToCasts:)
    @NSManaged public func removeFromToCasts(_ values: Set<CDCasts>)

}

extension CDMovies : Identifiable {

}

//MARK: Convert to model value for easy handling
extension CDMovies {
    func convertToCast() -> CastModel {
        guard self.toCasts != nil && self.toCasts?.count != 0 else {return CastModel(cast: [])}

        var casts: [Cast] = []

        self.toCasts?.forEach({ (cdCast) in
            casts.append(cdCast.convertToCast())
        })
        return CastModel(cast: casts)
    }
    
    func convertToMovie() -> MovieModel {
        return MovieModel(id: Int(self.id), overview: self.overview, posterPath: self.posterPath, productionCompanies: self.convertToProdCompany(), releaseDate: self.releaseDate, title: self.title, voteAverage: self.voteAverage)
//        return Person(_id: self.id!, _name: self.name!, _vehicle: self.convertToVechiles())
    }

    private func convertToProdCompany() -> [ProductionCompany] {
        guard self.toProductionCompany != nil && self.toProductionCompany?.count != 0 else {return []}

        var productionCompany: [ProductionCompany] = []

        self.toProductionCompany?.forEach({ (cdProductionCompany) in
            productionCompany.append(cdProductionCompany.convertToProductionCompany())
        })

        return productionCompany
    }
}
