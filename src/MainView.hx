package ;

import haxe.ui.containers.VBox;
import haxe.ui.components.OptionBox;
import haxe.ui.events.MouseEvent;
import haxe.ui.events.UIEvent;

@:build(haxe.ui.ComponentBuilder.build("assets/main-view.xml"))
class MainView extends VBox {

    public var NO_MOD_STRING:String = "The default game with no modifications.";

    public function new() {
        super();
        var option = new OptionBox();
        option.registerEvent(UIEvent.CHANGE, function(e) {
            setDescription("A test mod (it's not real).");
        });
        option.id = "test";
        option.text = "Test";
        
        modlistview.addComponent(option);
        option.selected = true;
    }

    public function setDescription(dtext:String) {
        description.text = dtext;
    }
    
    @:bind(launchbutton, MouseEvent.CLICK)
    private function onLaunchButton(e:MouseEvent) {
        trace("Launch");
    }
}