package core.utils;
import haxe.macro.Context;
import haxe.macro.Expr.Field;
import haxe.macro.Expr.FieldType;
import haxe.macro.Expr;
typedef CallbackMap = Map<String, Array<core.base.interfaces.IExecutable>>;
typedef Params = Map<String, Dynamic>;

class TestMacro {

    macro public static function buildFields(prefix:String):Array<Field> {

        var fields:Array<Field> = Context.getBuildFields();

        fields.push({
            name:"nameIndex",
            access:[Access.APublic, Access.AStatic],
            kind:FieldType.FVar(macro:Int, macro $v{0}),
            pos:Context.currentPos()
        });

        return fields;
    }

    macro public static function construct():Expr {
        return macro {
            this._name = this.generateName();
            this.sc = core.service.CoreServiceContainer.getInstance();
            this.coreContext = core.context.CoreContext.getInstance();
            this.sc.registerService(this._name + core.base.CoreCallback.ADD_CALLBACK, this.serviceAddCallback);
            this.sc.registerService(this._name + core.base.CoreCallback.ADD_CALLBACKS, this.serviceAddCallbacks);
        }
    }
}