package cases;
import core.base.CoreTestCase;
import core.notification.CoreListener;
import core.notification.CoreNotification;
import core.notification.CoreNotificationContainer;
class CoreNotificationTest extends CoreTestCase {
    private static inline var TEST_NOTIFICATION:String = "test.notification";
    private static inline var TEST_PARAM:String = "test.param";

    private var notificationValue:Dynamic = {foo:"bar"};
    private var listenerResult:Dynamic;

    public function new() {
        super();
    }

    override public function setup() {
        CoreNotificationContainer.getInstance();
        CoreListener.register(TEST_NOTIFICATION, listener);

        CoreNotification.createNotification(TEST_NOTIFICATION)
        .addParam(TEST_PARAM, this.notificationValue)
        .send();
    }

    private function listener(params:Params):Void {
        this.listenerResult = params.get(TEST_PARAM);
    }
    private function testNotificationResult():Void{
        assertEquals(this.notificationValue,this.listenerResult);
    }
}
