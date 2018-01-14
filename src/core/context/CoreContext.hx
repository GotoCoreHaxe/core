package core.context;

import core.base.CoreParameterHolder;
import core.service.CoreServiceContainer;
#if flash
import flash.display.Stage;
#end
class CoreContext extends CoreParameterHolder {
    public static var instance:CoreContext;

    public static function getInstance():CoreContext {
        if (instance == null) {
            instance = new CoreContext();
        }
        return instance;
    }

    public function new() {
        this.sc = CoreServiceContainer.getInstance();
    }

    public var sc:CoreServiceContainer;
    #if flash
    public var stage:Stage;
    #end


    public function getParam(name:String):Dynamic {
        return this.params.get(name);
    }

    public function getString(name:String):String {
        return cast(this.params[name], String);
    }

    public function getInteger(name:String):Int {
        return cast(this.params[name], Int);
    }

    public function getNumber(name:String):Float {
        return cast(this.params[name], Float);
    }

    public function getParams():Map<String, Dynamic> {
        return this.params;
    }

}


