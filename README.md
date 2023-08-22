# WisdomRouterKit

  1. address： https://github.com/tangjianfengVS/WisdomRouterKit

  2. Swift Version Support： 5.5, 5.6, 5.7

  3. cocoapods install：pod 'WisdomRouterKit', '0.3.1'

   
# 一. intro/简介：

  1. A powerful iOS router SDK.

  2. For componentization calls between modules, WisdomRouterKit can help you to a page attribute parameter and callback Block assignment, and support the big property parameters of quantitative and quantitative correction Block assignment, without any reference between each module, also need not define relationships between public agreement file for each module, really completely decouple, truly indomitable spirit.

  3. No matter the future function of the project or the rapid expansion and superposition of business code, there is no need for personnel maintenance and no maintenance cost.

  4. The advantage of API is that it is easy to call, flexible to use, and simple append registration call is realized. It only takes a few lines of registration code to expand the following Router function.

  5. WisdomRouterKit SDK is a pure swift code compilation, which ensures the efficient performance of SDK, supports exception fetching in the process of attribute assignment, and helps develop rapid location problems.

  6. For those of you who are working on OC projects, the WisdomRouterKit SDK has been developed to support support for OC project calls, even though pod integration is the way to go.

 【Chinese】
  1. 一个强大的iOS路由器SDK。

  2. 针对处理组件化模块之间的调用，WisdomRouterKit 可以帮你进行页面之间的属性参数和回调Block传递赋值，并且支持大量化的属性参数和大量化的回调Block传递赋值，无需各个子模块之间进行任何引用，也无需定义公共协议文件进行各个子模块之间关联，真正做到完全解偶，真正做到顶天立地。

  3. 无论项目将来功能或者业务代码快速的扩展叠加，无需人员维护，无需维护成本。

  4. API的优势是调用方便，使用灵活，实现了简洁的追加注册调用，只需要数行注册代码，我们就可以展开接下来的 Router 功能。

  5. WisdomRouterKit SDK是纯swift代码编写，保证了SDK高效性能，支持属性赋值过程中的异常抓取，帮助开发快速定位问题。

  6. OC 项目的小伙伴们也不要愁，WisdomRouterKit SDK完成支持OC项目调用，尽管pod集成就是了。

  
# 二. Register protocol introduce/ 注册协议介绍：

  1. To use WisdomRouterKit SDK, register the route object first.

  2. Implement WisdomRouterRegisterProtocol agreement, guarantee in advance registration for route objects：

         public protocol WisdomRouterRegisterProtocol {
    
             //MARK: - Register Router Protocol
             static func registerRouter()
         }

     note: Please see demo to use

  4. Implement WisdomRouterShareProtocol agreement, to ensure early registration for single route objects：

         @objc public protocol WisdomRouterShareProtocol{
    
             //MARK: - Router Shared Protocol
             func routerShared() -> WisdomRouterModel;
         }

     note: Please see demo to use

 【Chinese】
  1. 要使用 WisdomRouterKit SDK，首先需要对 路由对象 进行注册；

  2. 实现 WisdomRouterRegisterProtocol 协议，保证提前 对 路由对象 进行注册：

         public protocol WisdomRouterRegisterProtocol {
    
             //MARK: - Register Router Protocol
             static func registerRouter()
         }

     note: 使用请看 demo
     
  4. 实现 WisdomRouterShareProtocol 协议，保证提前 对 单列路由对象 进行注册：
     
         @objc public protocol WisdomRouterShareProtocol{
    
             //MARK: - Router Shared Protocol
             func routerShared() -> WisdomRouterModel;
         }

     note: 使用请看 demo


# 三. Register API introduce/介绍：

【1】.Register Model array/注册 模型数组

         //MARK: - register VC's attribute array element type, element types require inheritance WisdomRouterModel
         //MARK: - register VC's 属性数组元素类型, 元素类型需要继承 WisdomRouterModel
         // - parame targetVC:        target VC's class name
         // - parame modelListName:   target VC's array name
         // - parame modelListClass:  array's Element class
         @discardableResult
         @objc public class func register(vcClassType: UIViewController.Type,
                                          modelListName: String,
                                          modelListClass: WisdomRouterModel.Type) -> WisdomRouterResult

         // Inherited model object parent class/继承的模型对象父类
         @objcMembers open class WisdomRouterModel: NSObject {
    
             required override public init() {
             }
         }

         note： Returned value/返回值 WisdomRouterResult 

【2】.Register Callback task Block/注册 回调任务 闭包

         //MARK: - register VC's attribute closure, confirm the conversion type in handler
         //MARK: - register VC's 属性闭包, 在 handler 中确认转换类型
         // - parame targetVC:        target VC's class name
         // - parame handlerName:     target VC's handler name
         // - parame handler:         target VC's handler
         @discardableResult
         @objc public class func register(vcClassType: UIViewController.Type,
                                          handlerName: String,
                                          handler: @escaping RouterRegisterHandler) -> WisdomRouterResult

         // Block/闭包 type/类型
         public typealias RouterRegisterHandler = (Any,UIViewController) -> Void

         note： Returned value/返回值 WisdomRouterResult 


