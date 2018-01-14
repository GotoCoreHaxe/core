package core.notification;
import core.base.CoreSender;
import core.base.interfaces.IExecutable;
import core.service.CoreServiceContainer;

class CoreNotification extends CoreSender {
    public static inline var CREATE_NOTIFICATION:String = "create.notification";
    public static inline var NAME:String = "name";
    public static inline var BASE_NAME:String = "base.name";


    public function new(name:String, collection:Array<IExecutable>):Void {
        super(name, collection);
    }

    override public function send():Void {
        for (listener in this.collection)
            listener.setParams(this.params).addParam(BASE_NAME, this.name).notify();

    }

    public static function createNotification(name:String):CoreNotification {
        return CoreServiceContainer.getInstance().getService(CoreNotification.CREATE_NOTIFICATION)
        .addParam(CoreNotification.NAME, name)
        .execute();
    }
}
