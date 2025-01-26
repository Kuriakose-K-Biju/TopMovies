//
//  CDProductionCompany+CoreDataProperties.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//
//

import Foundation
import CoreData


extension CDProductionCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProductionCompany> {
        return NSFetchRequest<CDProductionCompany>(entityName: "CDProductionCompany")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var uuid: UUID?

}

extension CDProductionCompany : Identifiable {

}

//MARK: Convert to model value for easy handling
extension CDProductionCompany {
    func convertToProductionCompany() -> ProductionCompany {
        return ProductionCompany(id: Int(self.id), name: self.name)
    }
}
