//allAttachments
attachments = "";
_RETURN = [ 13, 10 ];
_TAB = [ 09 ];
{
	attachments = format[ "%1class %2
{
%3cost = 0;
%3level = 0;
};%4", attachments, configName _x, toString _tab, toString _return ];
}forEach ( "getnumber( _x >> 'scope' ) isEqualTo 2 && { getNumber( _x >> 'itemInfo' >> 'type' ) in [ 101, 201, 301, 302 ] } "configClasses ( configFile >> "CfgWeapons" ));

copyToClipboard attachments;