package core.notification;
import haxe.ds.Vector;
import core.base.CoreFunctionWrapper;
import core.service.CoreServiceContainer;

class CoreListener extends CoreFunctionWrapper {

    public static inline var REGISTER_LISTENER:String = "core.listener.register.listener";
    public static inline var REGISTER_LISTENERS:String = "core.listener.register.listeners";
    public static inline var REMOVE_LISTENERS_BY_NAME:String = "core.listener.remove.listeners.by.name";
    public static inline var REMOVE_LISTENER:String = "core.listener.remove.listener";
    public static inline var REMOVE_LISTENERS:String = "core.listener.remove.listeners";
    public static inline var REFERENCE:String = "reference";
    public static inline var LISTENER:String = "listener";
    public static inline var NAME:String = "name";
    public static inline var BASE_NAME:String = "base.name";

    public function new(name:String, reference:Dynamic):Void {
        super(name, reference);
    }


    override public function notify():Void {
        this.call();
    }

    public static function register(name:String, callback:Dynamic):Void {
        var listener:CoreListener = new CoreListener(name, callback);
        CoreServiceContainer.getInstance().getService(CoreListener.REGISTER_LISTENER)
        .addParam(CoreListener.LISTENER, listener)
        .addParam(CoreListener.NAME, name)
        .execute();
    }

    public static function registers(names:Vector<String>, callback:Dynamic):Void {

        var listener:CoreListener;
        for (i in 0...names.length) {
            listener = new CoreListener(names[i], callback);
            CoreServiceContainer.getInstance().getService(CoreListener.REGISTER_LISTENER)
            .addParam(CoreListener.LISTENER, listener)
            .addParam(CoreListener.NAME, names[i])
            .execute();
        }
    }

    public static function unregister(name:String, callback:Dynamic):Void {
        CoreServiceContainer.getInstance().getService(CoreListener.REMOVE_LISTENER)
        .addParam(CoreListener.NAME, name)
        .addParam(CoreListener.REFERENCE, callback)
        .execute();
    }
}



