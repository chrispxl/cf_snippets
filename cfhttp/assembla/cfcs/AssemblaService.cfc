<cfcomponent output="false">

	<cfproperty name="baseUrl" type="string">
	<cfproperty name="username" type="string">
	<cfproperty name="password" type="string">
	
	<cfset init()>
	
	<cffunction name="init" access="private" output="false">
		<cfset This.baseUrl  = "http://www.assembla.com/spaces/">
		<cfset This.username = "">
		<cfset This.password = "">
	</cffunction>

	<cffunction name="setup" access="public" output="false">
		<cfargument name="user" type="string" required="true">
		<cfargument name="pass" type="string" required="true">
		
		<cfset This.username = user >
		<cfset This.password = pass>
	</cffunction>

	<cffunction name="getSpaces" access="public" output="false" returntype="String">
		
		<cfif Len(This.username) && Len(This.password)>
			<!--- get my spaces --->
			<cfhttp url="#This.baseUrl#my_spaces" method="get" result="Variables.result"
					username="#This.username#" password="#This.password#">
						<cfhttpparam type="header" name="Accept" value="application/xml">
			</cfhttp>
			
			<cfreturn Variables.result.filecontent>
		</cfif>
		<cfreturn ""> <!--- return empty value --->
		
	</cffunction>

	<cffunction name="getSpaceTickets" access="public" output="false" returntype="String">
		<cfargument name="spaceId" type="string" required="true">
		<cfargument name="milestoneId" type="string" default="">
		
		<cfif Len(This.username) && Len(This.password)>
			<!--- get my spaces --->
			<cfhttp url="#This.baseUrl##Arguments.spaceId#/tickets/" method="get" result="Variables.result"
					username="#This.username#" password="#This.password#">
						<cfhttpparam type="header" name="Accept" value="application/xml">
						<cfif Len(Arguments.milestoneId)>
							<cfhttpparam type="url" name="milestone_id" value="#Arguments.milestoneId#">
						</cfif>
			</cfhttp>
			
			<cfreturn Variables.result.filecontent>
		</cfif>
		<cfreturn ""> <!--- return empty value --->
		
	</cffunction>

</cfcomponent>