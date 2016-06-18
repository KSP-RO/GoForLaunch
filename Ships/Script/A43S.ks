CLEARSCREEN.
SET EndProgram TO False.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 1.

STAGE.
Wait 2.5.
STAGE.
Until STAGE:NUMBER=0 AND EndProgram=True
{
	//print "Stage Number: " +STAGE:NUMBER at(3,3).	
	If(STAGE:RESOURCES:LENGTH>0)	
	{	
		print "RES : " +STAGE:RESOURCES[0]:NAME +" Amount : "+round(STAGE:RESOURCES[0]:Amount,5) at(3,4).
		CheckResource(STAGE:RESOURCES[0]).
	}
	If(STAGE:RESOURCES:LENGTH>1)	
	{	
		print "RES : " +STAGE:RESOURCES[1]:NAME +" Amount : "+round(STAGE:RESOURCES[1]:Amount,5) at(3,5).
		CheckResource(STAGE:RESOURCES[1]).
	}
	If(STAGE:RESOURCES:LENGTH>2)	
	{
		print "RES : " +STAGE:RESOURCES[2]:NAME +" Amount : "+round(STAGE:RESOURCES[2]:Amount,5) at(3,6).
		CheckResource(STAGE:RESOURCES[2]).
	}
	wait 0.05.
}
CLEARSCREEN.

Function CheckResource
{
	Parameter Res.
	//print "Doing Stuff!" at(3,5).
	If(Res:Amount<=0.15)
	{
		If(STAGE:NUMBER=4)
		{	
			Stage.
			print "Executed Staging: " +1 at(3,8).
		}

		else If(STAGE:NUMBER=2)
		{	
			Stage.
			print "Executed Staging: " +3 at(3,8).
		}
		If(Stage:NUMBER=0)
		{
			Wait 0.25.
			SET EndProgram TO TRUE.
		}
	}
	If(STAGE:NUMBER=3)
	{
		Wait 0.75.
		Stage.
		print "Executed Staging: " +2 at(3,8).
	}
	If(STAGE:NUMBER=1)
	{	
		//wait 0.125.
		Stage.
		print "Executed Staging: " +4 at(3,8).
	}
	
}