package ;

import haxe.unit.TestRunner;
import cases.*;
class Main {
    public static function main() {
        var runner:TestRunner = new TestRunner();
        runner.add(new CoreLoggerFileTest());
        runner.add(new CoreFileSystemTest());
        runner.add(new CoreNotificationTest());
        runner.run();
    }
}

