package core.base;

@:build(core.utils.CoreClassMacro.buildFields("core.class"))
class CoreClass {
    public function new() {

        core.utils.CoreClassMacro.construct();

    }
}
