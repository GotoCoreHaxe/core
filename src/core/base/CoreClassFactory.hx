package core.base;
import core.base.interfaces.IExecutable;
import core.base.CoreCallback.CallbackMap;
import haxe.PosInfos;
import core.logger.CoreLogger;
import core.context.CoreContext;
import core.service.CoreService;
import core.service.CoreServiceContainer;

typedef Params = Map<String,Dynamic>;

class CoreClassFactory {
    public static function construct(_instance:Dynamic):Void {
        _instance.sc = CoreServiceContainer.getInstance();
        _instance.context = CoreContext.getInstance();
        _instance.callbacks = new CallbackMap();
        _instance.sc.registerService(_instance.name + CoreCallback.ADD_CALLBACK, _instance.serviceAddCallback);
        _instance.sc.registerService(_instance.name + CoreCallback.ADD_CALLBACKS, _instance.serviceAddCallbacks);
    }

    public static function serviceAddCallback(_instance:Dynamic, params:Params):Void {
        trace(_instance);
        var group:String = params.get(CoreCallback.GROUP);
        var callback:CoreService = params.get(CoreCallback.CALLBACK);
        CoreClassFactory.addCallback(_instance, group, callback);
    }

    public static function serviceAddCallbacks(_instance:Dynamic, params:Params):Void {
        var group:String = params.get(CoreCallback.GROUP);
        var callbacks:Array<CoreService> = params.get(CoreCallback.CALLBACKS);
        for(callback in callbacks)
            CoreClassFactory.addCallback(_instance, group, callback);

    }

    public static function createCallBack(_instance:Dynamic, group:String):CoreCallback {
        return new CoreCallback(group, _instance.callbacks);
    }


    public static function addCallback(_instance:Dynamic, group:String, callback:CoreService):Void {
        var callbacks:CallbackMap = cast _instance.callbacks;
        trace(_instance);
        trace(_instance.callbacks==null);


        var callbackGroup:Array<IExecutable>;
        if (!callbacks.exists(group)) {
            callbackGroup = new Array<IExecutable>();
            callbacks.set(group, callbackGroup);
        }
        else
            callbackGroup = callbacks.get(group);

        callbackGroup.push(callback);
    }

    public static function log(_instance:Dynamic, message:Dynamic,?pos:PosInfos):Void {
        if (_instance.sc.hasService(CoreLogger.LOGGER_LOG)) {
            _instance.sc.getService(CoreLogger.LOGGER_LOG)
            .addParam(CoreLogger.MESSAGE, message)
            .addParam(CoreLogger.POS_INFOS, pos)
            .execute();
        }
    }
}



