package core.logger;
import core.base.CoreClass;
import core.base.CoreClassFactory.Params;
import core.base.interfaces.IExecutable;
import core.logger.base.ILogger;
import core.notification.CoreNotification;
import core.notification.CoreNotificationContainer;
import core.service.CoreServiceContainer;

class CoreLogger extends CoreClass {
    public static inline var LOGGER_LOG:String = "logger.log";
    public static inline var MESSAGE:String = "message";
    public static inline var POS_INFOS:String = "pos.infos";

    private static var _loggers:Array<ILogger>;
    private static var instance:CoreLogger;
    private var hook:Dynamic;

    public static function getInstance(loggers:Array<ILogger>):CoreLogger {
        if (instance == null)
            instance = new CoreLogger(loggers);
        return instance;
    }

    public static function addLogger(logger:ILogger):Void {
        if (_loggers == null)
            _loggers = new Array<ILogger>();
        _loggers.push(logger);
    }

    public function new(loggers:Array<ILogger>):Void {
        super();
        CoreNotificationContainer.getInstance();
        _loggers = loggers;
        this.sc.registerService(LOGGER_LOG, this.serviceLog);
    }

    private function serviceLog(params:Params):Void {
        for (logger in _loggers)
            logger.addLog(params[MESSAGE], params[POS_INFOS]);

        CoreNotification.createNotification(LOGGER_LOG)
        .addParam(POS_INFOS, params[POS_INFOS])
        .addParam(MESSAGE, params[MESSAGE])
        .send();
    }

    public static function logging(message:Dynamic, ?pos:haxe.PosInfos):Void {
        var service:IExecutable = CoreServiceContainer.getInstance().getService(LOGGER_LOG);
        service.addParam(MESSAGE, message);
        service.addParam(POS_INFOS, pos);
        service.execute();
    }
}

