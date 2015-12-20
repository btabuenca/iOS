//
//  User.swift
//  LearnTracker
//
//  Created by Bernardo Tabuenca
//

import UIKit

class Session: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var course: String
    
    HAY QUE HACER QUE ESTO SEA UN COURSE Y NO UN STRING PARA PODER ALMANCENARLO AL HACER LONG CLICK

    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("session")
    
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let courseKey = "course"
    }

    // MARK: Initialization
    
    init?(name: String, course: String) {
        // Initialize stored properties.
        self.name = name
        self.course = course
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || course.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(course, forKey: PropertyKey.courseKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let course = aDecoder.decodeObjectForKey(PropertyKey.courseKey) as! String
        
        // Must call designated initializer.
        self.init(name: name, course: course)
    }

}