<cfcomponent displayname="pingdomConnector" extends="PingdomService" output="false">

	<cffunction name="checkPageErrors" access="public" hint="Show latest checks of specific check service." output="false">
		<cfargument name="checkId" type="String" required="true" />
		<cfargument name="params" type="struct" required="false" />
		<cfreturn doCall( urlAppendix="/analysis/#checkId#", params="#Arguments.params#" ) >
	</cffunction>
	
</cfcomponent>