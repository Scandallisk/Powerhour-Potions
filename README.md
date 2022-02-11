# Legends of Aria Power Hour Potions
Community Server custom development feature that permits users to consume a potion that will increase their skill gain chances up to 200%.  

- This feature makes use of the item table and mobile effect library.

- Power hour potions use a feature that allows the effect/buff to remain on the player through death or by logging out.

- Administrators will be responsible for adding these items to merchants, loot tables, or any other player delivery system of their discretion.

- To create the potion, Admin characters can type /create elixir_of_powerhour

Produced by SCAN & BooGaard from HOPE Society

## Instructions

Simply copy paste the code below into the custom code below and follow the instructions on adding the code to a specific line, creating a new file, or adding to an existing table. 

- For most changes,  you will be required to restart your server for these changes to take effect.  

- To protect our community, please schedule downtime before deploying this change.

This code was produced for PublicServer version 1.4.7




# Files requiring an update:


## powerhourbuff.lua

### This requires a new .LUA file

- Create a new file in the following directory using the filename listed above:

Path:  base > scripts > globals > mobile_effects > items > powerhourbuff.lua

	--SCAN ADDED
	MobileEffectLibrary.PowerHourBuff = 
	{
    	PersistDeath = true,
    	PersistSession = true,

	    OnEnterState = function(self,root,target,args)
		self.Duration = args.Duration or self.Duration
		self.Amount = args.Amount or self.Amount
		self.ParentObj:PlayEffectWithArgs("ManaInfuseGive", 5.0)
		self.ParentObj:SystemMessage("You suddenly become more skillful..", "info")
		AddBuffIcon(self.ParentObj, "PowerHourBuff","Power Hour","backpack","+"..self.Amount.."00% Skill Gain Chance", false)
		SetMobileMod(self.ParentObj, "PowerHourBuffPlus", "PowerHourBuff", self.Amount)
	    end,

	    OnExitState = function(self,root,target,args)
		self.ParentObj:PlayEffectWithArgs("ManaInfuseReceive", 5.0)
		self.ParentObj:SystemMessage("Your skill potion has worn off...", "info")
		RemoveBuffIcon(self.ParentObj, "PowerHourBuff")
		SetMobileMod(this, "PowerHourBuffPlus", "PowerHourBuff", nil)
	    end,

	    GetPulseFrequency = function(self,root)
			return self.Duration
		end,

	    AiPulse = function(self,root)
		EndMobileEffect(root)
		end,

	    Duration = TimeSpan.FromMinutes(1),
	    Amount = 1,
	}
	


## main.lua

- This line of code can be added at the bottom of the list.

Path:  bbase > scripts > globals > mobile_effects > items > main.lua

    --SCAN ADDED
    require 'globals.mobile_effects.items.powerhourbuff'
    
	

## items.lua

Path:  base > scripts > globals > static_data > resource_effects > items.lua

    --SCAN ADDED
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



## base_mobile_mods.lua

### Lines 130-133

Path:  base > scripts > base_mobile_mods.lua

   	--SCAN ADDED
	PowerHourBuffPlus = { },
	PowerHourBuffTimes = { },




## elixir_of_powerhour.xml

### This requires a new template .xml file

- Create a new file in the following directory using the filename listed above:

Path:  base > templates > items > elixir_of_powerhour.xml

    --SCAN ADDED
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

