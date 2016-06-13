//
//  MemeEditorUITests.swift
//  MemeEditorUITests
//
//  Created by Himanshu Pandey on 6/8/16.
//  Copyright © 2016 Himanshu Pandey. All rights reserved.
//

import XCTest

class MemeEditorUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let app = XCUIApplication()
        let imageGalleryButton = app.toolbars.buttons["Image Gallery"]
        imageGalleryButton.tap()
        
        let cameraRollButton = app.tables.buttons["Camera Roll"]
        cameraRollButton.tap()
        
        let photosgridviewCollectionView = app.collectionViews["PhotosGridView"]
        photosgridviewCollectionView.cells["Photo, Landscape, August 08, 2012, 2:55 PM"].tap()
        XCUIDevice.sharedDevice().orientation = .LandscapeRight
        
        let topTextField = app.textFields["TOP"]
        topTextField.tap()
        topTextField.tap()
        app.textFields["TOP"]
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        app.typeText("\n")
        app.textFields["BOTTOM"].tap()
        app.textFields["BOTTOM"]
        returnButton.tap()
        app.typeText("\n")
        
        let titleNavigationBar = app.navigationBars["TItle"]
        titleNavigationBar.buttons["Share"].tap()
        app.sheets.collectionViews.collectionViews.buttons["Save Image"].tap()
        imageGalleryButton.tap()
        cameraRollButton.tap()
        photosgridviewCollectionView.cells["Photo, Landscape, 2:13 PM"].tap()
        titleNavigationBar.buttons["Cancel"].tap()
        
        
    
    }
    
}
