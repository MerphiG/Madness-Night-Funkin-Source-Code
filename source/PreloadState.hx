import flixel.graphics.FlxGraphic;
import sys.thread.Thread;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;

enum PreloadType {
    atlas;
    image;
	imagep;
}

class PreloadState extends FlxState {

    var globalRescale:Float = 2/3;
    var preloadStart:Bool = false;

    var loadText:FlxText;
    var assetStack:Map<String, PreloadType> = [
        'mainmenu/menu_story_mode' => PreloadType.imagep, 
        'mainmenu/menu_options' => PreloadType.imagep, 
        'mainmenu/menu_freeplay' => PreloadType.imagep, 
        'mainmenu/menu_credits' => PreloadType.imagep, 
		'mainmenu/menu_awards' => PreloadType.imagep, 		
		'menuBG' => PreloadType.imagep, 
		'updatecharacter' => PreloadType.imagep,
		'lockedachievement' => PreloadType.imagep,
		'scrapped/Extras' => PreloadType.image,
		'scrapped/Pendelum' => PreloadType.image,
		'scrapped/Static1' => PreloadType.image,
		'scrapped/Static2' => PreloadType.image,
    ];
    var maxCount:Int;

    public static var preloadedAssets:Map<String, FlxGraphic>;
    var backgroundGroup:FlxTypedGroup<FlxSprite>;

    override public function create() {
        super.create();

        FlxG.camera.alpha = 0;

        maxCount = Lambda.count(assetStack);
        trace(maxCount);
        // create funny assets
        backgroundGroup = new FlxTypedGroup<FlxSprite>();
        FlxG.mouse.visible = false;

        preloadedAssets = new Map<String, FlxGraphic>();

        var bg:FlxSprite = new FlxSprite();
		bg.loadGraphic(Paths.image('loadingscreen/bg'));
        bg.setGraphicSize(Std.int(bg.width * globalRescale));
        bg.updateHitbox();
		backgroundGroup.add(bg);

        var bg1 = new FlxSprite();
		bg1.loadGraphic(Paths.image('loadingscreen/bg1'));
        bg1.setGraphicSize(Std.int(bg1.width * globalRescale));
        bg1.updateHitbox();
		backgroundGroup.add(bg1);

        var bg2:FlxSprite = new FlxSprite();
        bg2.frames = Paths.getSparrowAtlas('loadingscreen/bg2');
        bg2.animation.addByPrefix('load', 'sanfo', 24, true);
        bg2.animation.play('load');
        bg2.setGraphicSize(Std.int(bg2.width * globalRescale));
        bg2.updateHitbox();
        backgroundGroup.add(bg2);
        bg2.x = FlxG.width - (bg2.width + 10);
        bg2.y = FlxG.height - (bg2.height + 10);

        add(backgroundGroup);
        FlxTween.tween(FlxG.camera, {alpha: 1}, 0.5, {
            onComplete: function(tween:FlxTween){
                Thread.create(function(){
                    assetGenerate();
                });
            }
        });

        // save bullshit
        FlxG.save.bind('funkin', 'ninjamuffin99');

        loadText = new FlxText(5, FlxG.height - (32 + 5), 0, 'Loading...', 32);
		loadText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(loadText);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }

    var storedPercentage:Float = 0;

    function assetGenerate() {
        //
        var countUp:Int = 0;
        for (i in assetStack.keys()) {
            trace('calling asset $i');

            FlxGraphic.defaultPersist = true;
            switch(assetStack[i]) {
                case PreloadType.image:
                    var savedGraphic:FlxGraphic = FlxG.bitmap.add(Paths.image(i, 'shared'));
                    preloadedAssets.set(i, savedGraphic);
                    trace(savedGraphic + ', Shared file preloaded');
				case PreloadType.imagep:
                    var savedGraphic:FlxGraphic = FlxG.bitmap.add(Paths.image(i, 'preload'));
                    preloadedAssets.set(i, savedGraphic);
                    trace(savedGraphic + ', Preload file preloaded');
                case PreloadType.atlas:
                    var preloadedCharacter:Character = new Character(FlxG.width / 2, FlxG.height / 2, i);
                    preloadedCharacter.visible = false;
                    add(preloadedCharacter);
                    trace('Character preloaded ${preloadedCharacter.frames}');
            }
            FlxGraphic.defaultPersist = false;
        
            countUp++;
            storedPercentage = countUp/maxCount;
            loadText.text = 'Loading... Progress at ${Math.floor(storedPercentage * 100)}%';
        }

        ///*
        FlxTween.tween(FlxG.camera, {alpha: 0}, 0.5, {
            onComplete: function(tween:FlxTween){
                FlxG.switchState(new TitleState());
            }
        });
        //*/

    }
}