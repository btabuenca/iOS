//
//  Persistence.swift
//  LearnTracker
//
//  Created by Bernardo Tabuenca
//

import UIKit

class Persistence: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var courseId: String
    var courseName: String
    
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("session")
    
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let courseIdKey = "courseId"
        static let courseNameKey = "courseName"
    }

    // MARK: Initialization
    
    init?(name: String, courseId: String, courseName: String) {
        // Initialize stored properties.
        self.name = name
        self.courseId = courseId
        self.courseName = courseName
        
        super.init()
        
        // Initialization should fail if there is no values
        if name.isEmpty || courseId.isEmpty || courseName.isEmpty {
            print("Name, courseId or courseName are empty in Session.init")
            
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(courseId, forKey: PropertyKey.courseIdKey)
        aCoder.encodeObject(courseName, forKey: PropertyKey.courseNameKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let courseId = aDecoder.decodeObjectForKey(PropertyKey.courseIdKey) as! String
        let courseName = aDecoder.decodeObjectForKey(PropertyKey.courseNameKey) as! String
        
        // Must call designated initializer.
        self.init(name: name, courseId: courseId, courseName: courseName)
    }

}