//
//  DateHelperTests.swift
//  gb-hw1-project1Tests
//
//  Created by Юлия Дебелова on 27.08.2023.
//

import XCTest
@testable import gb_hw1_project1

final class DateHelperTests: XCTestCase {
    //rivate var helper: DateHelper!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDrawDate() throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        let date = dateFormatter.date(from: "2023-08-05 01:02:03")
        let dateString = DateHelper.drawDate(date: date)
        XCTAssertEqual(dateString, "5 авг. 2023 г., 01:02:03", "Некорректный формат даты")
    }

}
