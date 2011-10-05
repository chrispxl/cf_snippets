<!--- service settings --->
<cfset username       = "">
<cfset userpass       = "">
<cfset applicationkey = "">
<cfset checkid        = "">

<cfobject component="cfcs.PingdomConnector" name="pingdom" />
<cfinvoke component="#pingdom#" method="setup">
	<cfinvokeargument name="username" value="#Variables.username#">
	<cfinvokeargument name="password" value="#Variables.userpass#">
	<cfinvokeargument name="applicationKey" value="#Variables.applicationkey#">
</cfinvoke>

<!--- call for error pages check --->
<cfinvoke component="#pingdom#" method="checkPageErrors" returnvariable="loginResult" >
	<cfinvokeargument name="checkId" value="#Variables.checkid#">
</cfinvoke>

<cfset Variables.pJason = deserializeJSON( Variables.loginResult )>
<cfif structkeyExists( Variables.pJason, "analysis" )>
	<cfdump var="#Variables.pJason.analysis#">
	<cfelse>
	<cfdump var="#Variables.pJason#">
</cfif>