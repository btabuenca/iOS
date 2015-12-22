//
//  Activity.swift
//  LearnTracker
//
//  Created by Bernardo Tabuenca on 09/12/15.
//  Copyright © 2015 Bernardo Tabuenca. All rights reserved.
//


struct Activity {
    let idUser : String
    let idSubject : String
    let dateCheckIn : Int64
    let dateCheckOut : Int64
    let recordMode : Int
    
    
    static let KEY_IDUSER = "id_user"
    static let KEY_IDSUBJECT = "id_subject"
    static let KEY_RECORDMODE = "activity_record_mode"
    static let KEY_LOCATION_LONGITUDE = "activity_location_longitude"
    static let KEY_LOCATION_LATITUDE = "activity_location_latitude"
    static let KEY_CHECKIN = "activity_date_checkout"
    static let KEY_CHECKOUT = "activity_date_checkin"
    
}