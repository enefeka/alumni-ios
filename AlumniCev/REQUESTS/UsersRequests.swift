import Foundation
import Alamofire


func requestAllUsers(action: @escaping ()->()){

    let url = URL(string: ACTIVEURL + "listusers")
    
    let token = getDataInUserDefaults(key:"token")
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .get, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            
            var arrayResult = response.result.value as! Dictionary<String, Any>
            print("la lista de usuarios essss.:::")
            print(arrayResult)
            
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    users = arrayResult["data"] as? [[String:Any]]
                    
                    action()
                default:
                    break

                }
            case .failure:
                
                print("Error :: \(String(describing: response.error))")
                //alert.showError(title: (String(describing: response.error), buttonTitle: "OK")
            }
        }
    }
}

func requestFriends(action: @escaping ()->()){

    let url = URL(string: ACTIVEURL + "listfriends")
    let token = getDataInUserDefaults(key:"token")
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .get, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            var arrayResult = response.result.value as! Dictionary<String, Any>
            
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    users = arrayResult["data"] as? [[String:Any]]
                    
                    action()
                default: break
                    
                    print(arrayResult["message"] as! String)
                }
            case .failure:
                break
                print("Error :: \(String(describing: response.error))")
                
            }
        }
        
    }
}

func requestUserById(id:Int, action: @escaping ()->()){

    let url = URL(string: ACTIVEURL + "userbyid")
    let token = getDataInUserDefaults(key:"token")
    let parameters:Parameters = ["id":id]
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    Alamofire.request(url!, method: .get, parameters:parameters, headers: headers).responseJSON{response in
        if (response.result.value != nil){
            
            var arrayResult = response.result.value as! Dictionary<String, Any>
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    var arrayData = arrayResult["data"] as! Dictionary<String,Any>
                    friend = arrayData["friend"] as? Dictionary<String,Any>
                    user = arrayData["user"] as? Dictionary<String,Any>
                    privacityUser = arrayData["privacity"] as? Dictionary<String,String>
                    action()
                default:
                    action()
                }
            case .failure:
                action()
            }
        }
    }
}

func requestRequests(action: @escaping ()->(), notRequests: @escaping ()->()){

    let url = URL(string: ACTIVEURL + "requests")
    let token = getDataInUserDefaults(key:"token")
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .get, headers: headers).responseJSON{response in
        if (response.result.value != nil){
            var arrayResult = response.result.value as! Dictionary<String, Any>
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    
                    if let arrayData = arrayResult["data"] as? [String:Any]{
                        requests = arrayData["requests"] as? [Dictionary<String, Any>]
                        action()
                    }
                case 400:
                    notRequests()
                default:
                    break
                    print(arrayResult["message"] as! String)
                }
            case .failure:
                break
                print("Error :: \(String(describing: response.error))")
                //alert.showError(title: (String(describing: response.error), buttonTitle: "OK")
            }
        }
    }
}

func requestChangePassword(lastPassword:String, password:String, action: @escaping ()->(), fail: @escaping ()->()){
    

    let url = URL(string: ACTIVEURL + "changepassword")
    
    let token = getDataInUserDefaults(key:"token")
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    let parameters: Parameters = ["lastpassword": lastPassword,
                                  "password":password]
    
    Alamofire.request(url!, method: .post, parameters: parameters, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            
            var arrayResult = response.result.value as! Dictionary<String, Any>
            
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    action()
                default:
                    
                    fail()
                    
                }
            case .failure:
                break
                print("Error :: \(String(describing: response.error))")
                
            }
        }
    }
}

func sendRequestFriend(id_user:Int, action: @escaping (_ message:String, _ code:Int)->()){

    let url = URL(string: ACTIVEURL + "sendrequest")
    
    let token = getDataInUserDefaults(key:"token")
    
    let parameters:Parameters = ["id_user":id_user]
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .post, parameters:parameters, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            var arrayResult = response.result.value as! Dictionary<String, Any>
            
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    action(arrayResult["message"] as! String, arrayResult["code"] as! Int)
                default:
                    action(arrayResult["message"] as! String, arrayResult["code"] as! Int)
                }
            case .failure:
                action(response.error as! String, 500)
            }
        }
    }
}

func requestResponseFriend(id_user:Int, type:Int, action:@escaping (_ message:String, _ code:Int)->()){

    let url = URL(string: ACTIVEURL + "responserequest")
    
    let token = getDataInUserDefaults(key:"token")
    
    let parameters:Parameters = ["id_user":id_user, "type":type]
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .post, parameters:parameters, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            
            var arrayResult = response.result.value as! Dictionary<String, Any>
            
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    action(arrayResult["message"] as! String, arrayResult["code"] as! Int)
                default:
                    action(arrayResult["message"] as! String, arrayResult["code"] as! Int)
                }
            case .failure:
                action(response.error as! String, 500)
            }
        }
    }
}

