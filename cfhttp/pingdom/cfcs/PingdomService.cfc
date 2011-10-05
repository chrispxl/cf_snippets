<!---
This is only the central logic of PingdomConnector. Don't instanciate this class directly!
Use pingdom.cfcs.PingdomConnector instead!
--->
<cfcomponent displayname="pingdomService" output="false" hint="This is the gateway to pingdom calls.">
	
	<cfproperty name="basePath" type="String">
	<cfproperty name="apiVersion" type="String">
	<cfproperty name="requestTimeout" type="integer">
	<cfproperty name="userName" type="String">
	<cfproperty name="userPass" type="String">
	<cfproperty name="appKey" type="String">
	<cfproperty name="initComplete" type="Boolean">
	
	<cfset init() >
	
	<cffunction name="init" description="call init request to pingdom service" access="private" output="false">
		<cfset Variables.initComplete   = false>
		<cfset Variables.basePath       = "https://api.pingdom.com/api/">
		<cfset Variables.apiVersion     = "2.0">
		<cfset Variables.requestTimeout = 20 >
		<cfset Variables.userName       = "" >
		<cfset Variables.userPass       = "" >
		<cfset Variables.appKey         = "" >
	</cffunction>
	
	<cffunction name="setup" access="public" output="false" hint="set setup credentials for this service">
		<cfargument name="applicationkey" type="String" required="true">
		<cfargument name="username" type="String" required="true">
		<cfargument name="password" type="String" required="true">
		
		<!--- set params --->
		<cfset Variables.appKey   = Arguments.applicationKey>
		<cfset Variables.userName = Arguments.username>
		<cfset Variables.userPass = Arguments.password>
		<cfset Variables.initComplete = true >
	</cffunction>
	
	<cffunction name="doCall" access="private" output="false">
		<cfargument name="urlAppendix" type="string" required="true">
		<cfargument name="params" type="struct" required="false">
		
		<cfif Variables.initComplete >
			<cfhttp url="#Variables.basePath##Variables.apiVersion##Arguments.urlAppendix#" method="get" result="Variables.result"
					username="#Variables.userName#" password="#Variables.userPass#" timeout="#Variables.requestTimeout#">
				<cfhttpparam type="header" name="App-Key" value="#Variables.appKey#">
				<cfif structkeyExists( Arguments, "params") >
					<!--- add parameters by loop --->
					<cfloop collection="#Arguments.params#" item="key">
						<cfhttpparam type="url" name="#key#" value="#Arguments.params[key]#" />
					</cfloop>
				</cfif>
			</cfhttp>
			<cfreturn Variables.result.filecontent >
			<cfelse>
			<cfthrow type="SetupError" message="Not all needed parameters passed! Please call setup()." />
		</cfif>
	</cffunction>
	
</cfcomponent>