import Foundation
import Alamofire

class DataService {
    
    private static var _sharedManager : SessionManager?
    private static var _activeStore : Store?
    
    static var sharedManager : SessionManager {
        get{
            return _sharedManager!
        }
        set{
            _sharedManager = newValue
        }
    }
    
    static var activeStore : Store {
        get{
            return _activeStore!
        }
        set{
            _activeStore = newValue
        }
    }
    
}
