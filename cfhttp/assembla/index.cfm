Assembla Test
<cfsilent>
<cfset username = "">
<cfset userpass = "">

<cfobject component="cfcs.AssemblaService" name="assembla">
<cfset assembla.setUp( Variables.username, Variables.userpass )>
<cfset Variables.spaces = Variables.assembla.getSpaceTickets( "spaceId", "milestoneId" ) >
</cfsilent>
<cfif Len(Variables.spaces)>
	<cfoutput>#Variables.spaces#</cfoutput>
</cfif>
