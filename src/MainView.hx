package ;

import haxe.ui.containers.VBox;
import haxe.ui.components.OptionBox;
import haxe.ui.events.MouseEvent;
import haxe.ui.events.UIEvent;

@:build(haxe.ui.ComponentBuilder.build("assets/main-view.xml"))
class MainView extends VBox {

    public var mod_select:String;
    
    private static inline var NO_MOD_CONTENT:String = "VC.swf";
    private static inline var NO_MOD_STRING:String = "The default game with no modifications.";
    private static inline var LEGACY_MOD_CONTENT:String = "assets/legacy.swf";
    private static inline var LEGACY_MOD_STRING:String = "Play VirtuaCreature as it was in 2020 before the relaunch!";

    public function new() {
        super();
        setModList();
    }

    public function setModList() {
        //Hardcoded mods
        if(Main.content == NO_MOD_CONTENT) NoMod.selected = true;
        else if(Main.content == LEGACY_MOD_CONTENT) LegacyMod.selected = true;
        //Parse modlist
        for(i in 0...Main.modlist.length) {
            var entry = new OptionBox();
            entry.registerEvent(UIEvent.CHANGE, function(e) {
                setModSelect(Main.modlist[i].content, Main.modlist[i].description);
            });
            entry.id = Main.modlist[i].content;
            entry.text = Main.modlist[i].name;
            modlistview.addComponent(entry);
            if(Main.content == entry.id) entry.selected = true;
        }
    }

    public function setModSelect(content:String, dtext:String) {
        mod_select = content;
        description.text = dtext;
    }
    
    @:bind(launchbutton, MouseEvent.CLICK)
    private function onLaunchButton(e:MouseEvent) {
        if(Main.content != mod_select) Main.saveAppData(mod_select);
        Sys.command("start", ["VirtuaCreature.exe"]);
        Sys.exit(0);
    }
}