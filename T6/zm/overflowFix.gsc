#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\_utility;
#include maps\mp\gametypes_zm\_hud;
#include maps\mp\gametypes_zm\_hud_util;

// overflowfix.gsc CMT Frosty Codes
initOverFlowFix()
{ // tables
	self.stringTable = [];
	self.stringTableEntryCount = 0;
	self.textTable = [];
	self.textTableEntryCount = 0;
	if (!isDefined(level.anchorText))
	{
		level.anchorText = createServerFontString("default", 1.5);
		level.anchorText setText("anchor");
		level.anchorText.alpha = 0;
		level.stringCount = 0;
		level thread monitorOverflow();
	}
}
// strings cache serverside -- all string entries are shared by every player
monitorOverflow()
{
	level endon("disconnect");
	for (;;)
	{
		if (level.stringCount >= 60)
		{
			level.anchorText clearAllTextAfterHudElem();
			level.stringCount = 0;
			foreach (player in level.players)
			{
				player purgeTextTable();
				player purgeStringTable();
				player recreateText();
			}
		}
		wait 0.05;
	}
}
setSafeText(player, text)
{
	stringId = player getStringId(text);
	// if the string doesn't exist add it and get its id
	if (stringId == -1)
	{
		player addStringTableEntry(text);
		stringId = player getStringId(text);
	}
	// update the entry for this text element player
	editTextTableEntry(self.textTableIndex, stringId);
	self setText(text);
}
recreateText()
{
	foreach (entry in self.textTable)
		entry.element setSafeText(self, lookUpStringById(entry.stringId));
}
addStringTableEntry(string)
{ // create new entry
	entry = spawnStruct();
	entry.id = self.stringTableEntryCount;
	entry.string = string;
	self.stringTable[self.stringTable.size] = entry;
	// add new entry
	self.stringTableEntryCount++;
	level.stringCount++;
}
lookUpStringById(id)
{
	string = "";
	foreach (entry in self.stringTable)
	{
		if (entry.id == id)
		{
			string = entry.string;
			break;
		}
	}
	return string;
}
getStringId(string)
{
	id = -1;
	foreach (entry in self.stringTable)
	{
		if (entry.string == string)
		{
			id = entry.id;
			break;
		}
	}
	return id;
}
getStringTableEntry(id)
{
	stringTableEntry = -1;
	foreach (entry in self.stringTable)
	{
		if (entry.id == id)
		{
			stringTableEntry = entry;
			break;
		}
	}
	return stringTableEntry;
}
purgeStringTable()
{
	stringTable = [];
	// store all used strings
	foreach (entry in self.textTable)
		stringTable[stringTable.size] = getStringTableEntry(entry.stringId);
	self.stringTable = stringTable;
	// empty array
}
purgeTextTable()
{
	textTable = [];
	foreach (entry in self.textTable)
	{
		if (entry.id != -1)
			textTable[textTable.size] = entry;
	}
	self.textTable = textTable;
}
addTextTableEntry(element, stringId)
{
	entry = spawnStruct();
	entry.id = self.textTableEntryCount;
	entry.element = element;
	entry.stringId = stringId;
	element.textTableIndex = entry.id;
	self.textTable[self.textTable.size] = entry;
	self.textTableEntryCount++;
}
editTextTableEntry(id, stringId)
{
	foreach (entry in self.textTable)
	{
		if (entry.id == id)
		{
			entry.stringId = stringId;
			break;
		}
	}
}
deleteTextTableEntry(id)
{
	foreach (entry in self.textTable)
	{
		if (entry.id == id)
		{
			entry.id = -1;
			entry.stringId = -1;
		}
	}
}
clear(player)
{
	if (self.type == "text")
		player deleteTextTableEntry(self.textTableIndex);
	self destroy();
}
