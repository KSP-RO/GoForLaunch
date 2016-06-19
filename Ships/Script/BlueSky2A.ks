CLEARSCREEN.
SET LAZ to 90.
SET EndProgram TO False.
SET Burnout TO False.
//LOCK THROTTLE to 1.0.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 1.
SET ATT TO HEADING(0, 90).
LOCK STEERING TO ATT.
STAGE.
Wait 2.5.
STAGE.

Until EndProgram=True
{
	print "Stage Number: " +STAGE:NUMBER at(3,3).	
	If(STAGE:NUMBER>6)
	{
		If(SHIP:VELOCITY:SURFACE:Mag > 100)
		{
			SET ATT TO SHIP:VELOCITY:SURFACE.
		}
		ELSE IF (SHIP:VELOCITY:SURFACE:Mag > 50)
		{
			SET ATT TO HEADING(LAZ, 78).
		}
		ELSE IF (SHIP:VELOCITY:SURFACE:Mag > 3)
		{
			SET ATT TO HEADING(LAZ, 90).
		}
		ELSE
		{
			SET ATT TO HEADING(0, 90).
		}
	}
	ELSE IF(STAGE:NUMBER=6)
	{
		wait 0.5.
		STAGE.
		SET ATT TO SHIP:VELOCITY:SURFACE.
	}
	ELSE IF(STAGE:NUMBER=5)
	{
		SET ATT TO SHIP:VELOCITY:SURFACE.
		IF(ALTITUDE > 60000)
		{
			STAGE.
			RCS On.
		}
	}
	ELSE IF(STAGE:NUMBER=4)
	{
		SET ATT TO SHIP:VELOCITY:SURFACE.
		IF(ALTITUDE > 100000)
		{
			STAGE.
		}
	}
	ELSE IF(STAGE:NUMBER=3)
	{
		SET ATT TO SHIP:VELOCITY:SURFACE.
		IF(eta:Apoapsis < 60 AND Burnout=True)
		{
			SET ATT TO HEADING(vang(vxcl(up:vector, velocity:orbit), north:vector),0).
			IF(eta:Apoapsis < 40)
			{
				RCS Off.
				STAGE.
				WAIT 2.
				STAGE.
			}
		}
	}
	If(STAGE:RESOURCES:LENGTH>0)	
	{	
		print "RES : " +STAGE:RESOURCES[0]:NAME +" Amount : "+round(STAGE:RESOURCES[0]:Amount,5) at(3,4).
		CheckStaging(STAGE:RESOURCES[0]).
	}
	If(STAGE:RESOURCES:LENGTH>1)	
	{	
		print "RES : " +STAGE:RESOURCES[1]:NAME +" Amount : "+round(STAGE:RESOURCES[1]:Amount,5) at(3,5).
		CheckStaging(STAGE:RESOURCES[1]).
	}
	If(STAGE:RESOURCES:LENGTH>2)	
	{
		print "RES : " +STAGE:RESOURCES[2]:NAME +" Amount : "+round(STAGE:RESOURCES[2]:Amount,5) at(3,6).
		CheckStaging(STAGE:RESOURCES[2]).
	}
	wait 0.06.
}
CLEARSCREEN.

Function CheckStaging
{
	Parameter Res.
	//print "Doing Stuff!" at(3,5).
	If(Res:Amount<=0.05)
	{
		If(STAGE:NUMBER=7)
		{
			Wait 0.5.
			Stage.
			print "Booster Sep " +1 at(3,8).
		}
		else If(STAGE:NUMBER=3)
		{	
			SET Burnout to TRUE.
			print "Burnout " +3 at(3,8).
		}
		else If(Stage:NUMBER=1)
		{
			Wait 2.
			STAGE.
			AG2 On.
			print "Inserted " +5 at(3,8).
			SET EndProgram TO TRUE.
		}
	}
}
