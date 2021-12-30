package;

import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.4.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'awards',
		'credits',
		'options'
	];

	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;
	
	var bg:FlxSprite;
	var Town4:FlxSprite;
	var Town3:FlxSprite;
	var Town2:FlxSprite;
	var Town1:FlxSprite;
	var MCShadow:FlxSprite;
	var MC:FlxSprite;
	var UpdateLine:FlxSprite;
	var ButtonsLine:FlxSprite;
	var updatechar:FlxSprite;	

	var sans:Bool = false;
	var appearSans:Bool = FlxG.random.bool(30);

	override function create()
	{
		FlxG.mouse.visible = false;
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_2'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;


		bg = new FlxSprite(-60, 0).loadGraphic(Paths.image('menulayers/BG'));
		bg.scrollFactor.set();
		bg.setGraphicSize(Std.int(bg.width * 1.05));
		bg.updateHitbox();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		
		Town4 = new FlxSprite(-60, 20).loadGraphic(Paths.image('menulayers/Town4'));
		Town4.scrollFactor.set();
		Town4.setGraphicSize(Std.int(Town4.width * 1.05));
		Town4.updateHitbox();
		Town4.antialiasing = ClientPrefs.globalAntialiasing;
		add(Town4);

		Town3 = new FlxSprite(-60, 20).loadGraphic(Paths.image('menulayers/Town3'));
		Town3.scrollFactor.set();
		Town3.setGraphicSize(Std.int(Town3.width * 1.05));
		Town3.updateHitbox();
		Town3.antialiasing = ClientPrefs.globalAntialiasing;
		add(Town3);

		Town2 = new FlxSprite(-60, 20).loadGraphic(Paths.image('menulayers/Town2'));
		Town2.scrollFactor.set();
		Town2.setGraphicSize(Std.int(Town2.width * 1.05));
		Town2.updateHitbox();
		Town2.antialiasing = ClientPrefs.globalAntialiasing;
		add(Town2);

		Town1 = new FlxSprite(-60, 20).loadGraphic(Paths.image('menulayers/Town1'));
		Town1.scrollFactor.set();
		Town1.setGraphicSize(Std.int(Town1.width * 1.05));
		Town1.updateHitbox();
		Town1.antialiasing = ClientPrefs.globalAntialiasing;
		add(Town1);

		MCShadow = new FlxSprite(-60, 20).loadGraphic(Paths.image('menulayers/MCShadow'));
		MCShadow.scrollFactor.set();
		MCShadow.setGraphicSize(Std.int(MCShadow.width * 1.05));
		MCShadow.updateHitbox();
		MCShadow.antialiasing = ClientPrefs.globalAntialiasing;
		add(MCShadow);

		MC = new FlxSprite(-60, 20).loadGraphic(Paths.image('menulayers/MC'));
		MC.scrollFactor.set();
		MC.setGraphicSize(Std.int(MC.width * 1.05));
		MC.updateHitbox();
		MC.antialiasing = ClientPrefs.globalAntialiasing;
		add(MC);

		UpdateLine = new FlxSprite(-60, -20).loadGraphic(Paths.image('menulayers/UpdateLine'));
		UpdateLine.scrollFactor.set();
		UpdateLine.setGraphicSize(Std.int(UpdateLine.width * 1.05));
		UpdateLine.updateHitbox();
		UpdateLine.antialiasing = ClientPrefs.globalAntialiasing;
		add(UpdateLine);

		ButtonsLine = new FlxSprite(-90, 0).loadGraphic(Paths.image('menulayers/ButtonsLine'));
		ButtonsLine.scrollFactor.set();
		ButtonsLine.setGraphicSize(Std.int(ButtonsLine.width * 1.05));
		ButtonsLine.updateHitbox();
		ButtonsLine.antialiasing = ClientPrefs.globalAntialiasing;
		add(ButtonsLine);
		
		updatechar = new FlxSprite(725, -28);
		updatechar.frames = Paths.getSparrowAtlas('updatecharacter');
		updatechar.animation.addByPrefix('upd', 'Update', 24, true);
		updatechar.animation.play('upd');
		updatechar.setGraphicSize(Std.int(updatechar.width * 0.22));
		updatechar.scrollFactor.set();
		updatechar.updateHitbox();
		add(updatechar);
		
		
		FlxTween.tween(Town4, {y: 0},1, {
			ease: FlxEase.quadOut,
			startDelay: 0.10,
		});
		
		FlxTween.tween(Town3, {y: 0},1, {
			ease: FlxEase.quadOut,
			startDelay: 0.8,
		});
		
		FlxTween.tween(Town2, {y: 0},1, {
			ease: FlxEase.quadOut,
			startDelay: 0.6,
		});
		
		FlxTween.tween(Town1, {y: 0},1, {
			ease: FlxEase.quadOut,
			startDelay: 0.4,
		});
		
		FlxTween.tween(MCShadow, {y: 0},1, {
			ease: FlxEase.quadOut,
			startDelay: 0.5,
		});
		
		FlxTween.tween(MC, {y: 0},1, {
			ease: FlxEase.quadOut,
			startDelay: 0.4,
		});
		
		FlxTween.tween(UpdateLine, {y: 0},1, {
			ease: FlxEase.quadOut,
			startDelay: 0.4,
		});
		
		FlxTween.tween(ButtonsLine, {x: -60},1, {
			ease: FlxEase.quadOut,
			startDelay: 0.4,
		});
		
		FlxTween.tween(updatechar, {y: 8},1, {
			ease: FlxEase.quadOut,
			startDelay: 0.4,
		});
		
		camFollow = new FlxObject(0, 0, 0, 0);
		camFollowPos = new FlxObject(0, 0, 0, 0);
		add(camFollow);
		add(camFollowPos);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		menuItems.forEach(function(spr:FlxSprite)
			{
				spr.y = spr.y - 300;
				FlxTween.tween(spr, {y: spr.y + 300}, 1.5, {
					ease: FlxEase.expoOut,
				});
			});

		var versionShit:FlxText = new FlxText(12, FlxG.height - 17, 0, "Madness Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		var epic = new FlxSprite(1207, 670);
		epic.frames = Paths.getSparrowAtlas('epic/epicbutton','shared');
		epic.animation.addByPrefix('z', 'zzzz', 24, true);
		epic.animation.play('z');
		epic.setGraphicSize(Std.int(epic.width * 0.15));
		epic.scrollFactor.set();
		epic.updateHitbox();
		if (appearSans) {
		    add(epic);
		}

		FlxTween.tween(epic, {y: 650},1, {
			ease: FlxEase.quadOut,
			startDelay: 0.4,
		});

		epicHitbox = new FlxObject(epic.x - 0, epic.y - 0, 65, 77);
		epicHitbox.scrollFactor.set();
		if (appearSans) {
		    add(epicHitbox);
		}
		
		changeItem();
		
		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('mnf');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) {
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end
		
		super.create();
	}
	
	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('mnf', camAchievement));
		FlxG.sound.play(Paths.sound('ach'), 0.7);
		trace('Giving achievement "mnf"');
	}
	#end

	var epicHitbox:FlxObject;
	var selectedSomethin:Bool = false;

	function leave() {
	
		FlxTween.tween(Town4, {y: 30},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.6,
		});
		
		FlxTween.tween(Town3, {y: 30},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.4,
		});
		
		FlxTween.tween(Town2, {y: 30},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.2,
		});
		
		FlxTween.tween(Town1, {y: 30},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.0,
		});
		
		FlxTween.tween(MCShadow, {y: 30},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.1,
		});
		
		FlxTween.tween(MC, {y: 30},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.0,
		});
		
		FlxTween.tween(UpdateLine, {y: -38},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.0,
		});
		
		FlxTween.tween(ButtonsLine, {x: -30},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.0,
		});
		
		FlxTween.tween(updatechar, {y: -38},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.0,
		});

		FlxTween.tween(FlxG.camera, {zoom: 1.1}, 1.5);
		FlxTween.tween(bg, {alpha: 0}, 0.9, {
			ease: FlxEase.quadOut,
		});
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 5.6, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (FlxG.keys.justPressed.T)
			{
				FlxG.sound.play(Paths.sound('tiky'));
			}
		if (appearSans) {
			if (FlxG.keys.justPressed.E)
			{
				FlxG.mouse.visible = true;
				FlxG.sound.play(Paths.sound('sans','shared'));
			}

			if (controls.BACK)
			{
				FlxG.mouse.visible = false;
			}

			if (controls.ACCEPT)
			{
				FlxG.mouse.visible = false;
			}

			if (FlxG.mouse.visible == true)
			{
				sans = true;
			}
		}
		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				leave();
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				leave();
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									case 'options':
										MusicBeatState.switchState(new options.OptionsState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}
		if (sans == true) {
			if (FlxG.mouse.overlaps(epicHitbox)) {
				if (FlxG.mouse.justPressed) {
				FlxG.mouse.visible = false;
			    PlayState.storyPlaylist = ['casualty'];
			    PlayState.isStoryMode = false;
			    PlayState.storyWeek = 0;
                PlayState.campaignScore = 0;
                PlayState.campaignMisses = 0;
			    PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + '-hard', StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
			    new FlxTimer().start(1, function(tmr:FlxTimer) {
			        LoadingState.loadAndSwitchState(new PlayState(), true);
			    });
			}
		}
	}
			
		super.update(elapsed);
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
			spr.x -= 425;
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.offset.y = 0;
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x);
				spr.offset.x = 0.05 * (spr.frameWidth / 2 + 180);
				spr.offset.y = 0.15 * spr.frameHeight;
				FlxG.log.add(spr.frameWidth);
			}
		});
	}
}
