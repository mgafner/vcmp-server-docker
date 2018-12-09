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

Based on Script Skeleton from: Vice City Multiplayer 0.4 Blank Server (by Seby) [ http://forum.vc-mp.org/?topic=33.0 ]

More information:
VC:MP Official: www.vc-mp.org
Forum: forum.vc-mp.org
Wiki: wiki.vc-mp.org

*/

// =========================================== O w n   F u n c t i o n s ==============================================

function CVehicle::GetRadiansAngle() {  // from: https://forum.vc-mp.org/?topic=4229.msg31239#msg31239
 local angle;
 angle = ::asin( Rotation.z ) * -2;
 return Rotation.w < 0 ? 3.14159 - angle : 6.28319 - angle;
}

// =========================================== S E R V E R   E V E N T S ==============================================

/*
function onServerStart()
{
        print("== Server started ==");

}

function onServerStop()
{
        print("== Server stopped ==");
}
*/

function onScriptLoad()
{
	print("== Script loaded ==");

        // theCherryPopper - Secret office unlocked:
        // from: https://forum.vc-mp.org/?topic=214.msg1280#msg1280
        HideMapObject(1259,-880.552, -575.726, 11.3371);
        CreateObject(1259, 0, Vector(-879.757, -576.008, 11.3371), 255).RotateTo( Quaternion(0, 0, 0.5, -0.866025), 0 );

}

function onScriptUnload()
{
}

// =========================================== P L A Y E R   E V E N T S ==============================================

function onPlayerJoin( player )
{
        MessagePlayer("Welcome " + player.Name + " to the server.", player);
        print("Player '" + player.Name + "' joined");
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

function onPlayerCommand( player, command, text )
{
        local cmd = command.tolower();
	if(cmd == "bring") {
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
        else if(cmd == "getcar") {
                if(!text) MessagePlayer("Error - Correct syntax - /getcar <car ID>",player);
                else {  
                        local car_id = text.tointeger();
                        local vID = FindVehicle( car_id );
                        if ( !vID ) MessagePlayer( "Error: no vehicle with ID " + car_id + " found.", player );
                        else {
                                local angle = player.Angle - (PI / 2);
                                local x1 = player.Pos.x;
                                local y1 = player.Pos.y;
                                local radius = 5;
                                local x2 = x1 - radius * cos(angle);
                                local y2 = y1 - radius * sin(angle);
                                local z2 = player.Pos.z;
                                vID.Pos = Vector(x2,y2,z2);
                                MessagePlayer( "Spawning vehicle " + car_id + " near you.", player );
                        }
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
	else if(cmd == "heal")
	{
		local hp = player.Health;
		if(hp == 100) Message("[#FF3636]Error - [#8181FF]Use this command when you have less than 100% hp !");
		else {
			player.Health = 100.0;
			MessagePlayer( "[#FFFF81]---> You have been healed !", player );
		}
	}
        else if(cmd == "newvehicle") {
                if(!text) MessagePlayer("Error - Correct syntax - /newvehicle <car name/ID>",player);
                else {
                        local car_id = text.tointeger();
                        // MessagePlayer("number of text: " + car_id, player);
                        // local angletype = typeof player.Angle;
                        // MessagePlayer("typeof angle: " + angletype, player);
                        // local angle = player.Angle;
                        local angle = player.Angle - (PI / 2);
                        local x1 = player.Pos.x;
                        local y1 = player.Pos.y;
                        local radius = 5;
                        local x2 = x1 - radius * cos(angle);
                        local y2 = y1 - radius * sin(angle);
                        local z2 = player.Pos.z;
                        local vehicle_angle = angle * -1;
                        CreateVehicle(car_id, player.World, x2, y2, z2, vehicle_angle, 68, 39);
                        MessagePlayer("Spawn " + GetVehicleNameFromModel(car_id), player);
          }
        }
        else if(cmd == "pcreate") {
                // create pickup
                if (!text)
                {
                        MessagePlayer("/pcreate <Model>",player);
                }
                else
                {
                        local Model     = text.tointeger();
                        local World     = player.World;
                        local Quantity  = 1;
                        local PosX      = player.Pos.x;
                        local PosY      = player.Pos.y;
                        local PosZ      = player.Pos.z;
                        local Alpha     = 255;
                        local IsAuto    = true;
                        local Creator   = player.Name;
                        local CreateDate= "";
                        local CreateTime= "";
                        local Text      = "";

                        local pickup = CreatePickup( Model, World, Quantity, PosX, PosY, PosZ, Alpha, IsAuto);
                        MessagePlayer("Pickup #" + pickup.ID + " created.",player);
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
        switch( pickup.ID )     // from http://forum.vc-mp.org/?topic=18.0
                                // change the ids to your pickup ids
        {
                case 0:
                        player.Pos = Vector( -933.277, -351.746, 7.22692 ); // To bank locker
                        break;
                case 1:
                        player.Pos = Vector( -933.531, -351.39, 17.8038 ); // From bank locker
                        break;
                case 2:
                        player.Pos = Vector( -555.477, 788.2, 97.5104 ); // To Office Buliding Lift(UP)
                        break;
                case 3:
                        player.Pos = Vector( -562.089, 782.275, 22.8768 ); // To Office Buliding Lift(DOWN)
                        break;
                case 4:
                        player.Pos = Vector( 140.503, -1366.83, 13.1827 ); // To Lawyers Office
                        break;
                case 5:
                        player.Pos = Vector( 145.115, -1373.62, 10.432 ); // From Lawyers Office
                        break;
                case 6:
                        player.Pos = Vector( 531.82, -127.311, 31.8522 ); // To Roof access near malibu #1
                        break;
                case 7:
                        player.Pos = Vector( 531.851, -111.883, 10.7477 ); // From Roof access near malibu #1
                        break;
                case 8:
                        player.Pos = Vector( 456.443, 30.3307, 34.8713 ); // To Roof access near malibu #2
                        break;
                case 9:
                        player.Pos = Vector( 481.619, 30.4486, 11.0712 ); // From Roof access near malibu #2
                        break;
                case 10:
                        player.Pos = Vector( -943.87, 1077.19, 11.0946 ); // To Lovefist
                        break;
                case 11:
                        player.Pos = Vector( -888.268, 1054.37, 14.689 ); // From Lovefistcase
                        break;
                case 12:
                        player.Pos = Vector( -820.836, 1355.72, 66.4525 ); // To Roof Access in Downtown #1
                        break;
                case 13:
                        player.Pos = Vector( -828.593, 1304.96, 11.5887 ); // From Roof Access in Downtown #1
                        break;
                case 14:
                        player.Pos = Vector( -1423.86, 941.064, 260.276 ); // To Bloodring
                        break;
                case 15:
                        player.Pos = Vector( -1088.61, 1312.74, 9.50517 ); // From Bloodring
                        break;
                case 16:
                        player.Pos = Vector( -1412.4, 1159.08, 266.689 ); // To Racetrack(Stadium)
                        break;
                case 17:
                        player.Pos = Vector( -1086.57, 1352.84, 9.50517 ); // From Racetrack(Stadium)
                        break;
                case 18:
                        player.Pos = Vector(  -445.71, 1127.11, 56.6909 ); // To VCN Building
                        break;
                case 19:
                        player.Pos = Vector( -408.424, 1114.92, 11.0709 ); // From VCN Building
                        break;
                case 20:
                        player.Pos = Vector( -444.803, 1253.35, 77.4241 ); // To Roof Access in Downtown #2
                        break;
                case 21:
                        player.Pos = Vector( -449.452, 1252.74, 11.767 ); // From Roof Access in Downtown #2
                        break;
                case 22:
                        player.Pos = Vector( -880.359, 1159.52, 17.8184 ); // To V Rock(Near Lovefist)
                        break;
                case 23:
                        player.Pos = Vector( -872.045, 1161.86, 11.16 ); // From V Rock(Near Lovefist)
                        break;
                case 24:
                        player.Pos = Vector( -1332.08, 1453.91, 299.146 ); // To Dirtring
                        break;
                case 25:
                        player.Pos = Vector( -1105.68, 1333.03, 20.07 ); // From Dirtring
                        break;
                case 26:
                        player.Pos = Vector( -890.945, 1066.15, 75.8666 ); // To Lovefist roof
                        break;
                case 27:
                        player.Pos = Vector( -887.988, 1046.99, 14.4515 ); // From Lovefist roof
                        break;
        return0;
        }
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
