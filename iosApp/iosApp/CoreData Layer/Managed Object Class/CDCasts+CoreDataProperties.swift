//
//  CDCasts+CoreDataProperties.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//
//

import Foundation
import CoreData


extension CDCasts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCasts> {
        return NSFetchRequest<CDCasts>(entityName: "CDCasts")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var profilePath: String?
    @NSManaged public var uuid: UUID?

}

extension CDCasts : Identifiable {

}

//MARK: Convert to model value for easy handling
extension CDCasts {
    func convertToCast() -> Cast {
        return Cast(id: Int(self.id), name: self.name, profilePath: self.profilePath)
    }
}
