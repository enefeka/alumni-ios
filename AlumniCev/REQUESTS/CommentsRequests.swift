import Foundation
import Alamofire
import CPAlertViewController

func requestCreateComment(title:String, description:String, id_event:Int, action:@escaping ()->()){

    let url = URL(string: ACTIVEURL + "createcomment")
    let parameters: Parameters = ["title":title, "description":description, "id_event": id_event]
    
    let token = getDataInUserDefaults(key:"token")
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .post, parameters: parameters, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            
            var arrayResult = response.result.value as! Dictionary<String, Any>
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    
                    action()
                    print("comentario creado")
                    
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

func requestDeleteComment(id_comment:Int, action:@escaping ()->()){

    let url = URL(string: ACTIVEURL + "deletecomment")
    let parameters: Parameters = ["id_comment": id_comment]
    
    let token = getDataInUserDefaults(key:"token")
    
    let headers: HTTPHeaders = [
        "Authorization": token!,
        "Accept": "application/json"
    ]
    
    Alamofire.request(url!, method: .post, parameters: parameters, headers: headers).responseJSON{response in
        
        if (response.result.value != nil){
            
            var arrayResult = response.result.value as! Dictionary<String, Any>
            let alert = CPAlertViewController()
            switch response.result {
            case .success:
                switch arrayResult["code"] as! Int{
                case 200:
                    
                    alert.showSuccess(title: arrayResult["message"] as? String, buttonTitle: "ok" )
                    
                    action()
                    print("comentario borrado")
                    
                default:
                    print(arrayResult["message"] as! String)
                    alert.showError(title: arrayResult["message"] as? String, buttonTitle: "ok" )
                }
            case .failure:
                print("Error :: \(String(describing: response.error))")
            }
            
        }
    }
}
