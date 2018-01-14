/**
 * Created by varadig on 10/28/14.
 */
package core.base.interfaces;
interface ICoreBaseApplication {
	function initialize():Void;

	function initContext():Void;

	function initCoreModules():Void;

	function initControllers():Void;

	function initApplication():Void;

}

