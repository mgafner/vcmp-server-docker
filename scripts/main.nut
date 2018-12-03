/*
# This file is part of vcmp-server-docker
# https://github.com/mgafner/vcmp-server-docker
#
# This is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this file.  If not, see <http://www.gnu.org/licenses/>.

# Original Disclaimer:
# -------------------
Vice City Multiplayer 0.4 Blank Server (by Seby)
You can use it to script your own server. Here you can find all events developed.

VC:MP Official: www.vc-mp.org
Forum: forum.vc-mp.org
Wiki: wiki.vc-mp.org

*/

// =========================================== S E R V E R   E V E N T S ==============================================

/*
function onServerStart()
{
}

function onServerStop()
{
}
*/

function onScriptLoad()
{
	print("Script loaded");
}

function onScriptUnload()
{
}

// =========================================== P L A Y E R   E V E N T S ==============================================

function onPlayerJoin( player )
{
}

function onPlayerPart( player, reason )
{
}

function onPlayerRequestClass( player, classID, team, skin )
{
	return 1;
}

function onPlayerRequestSpawn( player )
{
	return 1;
}

function onPlayerSpawn( player )
{
}

function onPlayerDeath( player, reason )
{
}

function onPlayerKill( player, killer, reason, bodypart )
{
}

function onPlayerTeamKill( player, killer, reason, bodypart )
{
}

function onPlayerChat( player, text )
{
	print( player.Name + ": " + text );
	return 1;
}

function onPlayerCommand( player, cmd, text )
{
	if(cmd == "heal")
	{
		local hp = player.Health;
		if(hp == 100) Message("[#FF3636]Error - [#8181FF]Use this command when you have less than 100% hp !");
		else {
			player.Health = 100.0;
			MessagePlayer( "[#FFFF81]---> You have been healed !", player );
		}
	}
	
	else if(cmd == "goto") {
		if(!text) MessagePlayer( "Error - Correct syntax - /goto <Name/ID>' !",player );
		else {
			local plr = FindPlayer(text);
			if(!plr) MessagePlayer( "Error - Unknown player !",player);
			else {
				player.Pos = plr.Pos;
				MessagePlayer( "[ /" + cmd + " ] " + player.Name + " was sent to " + plr.Name, player );
			}
		}
		
	}
	else if(cmd == "bring") {
		if(!text) MessagePlayer( "Error - Correct syntax - /bring <Name/ID>' !",player );
		else {
			local plr = FindPlayer(text);
			if(!plr) MessagePlayer( "Error - Unknown player !",player);
			else {
				plr.Pos = player.Pos;
				MessagePlayer( "[ /" + cmd + " ] " + plr.Name + " was sent to " + player.Name, player );
			}
		}
	}
	
	else if(cmd == "exec") 
	{
		if( !text ) MessagePlayer( "Error - Syntax: /exec <Squirrel code>", player);
		else
		{
			try
			{
				local script = compilestring( text );
				script();
			}
			catch(e) MessagePlayer( "Error: " + e, player);
		}
	}
	return 1;
}

function onPlayerPM( player, playerTo, message )
{
	return 1;
}

function onPlayerBeginTyping( player )
{
}

function onPlayerEndTyping( player )
{
}

/*
function onLoginAttempt( player )
{
	return 1;
}
*/

function onNameChangeable( player )
{
}

function onPlayerSpectate( player, target )
{
}

function onPlayerCrashDump( player, crash )
{
}

function onPlayerMove( player, lastX, lastY, lastZ, newX, newY, newZ )
{
}

function onPlayerHealthChange( player, lastHP, newHP )
{
}

function onPlayerArmourChange( player, lastArmour, newArmour )
{
}

function onPlayerWeaponChange( player, oldWep, newWep )
{
}

function onPlayerAwayChange( player, status )
{
}

function onPlayerNameChange( player, oldName, newName )
{
}

function onPlayerActionChange( player, oldAction, newAction )
{
}

function onPlayerStateChange( player, oldState, newState )
{
}

function onPlayerOnFireChange( player, IsOnFireNow )
{
}

function onPlayerCrouchChange( player, IsCrouchingNow )
{
}

function onPlayerGameKeysChange( player, oldKeys, newKeys )
{
}

// ========================================== V E H I C L E   E V E N T S =============================================

function onPlayerEnteringVehicle( player, vehicle, door )
{
	return 1;
}

function onPlayerEnterVehicle( player, vehicle, door )
{
}

function onPlayerExitVehicle( player, vehicle )
{
}

function onVehicleExplode( vehicle )
{
}

function onVehicleRespawn( vehicle )
{
}

function onVehicleHealthChange( vehicle, oldHP, newHP )
{
}

function onVehicleMove( vehicle, lastX, lastY, lastZ, newX, newY, newZ )
{
}

// =========================================== P I C K U P   E V E N T S ==============================================

function onPickupClaimPicked( player, pickup )
{
	return 1;
}

function onPickupPickedUp( player, pickup )
{
}

function onPickupRespawn( pickup )
{
}

// ========================================== O B J E C T   E V E N T S ==============================================

function onObjectShot( object, player, weapon )
{
}

function onObjectBump( object, player )
{
}

// =========================================== B I N D   E V E N T S ==============================================

function onKeyDown( player, key )
{
}

function onKeyUp( player, key )
{
}

// ================================== E N D   OF   O F F I C I A L   E V E N T S ======================================
