package core.notification;
import core.base.CoreClassFactory.Params;
import core.base.CoreClass;
import core.base.interfaces.IExecutable;

class CoreNotificationContainer extends CoreClass {
    private static var instance:CoreNotificationContainer;

    public static function getInstance():CoreNotificationContainer {
        if (CoreNotificationContainer.instance == null) CoreNotificationContainer.instance = new CoreNotificationContainer();

        return CoreNotificationContainer.instance;
    }

    public function new():Void {
        super();
        this.sc.registerService(CoreListener.REGISTER_LISTENER, this.registerListener);
        this.sc.registerService(CoreListener.REGISTER_LISTENERS, this.registerListeners);
        this.sc.registerService(CoreListener.REMOVE_LISTENER, this.removeListener);
        this.sc.registerService(CoreListener.REMOVE_LISTENERS, this.removeListeners);
        this.sc.registerService(CoreListener.REMOVE_LISTENERS_BY_NAME, this.removeListenersByName);
        this.sc.registerService(CoreNotification.CREATE_NOTIFICATION, this.createNotification);
    }

    private var mapping:Map<String, Array<IExecutable>> = new Map();

    private function registerListener(params:Params):Void {
        var name:String = params.get(CoreListener.NAME);
        var listener:CoreListener = params.get(CoreListener.LISTENER);

        if (!this.hasListener(name))
            this.mapping.set(name, new Array());

        this.getListenersOf(name).push(listener);
    }

    private function removeListener(params:Params):Void {
        var name:String = params.get(CoreListener.NAME);
        var reference:Dynamic = params.get(CoreListener.LISTENER);

        var listeners:Array<IExecutable> = this.getListenersOf(name);
        var index:Int = this.getListenerBy(reference, listeners);
        if (index != -1) listeners.splice(index, 1);
    }

    private function getListenerBy(reference:Dynamic, listeners:Array<IExecutable>):Int {
        for (i in 0...listeners.length)
            if (listeners[i].has(reference))
                return i;
        return -1;
    }

    private function createNotification(params:Params):IExecutable {
        var name:String = params.get(CoreListener.NAME);

        return new CoreNotification(name, this.getListenersOf(name));
    }

    private function hasListener(name:String):Bool {
        return this.mapping.exists(name);
    }

    private function getListenersOf(name:String):Array<IExecutable> {

        return (this.hasListener(name) ? this.mapping.get(name) : new Array() );
    }

    private function removeListenersByName(params:Params):Void {
        var name:String = params.get(CoreListener.NAME);

        var listeners:Array<IExecutable> = this.getListenersOf(name);

    }

    private function registerListeners(params:Params):Void {

    }

    private function removeListeners(params:Params):Void {

    }
}


