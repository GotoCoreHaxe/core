package core.base;
import core.base.CoreCallback.CallbackMap;
import core.service.CoreServiceContainer;
import openfl.display.Sprite;
@:build(core.utils.CoreClassMacro.buildFields("core.openfl.sprite"))

class CoreSprite extends Sprite{
    public function new() {
        core.utils.CoreClassMacro.construct();
    }
    public var callbacks:CallbackMap = new CallbackMap();
    @protected
    var sc:CoreServiceContainer;
}
