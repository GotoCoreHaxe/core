package cases;
import core.base.CoreClassFactory.Params;
import core.base.CoreCallback;
import core.base.CoreTestCase;
class CoreCallbackTest extends CoreTestCase {
    public static inline var SERVICE_NAME:String = "callback.service.name";
    public static inline var GROUP_NAME:String = "callback.group.name";
    public static inline var TEST_PARAM:String = "test.param";

    private var sendValue:Dynamic = {foo:"bar"};
    private var catchResult:Dynamic;

    public function new() {
        super();
    }
    override public function setup():Void{

        this.sc.registerService(SERVICE_NAME,this.service);


        CoreCallback.addCallback(this,GROUP_NAME,this.sc.getService(SERVICE_NAME));

        this.createCallBack(GROUP_NAME)
        .addParam(TEST_PARAM,this.sendValue)
        .send();
    }

    private function service(params:Params):Void{
        this.catchResult = params.get(TEST_PARAM);
    }

    private function testCallback():Void{
        assertEquals(this.sendValue,this.catchResult);
    }
}
