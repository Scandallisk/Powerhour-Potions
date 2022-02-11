# Legends of Aria Power Hour Potions
Community Server custom development world-chat functionality for Legends of Aria.

This feature permits users to consume a potion that will increase their skill gain chances up to 200%.  

- This feature makes use of the item table and mobile effect library.

- Power hour potions use a feature that allows the effect/buff to remain on the player through death or by logging out.

- Administrators will be responsible for adding these items to merchants, loot tables, or any other player delivery system of their discretion.

Produced by SCAN & BooGaard from HOPE Society

## Instructions

Simply copy paste the code below into the custom code below and follow the instructions on adding the code to a specific line, creating a new file, or adding to an existing table. 

- For most changes,  you will be required to restart your server for these changes to take effect.  

- To protect our community, please schedule downtime before deploying this change.

This code was produced for PublicServer version 1.4.7




# Files requiring an update:

## items.lua

Path:  base > scripts > globals > static_data > resource_effects > items.lua

    --SCAN ADDED
    -- This code will permit users to consume a potion that puts a 60 minute buff 
    -- and increases skill gain chance up to 200%.
    ResourceEffectData.PowerHourBuff = {
        NoDismount = true,
        NoAutoTarget = true,
        SelfOnly = true,
        MobileEffect = "PowerHourBuff",

        MobileEffectArgs = {
          Duration = TimeSpan.FromMinutes(60),
          Amount = 2,
     },

        Tooltip = {},
        TooltipFunc = function(tooltipInfo, item)
            tooltipInfo["description"] = {
            TooltipString = "Increases chance to gain skills by 200%",
            Priority = 2,
           }
            tooltipInfo["duration"] = {
                TooltipString = "Duration: "..TimeSpanToWords(ResourceEffectData.PowerHourBuff.MobileEffectArgs.Duration),
                Priority = 1,
            }
            return tooltipInfo
     end,
}


## elixir_of_powerhour.xml

### This requires a new template .xml file

- Create a new file in the following directory using the filename listed above:

Path:  base > templates > items > elixir_of_powerhour.xml

    <ObjectTemplate>
     <Name>[FF9900]Elixir of Power Hour[-]</Name>
	    <ClientId>2007</ClientId>
	    <Hue>830</Hue>
	    <Color>FFFF00</Color>
	    <SharedStateEntry name="Weight" type="int" value="1"/>
	    <ObjectVariableComponent>
		    <StringVariable Name="PluralName">Elixirs of Power Hour</StringVariable>
		    <StringVariable Name="ResourceType">PowerHourBuff</StringVariable>
        <DoubleVariable Name="UnitWeight">1</DoubleVariable>
	    </ObjectVariableComponent>
        <ScriptEngineComponent>
		    <LuaModule Name="stackable"/>
	    </ScriptEngineComponent>				    	
    </ObjectTemplate>

