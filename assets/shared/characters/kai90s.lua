function onCreatePost()
    runHaxeCode([[
var chars = [game.dad, game.dadMap.get("kai90s")];
for(char in chars) if(char != null && char.curCharacter == "kai90")
char.danceEveryNumBeats = 2;
]])
close(true)
end