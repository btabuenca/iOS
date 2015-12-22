//
//  Assignment.swift
//  LearnTracker
//
//  Created by Bernardo Tabuenca on 30/10/15.
//  Copyright © 2015 Bernardo Tabuenca. All rights reserved.
//

import Foundation

// 
// Persistence
// https://developer.apple.com/library/prerelease/ios/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Lesson10.html
//

//
// Object assignment
// Assignment is mapped to Subject object in Backend
//
//{
//    "id": "5686230951919616",
//    "subject_desc": "LT2R1",
//    "subject_task_desc": "Hands-on",
//    "subject_task_alternative_desc": "Practical work",
//    "subject_task_date_start": "1454803200000",
//    "subject_task_time_duration": "36000000",
//    "subject_task_level": 0,
//    "subject_task_order": 0,
//    "kind": "subjectendpoint#resourcesItem"
//},
//

struct Assignment {
    
    let id : String
    let name : String
    let desc : String
    let order: Int
    
    
    static let KEY_ID = "id"
    static let KEY_NAME = "subject_task_desc"
    static let KEY_DESC = "subject_task_alternative_desc"
    static let KEY_ORDER = "subject_task_order"
    
    
//    static let KEY_START = "subject_task_date_start"
//    static let KEY_COURSE = "subject_desc"
//    static let KEY_LEVEL = "subject_task_level"
//    static let KEY_SCHED_DURATION = "subject_task_time_duration"
    
}