# 四. Router API introduce/介绍：

【1】.//MARK: - router no argument/无参数，no/无 Handler

         // - parame targetVC:             target VC's class name
         // - parame project:              target VC's class of project
         // - parame routerHandler:        router handler, succeed
         // - parame routerErrorHandler:   router handler, error
         @objc public class func router(targetVC: String,
                                        project: String,
                                        routerHandler: RouterHandler,
                                        routerErrorHandler: RouterErrorHandler)
    
    
【2】.//MARK: - router has argument/有参数，no/无 Handler

         // - parame targetVC:             target VC's class name
         // - parame project:              target VC's class of project
         // - parame param:                target VC's property of WisdomRouterParam
         // - parame routerResultHandler:  router result handler, succeed
         // - parame routerErrorHandler:   router handler, error
         @objc public class func router(targetVC: String,
                                        project: String,
                                        param: WisdomRouterParam,
                                        routerResultHandler: RouterResultHandler,
                                        routerErrorHandler: RouterErrorHandler)
    
    
【3】.//MARK: - router no argument/无参数，has/有 Handler

         // - parame targetVC:             target VC's class name
         // - parame project:              target VC's class of project
         // - parame handler:              target VC's handler of WisdomRouterHandler
         // - parame routerResultHandler:  router result handler, succeed
         // - parame routerErrorHandler:   router handler, error
         @objc public class func router(targetVC: String,
                                        project: String,
                                        handler: WisdomRouterHandler,
                                        routerResultHandler: RouterResultHandler,
                                        routerErrorHandler: RouterErrorHandler)
    
    
【4】.//MARK: - router has argument/有参数，has/有 Handler

         // - parame targetVC:             target VC's class name
         // - parame project:              target VC's class of project
         // - parame param:                target VC's property of WisdomRouterParam
         // - parame handler:              target VC's handler of WisdomRouterHandler
         // - parame routerResultHandler:  router result handler, succeed
         // - parame routerErrorHandler:   router handler, error
         @objc public class func router(targetVC: String,
                                        project: String,
                                        param: WisdomRouterParam,
                                        handler: WisdomRouterHandler,
                                        routerResultHandler: RouterResultHandler,
                                        routerErrorHandler: RouterErrorHandler) 
    
    
【5】.//MARK: - router parameter list，no/无 Handler

         // - parame targetVC:             target VC's class name
         // - parame project:              target VC's class of project
         // - parame params:               target VC's property of WisdomRouterParam array
         // - parame routerResultHandler:  router result handler, succeed
         // - parame routerErrorHandler:   router handler, error
         @objc public class func router(targetVC: String,
                                        project: String,
                                        params: [WisdomRouterParam],
                                        routerResultHandler: RouterResultHandler,
                                        routerErrorHandler: RouterErrorHandler) 
    
    
【6】.//MARK: - router no argument/无参数，Handler 数组/list

         // - parame targetVC:             target VC's class name
         // - parame project:              target VC's class of project
         // - parame handlers:             target VC's property of WisdomRouterHandler array
         // - parame routerResultHandler:  router result handler, succeed
         // - parame routerErrorHandler:   router handler, error
         @objc public class func router(targetVC: String,
                                        project: String,
                                        handlers: [WisdomRouterHandler],
                                        routerResultHandler: RouterResultHandler,
                                        routerErrorHandler: RouterErrorHandler) 
    
    
【7】.//MARK: - router parameter list，Handler 数组/list

         // - parame targetVC:             target VC's class name
         // - parame project:              target VC's class of project
         // - parame params:               target VC's property of WisdomRouterParam array
         // - parame handlers:             target VC's property of WisdomRouterHandler array
         // - parame routerResultHandler:  router result handler, succeed
         // - parame routerErrorHandler:   router handler, error
         @objc public class func router(targetVC: String,
                                        project: String,
                                        params: [WisdomRouterParam],
                                        handlers: [WisdomRouterHandler],
                                        routerResultHandler: RouterResultHandler,
                                        routerErrorHandler: RouterErrorHandler) 

# 五. Router Shared/单列 API introduce/介绍：

         // MARK: - getShared  Gets a global Shared/获取全局单列 Model
         // - parame sharedClassName:       target shared's class name
         // - parame project:               target shared's class of project
         // - parame substituteClassType:   substitute of shared's class info
         // - parame routerSharedHandler:   router shared handler, succeed
         // - parame routerErrorHandler:    router handler, error
         @objc public class func getShared(sharedClassName: String,
                                           project: String,
                                           substituteModelType: WisdomRouterModel.Type,
                                           routerSharedHandler: RouterSharedHandler,
                                           routerErrorHandler: RouterErrorHandler)


