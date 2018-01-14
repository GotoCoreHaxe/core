package core.service;
import core.base.CoreFunctionWrapper;

class CoreService extends CoreFunctionWrapper {
	/*PROPERTIES*/
	public static inline var CORE_SERVICE_NAME:String = "core.service.name";

	public function new(name:String, reference:Dynamic) {
		super(name, reference);
	}

	override public function execute():Dynamic {
		return this.call();
	}

	override public function clone():Dynamic{
		var service:CoreService = new CoreService(this.name, this.reference);
		service.addParams(this.params);
		return service;
	}

}

