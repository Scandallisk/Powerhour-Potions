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