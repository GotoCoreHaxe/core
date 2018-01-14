package core.base;
import core.notification.CoreNotification;
import core.base.CoreClassFactory.Params;
import core.base.CoreCallback.CallbackMap;
import core.context.CoreContext;
import core.service.CoreServiceContainer;
import haxe.unit.TestCase;
class CoreTestCase extends TestCase{
    @protected static var nameIndex:Int = 0;
    @protected var namePrefix:String = "test_case";
    public var sc:CoreServiceContainer;
    public var context:CoreContext;
    public var callbacks:CallbackMap;

    private var name(default,default):String;

    public function new() {
        super();
        this.name = this.generateName();

        CoreClassFactory.construct(this);
    }


    public function getName():String {
        return cast( this.name, String);
    }

    public function serviceAddCallback(params:Params):Void {
        CoreClassFactory.serviceAddCallback(this, params);
    }

    public function serviceAddCallbacks(params:Params):Void {
        CoreClassFactory.serviceAddCallbacks(this, params);
    }

    public function createCallBack(group:String):CoreCallback {
        return CoreClassFactory.createCallBack(this, group);
    }

    @protected function log(message:Dynamic):Void {
        CoreClassFactory.log(this, message);
    }


    @protected function createNotificaionByName(name:String):CoreNotification {
        return this.sc.getService(CoreNotification.CREATE_NOTIFICATION)
        .addParam(CoreNotification.NAME, name)
        .execute();
    }

    private function generateName():String {
        return cast (this.namePrefix + CoreTestCase.nameIndex++, String);
    }

}



