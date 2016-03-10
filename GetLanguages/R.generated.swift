// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift

import Foundation
import Rswift
import TransitionOperator
import UIKit

struct R: Rswift.Validatable {
  static func validate() throws {
    try intern.validate()
  }
  
  struct file {
    static let propertiesJson = FileResource(bundle: _R.hostingBundle, name: "properties", pathExtension: "json")
    
    static func propertiesJson(_: Void) -> NSURL? {
      let fileResource = R.file.propertiesJson
      return fileResource.bundle?.URLForResource(fileResource)
    }
    
    static func propertiesJson(_: Void) -> String? {
      let fileResource = R.file.propertiesJson
      return fileResource.bundle?.pathForResource(fileResource)
    }
  }
  
  struct font {
    
  }
  
  struct image {
    
  }
  
  private struct intern: Rswift.Validatable {
    static func validate() throws {
      try _R.validate()
    }
  }
  
  struct nib {
    
  }
  
  struct reuseIdentifier {
    static let caughtLanguageCell: ReuseIdentifier<UITableViewCell> = ReuseIdentifier(identifier: "CaughtLanguageCell")
  }
  
  struct segue {
    struct caughtLanguageListViewController {
      static let languageDetailSegue: StoryboardSegueIdentifier<TransitionExecutorSegue, CaughtLanguageListViewController, LanguageDetailViewController> = StoryboardSegueIdentifier(identifier: "LanguageDetailSegue")
      
      static func languageDetailSegue(segue segue: UIStoryboardSegue) -> TypedStoryboardSegueInfo<TransitionExecutorSegue, CaughtLanguageListViewController, LanguageDetailViewController>? {
        return TypedStoryboardSegueInfo(segueIdentifier: R.segue.caughtLanguageListViewController.languageDetailSegue, segue: segue)
      }
    }
    
    struct languageCatcherViewController {
      static let caughtLanguageListSegue: StoryboardSegueIdentifier<TransitionExecutorSegue, LanguageCatcherViewController, CaughtLanguageListViewController> = StoryboardSegueIdentifier(identifier: "CaughtLanguageListSegue")
      
      static func caughtLanguageListSegue(segue segue: UIStoryboardSegue) -> TypedStoryboardSegueInfo<TransitionExecutorSegue, LanguageCatcherViewController, CaughtLanguageListViewController>? {
        return TypedStoryboardSegueInfo(segueIdentifier: R.segue.languageCatcherViewController.caughtLanguageListSegue, segue: segue)
      }
    }
  }
  
  struct storyboard {
    static let caughtLanguageList = _R.storyboard.caughtLanguageList()
    static let languageDetail = _R.storyboard.languageDetail()
    static let launchScreen = _R.storyboard.launchScreen()
    static let main = _R.storyboard.main()
    
    static func caughtLanguageList(_: Void) -> UIStoryboard {
      return UIStoryboard(resource: R.storyboard.caughtLanguageList)
    }
    
    static func languageDetail(_: Void) -> UIStoryboard {
      return UIStoryboard(resource: R.storyboard.languageDetail)
    }
    
    static func launchScreen(_: Void) -> UIStoryboard {
      return UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    static func main(_: Void) -> UIStoryboard {
      return UIStoryboard(resource: R.storyboard.main)
    }
  }
}

struct _R: Rswift.Validatable {
  static let hostingBundle = NSBundle(identifier: "jp.caph.GetLanguages")
  
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
    }
    
    struct caughtLanguageList: StoryboardResourceWithInitialControllerType {
      typealias InitialController = CaughtLanguageListViewController
      
      let bundle = _R.hostingBundle
      let name = "CaughtLanguageList"
    }
    
    struct languageDetail: StoryboardResourceWithInitialControllerType {
      typealias InitialController = LanguageDetailViewController
      
      let bundle = _R.hostingBundle
      let name = "LanguageDetail"
    }
    
    struct launchScreen: StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIViewController
      
      let bundle = _R.hostingBundle
      let name = "LaunchScreen"
    }
    
    struct main: StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UINavigationController
      
      let bundle = _R.hostingBundle
      let name = "Main"
      
      func languageCatcherViewController() -> LanguageCatcherViewController? {
        return UIStoryboard(resource: self).instantiateViewControllerWithIdentifier("LanguageCatcherViewController") as? LanguageCatcherViewController
      }
      
      static func validate() throws {
        if _R.storyboard.main().languageCatcherViewController() == nil { throw ValidationError(description:"[R.swift] ViewController with identifier 'languageCatcherViewController' could not be loaded from storyboard 'Main' as 'LanguageCatcherViewController'.") }
      }
    }
  }
}