import Foundation
import Alamofire

func requestTypes(controller:UIViewController){


    let url = URL(string: ACTIVEURL + "listtypes")
    let token = getDataInUserDefaults(key:"token")
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .get, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
        
            var arrayResult = response.result.value as! Dictionary<String, Any>
            print("Request Groups types")
            print(arrayResult)
            
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    types = arrayResult["data"] as! [Dictionary<String,String>]
                    
                default:
                    
                    print(arrayResult["message"] as! String)
                }
            case .failure:
                
                print("Error :: \(String(describing: response.error))")
                //alert.showError(title: (String(describing: response.error), buttonTitle: "OK")
            }
        }
    }
}

func requestGroups(action: @escaping ()->()){

    let url = URL(string: ACTIVEURL + "listgroups")
    let token = getDataInUserDefaults(key:"token")
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .get, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            
            var arrayResult = response.result.value as! Dictionary<String, Any>
            print("imprimiendo data")
            print(arrayResult["data"]!)
            var arrayData = arrayResult["data"]! as! Dictionary<String,Any>
            
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:

                    
                    groups = arrayData["groups"] as! [Dictionary<String,Any>]
                    
                    action()
                    
                default:
                    
                    print(arrayResult["message"] as! String)
                }
            case .failure:
                
                print("Error :: \(String(describing: response.error))")
                //alert.showError(title: (String(describing: response.error), buttonTitle: "OK")
            }
        }
    }
}

func requestGroupsbyUser (action: @escaping ()->()){

    let url = URL(string: ACTIVEURL + "groupsuserclient")
    let id_user = getDataInUserDefaults(key: "id")!
    let parameters: Parameters = ["id_user":id_user]
    print("holi!!!!")
    print(id_user)
    
    let token = getDataInUserDefaults(key:"token")
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .get, parameters: parameters, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            
            var arrayResult = response.result.value as! Dictionary<String, Any>
            print("holiiii")
            print(arrayResult)
            print("chaoooooo")

            var arrayData = arrayResult["data"]! as! Dictionary<String,Any>
            
            print(arrayData)
            print("holi22222222222")
            print(arrayData["groups"])
            print("chao222222222")
            
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    
                    groups = arrayData["groups"] as! [Dictionary<String,Any>]
                    action()
                default:
                    
                    print(arrayResult["message"] as! String)
                }
            case .failure:
                
                print("Error :: \(String(describing: response.error))")
                //alert.showError(title: (String(describing: response.error), buttonTitle: "OK")
            }
        }
    }
}
