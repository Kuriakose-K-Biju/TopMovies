//
//  CDImages+CoreDataProperties.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 27/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//
//

import Foundation
import CoreData


extension CDImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDImages> {
        return NSFetchRequest<CDImages>(entityName: "CDImages")
    }

    @NSManaged public var url: String?
    @NSManaged public var imageData: Data?

}

extension CDImages : Identifiable {

}