func requestFindUser(search:String, action: @escaping ()->(), notusers:@escaping ()->()){
    let url = URL(string: ACTIVEURL + "finduser")
    
    let token = getDataInUserDefaults(key:"token")
    
    let parameters:Parameters = ["search":search]
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .get, parameters:parameters, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            
            var arrayResult = response.result.value as! Dictionary<String, Any>
            
            switch response.result {
            case .success:
                let idCasted = (arrayResult["code"] as! NSNumber).intValue
                switch idCasted {
                case 200:
                    
                    users = arrayResult["data"] as? [[String:Any]]
                    
                    action()
                default:
                    users = nil
                    notusers()
                    print(arrayResult["message"] as! String)
                }
            case .failure: break
                
                print("Error :: \(String(describing: response.error))")
                
            }
        }
    }
}

func requestFindFriends(search:String, action: @escaping ()->(), notusers:@escaping ()->()){
    let url = URL(string: ACTIVEURL + "findfriend")
    
    let token = getDataInUserDefaults(key:"token")
    
    let parameters:Parameters = ["search":search]
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .get, parameters:parameters, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            
            var arrayResult = response.result.value as! Dictionary<String, Any>
            
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    
                    users = arrayResult["data"] as? [[String:Any]]
                    
                    action()
                default:
                    users = nil
                    notusers()
                }
            case .failure: break
                
                print("Error :: \(String(describing: response.error))")
                
            }
        }
    }
}

func requestDeleteFriend(id_user:Int, action: @escaping (_ message:String, _ code:Int)->()){
    let url = URL(string: ACTIVEURL + "deletefriend")
    
    let token = getDataInUserDefaults(key:"token")
    
    let parameters:Parameters = ["id_user":id_user]
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .post, parameters:parameters, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            
            var arrayResult = response.result.value as! Dictionary<String, Any>
            
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    action(arrayResult["message"] as! String, arrayResult["code"] as! Int)
                default:
                    action(arrayResult["message"] as! String, arrayResult["code"] as! Int)
                }
            case .failure:
                action(response.error as! String, 500)
                
            }
        }
    }
}

func requestCancelRequest(id_user:Int, action: @escaping  (_ message:String, _ code:Int)->()){
    
    let url = URL(string: ACTIVEURL + "cancelrequest")
    let token = getDataInUserDefaults(key:"token")
    let parameters:Parameters = ["id_user":id_user]
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    Alamofire.request(url!, method: .post, parameters:parameters, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            var arrayResult = response.result.value as! Dictionary<String, Any>
            
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    // borrar peticion de local
                    action(arrayResult["message"] as! String, arrayResult["code"] as! Int)
                default:
                    action(arrayResult["message"] as! String, arrayResult["code"] as! Int)
                    break
                }
            case .failure:
                action(response.error as! String, 500)
            }
        }
    }
}

func requestEditUser(id:Int,email:String?, name:String?, phone:String?, birthday:String?, description:String?, photo:Data?, phoneprivacity:Int?, localizationprivacity:Int?, action: @escaping ()->(), fail: @escaping ()->()){
    let url = URL(string: ACTIVEURL + "updateuser")
    
    var parameters: Parameters = ["id": id]
    
    if email != nil{
        parameters["email"] = email
    }
    
    if name != nil{
        parameters["name"] = name
    }
    
    if phone != nil{
        parameters["phone"] = phone
    }
    
    if birthday != nil{
        parameters["birthday"] = birthday
    }
    
    if description != nil{
        parameters["description"] = description
    }
    
    if phoneprivacity != nil{
        parameters["phoneprivacity"] = phoneprivacity
    }
    
    if localizationprivacity != nil{
        parameters["localizationprivacity"] = localizationprivacity
    }
    
    let token = getDataInUserDefaults(key:"token")
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.upload(multipartFormData: { multipartFormData in
        
        for (key, value) in parameters {
            multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
            
        }
        if photo != nil{
            multipartFormData.append(photo!, withName: "photo", fileName: "photo.jpeg", mimeType: "image/jpeg")
        }
        
    },
                     
                     to: url!,
                     headers:headers,
                     
                     encodingCompletion: { encodingResult in
                        
                        switch encodingResult {
                            
                        case .success(let upload, _, _):
                            upload.responseJSON { response in
                                
                                if (response.result.value != nil){
                                    
                                    var arrayResult = response.result.value as! Dictionary<String, Any>
                                    
                                    if response.result.value != nil {
                                        
                                        let code = arrayResult["code"] as! Int
                                        
                                        switch code{
                                        case 200:
                                            action()
                                            print("Usuario editado")
                                        case 400:
                                            
                                            fail()
                                            print(arrayResult)
                                            
                                        default:
                                            
                                            fail()
                                            print(arrayResult)
                                            
                                        }
                                        
                                    }
                                }
                                
                            }
                        case .failure(let encodingError):
                            fail()
                            print(encodingError)
                            // your implementation
                        }
    })
}
