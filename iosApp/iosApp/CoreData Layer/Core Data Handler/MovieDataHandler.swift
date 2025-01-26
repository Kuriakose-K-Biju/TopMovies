//
//  MovieDataHandler.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 26/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import CoreData

struct MovieDataHandler {
    func create(movieRecord: MovieModel, castRecord: CastModel) {
        let managerObjctContect = CoreDataHelper.shared.persistentContainer.viewContext
        let movieData = CDMovies(context: managerObjctContect)
        movieData.uuid = UUID()
        movieData.id = Int64(movieRecord.id)
        movieData.overview = movieRecord.overview
        movieData.posterPath = movieRecord.posterPath
        movieData.releaseDate = movieRecord.releaseDate
        movieData.title = movieRecord.title
        movieData.voteAverage = movieRecord.voteAverage ?? 0.0
        if !movieRecord.productionCompanies.isEmpty {
            var companySet = Set<CDProductionCompany>()
            movieRecord.productionCompanies.forEach { productionCompany in
                let cdProductionCompany = CDProductionCompany(context: managerObjctContect)
                cdProductionCompany.uuid = UUID()
                cdProductionCompany.id = Int64(productionCompany.id)
                cdProductionCompany.name = productionCompany.name

                companySet.insert(cdProductionCompany)
            }
            movieData.toProductionCompany = companySet
        }
        
        if !castRecord.cast.isEmpty {
            var castSet = Set<CDCasts>()
            castRecord.cast.forEach { cast in
                let cdCast = CDCasts(context: managerObjctContect)
                cdCast.uuid = UUID()
                cdCast.id = Int64(cast.id)
                cdCast.name = cast.name
                cdCast.profilePath = cast.profilePath
                castSet.insert(cdCast)
            }
            movieData.toCasts = castSet
        }
        CoreDataHelper.shared.saveContext()
    }
    
    func get(byIdentifier id: Int) -> CDMovies? {
        let fetchRequest = NSFetchRequest<CDMovies>(entityName: "CDMovies")
        let fetchById = NSPredicate(format: "id==%i", id)
        fetchRequest.predicate = fetchById

        let result = try! CoreDataHelper.shared.persistentContainer.viewContext.fetch(fetchRequest)
        guard result.count != 0 else {return nil}

        return result.first
    }
}
