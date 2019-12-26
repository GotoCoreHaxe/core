package core.utils;
import haxe.macro.Context;
import haxe.macro.Expr.Field;
import haxe.macro.Expr.FieldType;
import haxe.macro.Expr;
typedef CallbackMap = Map<String, Array<core.base.interfaces.IExecutable>>;
typedef Params = Map<String, Dynamic>;

class CoreClassMacro {

    macro public static function buildFields(prefix:String):Array<Field> {

        var fields:Array<Field> = Context.getBuildFields();

        fields.push({
            name:"nameIndex",
            access:[Access.APublic, Access.AStatic],
            kind:FieldType.FVar(macro:Int, macro $v{0}),
            pos:Context.currentPos()
        });
        fields.push({
            name:"namePrefix",
            access:[Access.APrivate],
            kind:FieldType.FVar(macro:String, macro $v{prefix}),
            pos:Context.currentPos()
        });

        fields.push({
            name:"sc",
            access:[Access.APublic],
            kind:FieldType.FVar(macro:core.service.CoreServiceContainer),
            pos:Context.currentPos()
        });

        fields.push({
            name:"coreContext",
            access:[Access.APublic],
            kind:FieldType.FVar(macro:core.context.CoreContext),
            pos:Context.currentPos()
        });

        var callbackMap = macro new core.utils.CoreClassMacro.CallbackMap();

        fields.push({
            name:"callbacks",
            access:[Access.APublic],
            kind:FieldType.FVar(macro:core.utils.CoreClassMacro.CallbackMap, callbackMap),
            pos:Context.currentPos()
        });

        fields.push({
            name:"_name",
            access:[Access.APrivate],
            kind:FieldType.FVar(macro:String, macro $v{prefix}),
            pos:Context.currentPos()
        });


        fields.push({
            name:"serviceAddCallbacks",
            access:[Access.APrivate],
            kind:FieldType.FFun({
                expr:macro {
                    var group:String = params.get(core.base.CoreCallback.GROUP);
                    var callbacks:Array<core.base.interfaces.IExecutable> = params.get(core.base.CoreCallback.CALLBACKS);
                    for (callback in callbacks)
                        this.addCallback(group, callback);
                },
                args:[
                    {
                        name:"params",
                        type:macro:core.utils.CoreClassMacro.Params
                    }],
                ret:null

            }),
            pos:Context.currentPos()
        });

        fields.push({
            name:"serviceAddCallback",
            access:[Access.APrivate],
            kind:FieldType.FFun({
                expr:macro {
                    var group:String = params.get(core.base.CoreCallback.GROUP);
                    var callback:core.base.interfaces.IExecutable = params.get(core.base.CoreCallback.CALLBACK);
                    this.addCallback(group, callback);
                },
                args:[
                    {
                        name:"params",
                        type:macro:core.utils.CoreClassMacro.Params
                    }],
                ret:null

            }),
            pos:Context.currentPos()
        });

        fields.push({
            name:"addCallback",
            access:[Access.APrivate],
            kind:FieldType.FFun({
                expr:macro {
                    var callbacks:Dynamic = cast this.callbacks;

                    var callbackGroup:Array<core.base.interfaces.IExecutable>;
                    if (!callbacks.exists(group)) {
                        callbackGroup = new Array<core.base.interfaces.IExecutable>();
                        callbacks.set(group, callbackGroup);
                    }
                    else
                        callbackGroup = callbacks.get(group);

                    callbackGroup.push(callback);
                },
                args:[{name:"group", type:macro:String}, {name:"callback", type:macro:core.base.interfaces.IExecutable}],
                ret:null

            }),
            pos:Context.currentPos()
        });


        fields.push({
            name:"createCallBack",
            access:[Access.APublic],
            kind:FieldType.FFun({
                expr:macro {
                    return new core.base.CoreCallback(group, this.callbacks[group]);
                },
                args:[{name:"group", type:macro:String}],
                ret:macro:core.base.CoreCallback

            }),
            pos:Context.currentPos()
        });


        fields.push({
            name:"log",
            access:[Access.APublic],
            kind:FieldType.FFun({
                expr:macro {
                    if (this.sc.hasService(core.logger.CoreLogger.LOGGER_LOG)) {
                        this.sc.getService(core.logger.CoreLogger.LOGGER_LOG)
                        .addParam(core.logger.CoreLogger.MESSAGE, message)
                        .addParam(core.logger.CoreLogger.POS_INFOS, pos)
                        .execute();
                    }
                },
                args:[{name:"message", type:macro:Dynamic}, {name:"pos", type:macro:haxe.PosInfos, opt:true}],
                ret:null

            }),
            pos:Context.currentPos()
        });

        fields.push({
            name:"generateName",
            access:[Access.APrivate],
            kind:FieldType.FFun({
                expr:macro {
                    return cast(this.namePrefix + nameIndex++, String);
                },
                args:[],
                ret:macro:String

            }),
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