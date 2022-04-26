//
//  AssetKit.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import UIKit

extension UIFont {
    
    open class func latoBold(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    open class func urbanistLight(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Urbanist-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    open class var heading1: UIFont {
        return UIFont(name: "Lato-Bold", size: 24) ?? UIFont.boldSystemFont(ofSize: 24)
    }
    open class var heading2: UIFont {
        return UIFont(name: "Lato-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
    }
    open class var heading3: UIFont {
        return UIFont(name: "Lato-Bold", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
    }
    open class var body1: UIFont {
        return UIFont(name: "Urbanist-Light", size: 20) ?? UIFont.systemFont(ofSize: 20)
    }
    open class var body2: UIFont {
        return UIFont(name: "Urbanist-Light", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
    open class var body3: UIFont {
        return UIFont(name: "Urbanist-Light", size: 12) ?? UIFont.systemFont(ofSize: 12)
    }
}

extension UIImage {
    
    open class var appIcon: UIImage {
        return UIImage(named: "WargaIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var welcomingImage: UIImage {
        return UIImage(named: "WelcomingImage")!.withRenderingMode(.alwaysOriginal)
    }
    open class var chevronDown: UIImage {
        return UIImage(systemName: "chevron.down")!.withRenderingMode(.alwaysOriginal)
    }
    open class var chevronLeft: UIImage {
        return UIImage(named: "ChevronLeft")!.withRenderingMode(.alwaysOriginal)
    }
    open class var chevronRight: UIImage {
        return UIImage(systemName: "chevron.right")!.withRenderingMode(.alwaysOriginal)
    }
    open class var signInImage: UIImage {
        return UIImage(named: "SignInImage")!.withRenderingMode(.alwaysOriginal)
    }
    open class var otpImage: UIImage {
        return UIImage(named: "OTPImage")!.withRenderingMode(.alwaysOriginal)
    }
    open class var folderFillIcon: UIImage {
        return UIImage(systemName: "folder.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var familyFillIcon: UIImage {
        return UIImage(systemName: "person.3.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var activityFillIcon: UIImage {
        return UIImage(systemName: "rectangle.3.offgrid.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var showInMapIcon: UIImage {
        return UIImage(systemName: "mappin.and.ellipse")!.withRenderingMode(.alwaysOriginal)
    }
    open class var bellFillIcon: UIImage {
        return UIImage(systemName: "bell.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var documentFillIcon: UIImage {
        return UIImage(systemName: "doc.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var personSquareFillIcon: UIImage {
        return UIImage(systemName: "person.crop.square.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var personCircleFillIcon: UIImage {
        return UIImage(systemName: "person.circle.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var squareGridFillIcon: UIImage {
        return UIImage(systemName: "square.grid.2x2.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var buildingIcon: UIImage {
        return UIImage(systemName: "building.2.crop.circle.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var citizenshipIcon: UIImage {
        return UIImage(systemName: "shield.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var houseCircleFillIcon: UIImage {
        return UIImage(systemName: "house.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var boltCircleFillIcon: UIImage {
        return UIImage(systemName: "bolt.circle.fill")!.withRenderingMode(.alwaysOriginal)
    }
    open class var medicalIcon: UIImage {
        return UIImage(named: "MedicalIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var dangerIcon: UIImage {
        return UIImage(named: "DangerIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var quarantineIcon: UIImage {
        return UIImage(named: "QuarantineIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var suspiciousIcon: UIImage {
        return UIImage(named: "SuspiciousIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var brokenImage: UIImage {
        return UIImage(named: "BrokenImage")!.withRenderingMode(.alwaysOriginal)
    }
    open class var indonesiaMap: UIImage {
        return UIImage(named: "IndonesiaMap")!.withRenderingMode(.alwaysOriginal)
    }
    open class var jakiIcon: UIImage {
        return UIImage(named: "JakiIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var homeIsometric: UIImage {
        return UIImage(named: "HomeIsometricIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var familyIsometric: UIImage {
        return UIImage(named: "FamilyIsometricIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var userIsometric: UIImage {
        return UIImage(named: "UserIsometricIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var locationIsometric: UIImage {
        return UIImage(named: "LocationIsometricIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var documentIsometric: UIImage {
        return UIImage(named: "DocumentIsometricIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var filesIsometric: UIImage {
        return UIImage(named: "FilesIsometricIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var starIsometric: UIImage {
        return UIImage(named: "StarIsometricIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var hospital3D: UIImage {
        return UIImage(named: "HospitalIcon3D")!.withRenderingMode(.alwaysOriginal)
    }
    open class var bloodTest3D: UIImage {
        return UIImage(named: "BloodTest3D")!.withRenderingMode(.alwaysOriginal)
    }
    open class var doctorCheck3D: UIImage {
        return UIImage(named: "DoctorCheck3D")!.withRenderingMode(.alwaysOriginal)
    }
    open class var vaccineNeedle3D: UIImage {
        return UIImage(named: "VaccineNeedle3D")!.withRenderingMode(.alwaysOriginal)
    }
    open class var okHand3D: UIImage {
        return UIImage(named: "OKHand3DImage")!.withRenderingMode(.alwaysOriginal)
    }
    open class var successActionIcon: UIImage {
        return UIImage(named: "SuccessActionIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var failureActionIcon: UIImage {
        return UIImage(named: "FailureActionIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var warningActionIcon: UIImage {
        return UIImage(named: "WarningActionIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var infoActionIcon: UIImage {
        return UIImage(named: "InfoActionIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var networkFailureActionIcon: UIImage {
        return UIImage(named: "NetworkFailureActionIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var doorOpenIcon: UIImage {
        return UIImage(named: "DoorOpenIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var cardActionIcon: UIImage {
        return UIImage(named: "CardActionIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var assignmentActionIcon: UIImage {
        return UIImage(named: "AssignmentActionIcon")!.withRenderingMode(.alwaysOriginal)
    }
    open class var descriptionActionIcon: UIImage {
        return UIImage(named: "DescriptionActionIcon")!.withRenderingMode(.alwaysOriginal)
    }
    
}

extension UIColor {
    
    open class var background: UIColor {
        return UIColor(named: "BackgroundColor")!
    }
    open class var primaryPurple: UIColor {
        return UIColor(named: "PrimaryPurple")!
    }
    open class var softPurple: UIColor {
        return UIColor(named: "SoftPurple")!
    }
    open class var border: UIColor {
        return UIColor(named: "Border")!
    }
    open class var primaryGreen: UIColor {
        return UIColor(named: "PrimaryGreen")!
    }
    open class var softRed: UIColor {
        return UIColor(named: "SoftRed")!
    }
    
}
