package core.base;

import core.service.CoreServiceContainer;
import core.base.CoreCallback.CallbackMap;

@:build(core.utils.CoreClassMacro.buildFields("core.class"))
class CoreClass {
    public function new() {
        core.utils.CoreClassMacro.construct();
    }
    //TODO generate callbacsk with macro
    public var callbacks:CallbackMap = new CallbackMap();
    @protected
    var sc:CoreServiceContainer;
}



