# Nintendo Switch AHK Gen Toolkit

Requires AHKv2.

This repo generate `.ahk` file for each main game roms that it detected recursively in a rom folder, the rom must either ended with `.xci` or `.nsp`

For this to work properly, your Updates should have `(UPD)` and DLC should have `(DLC)` filename in it so that it can detect which rom is the main game. Emulator such as Ryujinx can only boot from main game, duh!

E.g.
```
FATAL FRAME Mask of the Lunar Eclipse (DLC) (Digital Artbook)[0100DAE019111001][v0].nsp
FATAL FRAME Mask of the Lunar Eclipse (DLC) (Rogetsu Isle Dinner Party Costume Set)[0100DAE019111002][v0].nsp
FATAL FRAME Mask of the Lunar Eclipse (DLC) (Ruka Exclusive Costume Marie Rose Outfit)[0100DAE019111003][v0].nsp
FATAL FRAME Mask of the Lunar Eclipse (DLC) (RukaMisakiChoshiro-Exclusive Accessory (Spirit Stone Flashlight Hat & Fox Mask))[0100DAE019111004][v0].nsp
FATAL FRAME Mask of the Lunar Eclipse (UPD) [0100DAE019110800][v196608].nsp
FATAL FRAME Mask of the Lunar Eclipse [0100DAE019110000][v0].nsp     <-- The script will detect this as the main game and write to .gamedb.txt
```

You can use Switch Library Manager (https://github.com/giwty/switch-library-manager) to automatically rename those files for you, set its `settings.json` to the following. Make sure to set `"rename_files": true` and `"create_folder_per_game": true`.

```
{
 "versions_etag": "W/\"117d7aaa8a9bda1:0\"",
 "titles_etag": "W/\"aef266ecd09bda1:0\"",
 "prod_keys": "C:\\Programs\\Emulator\\_switch tools\\switch-library-manager.GUI.windows\\prod.keys",
 "folder": "z:\\roms-noset\\nintendo-switch",
 "scan_folders": [
  "z:\\roms-noset\\nintendo-switch-unorganized"
 ],
 "gui": true,
 "debug": false,
 "check_for_missing_updates": true,
 "check_for_missing_dlc": true,
 "organize_options": {
  "create_folder_per_game": true,
  "rename_files": true,
  "delete_empty_folders": true,
  "delete_old_update_files": false,
  "folder_name_template": "{TITLE_NAME} ({REGION}) [{TITLE_ID}] ",
  "switch_safe_file_names": true,
  "file_name_template": "{TITLE_NAME} ({TYPE}) ({DLC_NAME})[{TITLE_ID}][v{VERSION}]"
 },
 "scan_recursively": true,
 "gui_page_size": 100,
 "ignore_dlc_title_ids": []
}
```


## Quick Start

Modify `config.json`

```
{
    "sets": [       
        {
            "platform": "nintendo-switch",
            "enable": true,
            "config": {
                "rom_dir": "z:\\roms-noset\\nintendo-switch", 
                "template_dir": "templates\\nintendo-switch",
                "keymap_dir": "keymapping\\nintendo-switch",
                "gametitle_dir": "gametitles\\nintendo-switch",
                "gamedb_overwrite_file": "gamedb\\nintendo-switch\\gamedb_nintendo_switch_overwrite.txt"
            }
        }              
    ]
}
```

If needed, modify `templates/nintendo-switch/.config.ini`.
```
[Settings]
EmuPath=C:\Programs\LaunchBox\Emulators\ryujinx-1.1.1294-win_x64\Ryujinx.exe
GameDbPath=.gamedb.txt
StartFullScreen=1
FullScreenWidth=1920 
FullScreenHeight=1080 
Debug=0

[RomPath]
RomDir=.
```

Run
```
python3 run.py
```

That should generate a list of `.ahk` files in your rom folder.

## Import to Launchbox

You can then import these .ahk files to Launchbox.