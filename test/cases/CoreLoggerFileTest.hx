package cases;
import core.base.CoreTestCase;
import core.logger.CoreLogger;
import core.logger.CoreLoggerFile;
class CoreLoggerFileTest extends CoreTestCase {
    public function new() {
        super();
        CoreLogger.addLogger(new CoreLoggerFile("./test.log"));
        this.log("LOG");
    }

    public function testLogging():Void {
        this.log("LOG");
        assertTrue(true);
    }
}
