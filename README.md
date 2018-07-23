
# Anypoint Template: API Led Connectivity Process API for Employee Onboarding

+ [License Agreement](#licenseagreement)
+ [Use Case](#usecase)
+ [Run it!](#runit)
	* [Running on premise](#runonopremise)
	* [Running on Studio](#runonstudio)
	* [Running on Mule ESB stand alone](#runonmuleesbstandalone)
	* [Running on CloudHub](#runoncloudhub)
	* [Deploying your Anypoint Template on CloudHub](#deployingyouranypointtemplateoncloudhub)
	* [Properties to be configured (With examples)](#propertiestobeconfigured)
+ [Customize It!](#customizeit)
	* [process-api.xml](#processapi)
	* [global.xml](#global)
	* [process-implementation.xml](#processimplementation)

# License Agreement <a name="licenseagreement"/>
Note that using this template is subject to the conditions of this [License Agreement](AnypointTemplateLicense.pdf).
Please review the terms of the license before downloading and using this template. In short, you are allowed to use the template for free with Mule ESB Enterprise Edition, CloudHub, or as a trial in Anypoint Studio.

# Use Case <a name="usecase"/>
This Anypoint Template should serve as a foundation for API Led Connectivity approach of running an enterprise.

This Anypoint Template is a REST API implemented using APIkit and RAML definition. The API uses JSON as an exchange format. Included are example requests and responses.
This Template incorporate the Employee System APIs, for storing Employees in multiple target systems.

Below are the endpoints that are implemented.

### POST /employees
This endpoint will start generation of the Employee onboarding process. The generation is done asynchronously using queue for requests. The process aggregates the ids of each system API response using a lookup process API. The lookup process API RAML you can find in main/resources/api/ directory. The lookup process API implementation of that RAML is client specific and should use persistent storage to preserve a mapping data. Responses are get from three source instances(Workday, Netsuite and SFDC) using API Led Connectivity System APIs.

### GET /employees/{id}
This endpoint returns Employee ids aggregation identified by unique ID. If the process does not exist or haven't been finished yet, the request ends up with "Resource not found" message.

### GET /queue/{id}
This endpoint returns the status of the queued Employee onboarding process identified by unique ID. There are three states:

+ In progress - status code 200 is returned, process has not finished yet
+ Generated - status code 303 and the user is directly redirected to the Employee by id resource.
+ Not found - status code 404, there is not Employee with specified ID


Look at the included self-descriptive RAML definition and the corresponding flows to learn more about the flows.


# Run it! <a name="runit"/>
Simple steps to get API Led Connectivity Process API for Employees running.


## Running on premise <a name="runonopremise"/>
In this section we detail the way you should run your Anypoint Template on your computer.


### Where to Download Mule Studio and Mule ESB
First thing to know if you are a newcomer to Mule is where to get the tools.

+ You can download Mule Studio from this [Location](http://www.mulesoft.com/platform/mule-studio)
+ You can download Mule ESB from this [Location](http://www.mulesoft.com/platform/soa/mule-esb-open-source-esb)


### Importing an Anypoint Template into Studio
Mule Studio offers several ways to import a project into the workspace, for instance: 

+ Anypoint Studio Project from File System
+ Packaged mule application (.jar)

You can find a detailed description on how to do so in this [Documentation Page](http://www.mulesoft.org/documentation/display/current/Importing+and+Exporting+in+Studio).


### Running on Studio <a name="runonstudio"/>
Once you have imported you Anypoint Template into Anypoint Studio you need to follow these steps to run it:

+ Locate the properties file `mule.dev.properties`, in src/main/resources
+ Complete all the properties required as per the examples in the section [Properties to be configured](#propertiestobeconfigured)
+ Once that is done, right click on you Anypoint Template project folder 
+ Hover you mouse over `"Run as"`
+ Click on  `"Mule Application"`


### Running on Mule ESB stand alone <a name="runonmuleesbstandalone"/>
Complete all properties in one of the property files, for example in [mule.prod.properties] (../master/src/main/resources/mule.prod.properties) and run your app with the corresponding environment variable to use it. To follow the example, this will be `mule.env=prod`. 


## Running on CloudHub <a name="runoncloudhub"/>
While [creating your application on CloudHub](http://www.mulesoft.org/documentation/display/current/Hello+World+on+CloudHub) (Or you can do it later as a next step), you need to go to Deployment > Advanced to set all environment variables detailed in **Properties to be configured** as well as the **mule.env**.


### Deploying your Anypoint Template on CloudHub <a name="deployingyouranypointtemplateoncloudhub"/>
Mule Studio provides you with really easy way to deploy your Template directly to CloudHub, for the specific steps to do so please check this [link](http://www.mulesoft.org/documentation/display/current/Deploying+Mule+Applications#DeployingMuleApplications-DeploytoCloudHub)


## Properties to be configured (With examples) <a name="propertiestobeconfigured"/>
In order to use this Mule Anypoint Template you need to configure properties (Credentials, configurations, etc.) either in properties file or in CloudHub as Environment Variables. Detail list with examples:

### Application configuration
**Common configuration**

+ http.port `8081`

**APIs configuration**

+ api.domain `your-destination-api.cloudhub.io:80`
+ api.basePath `/api`

+ system.api.employee.nets.domain `your-destination-nets-system-api.cloudhub.io`
+ system.api.employee.nets.http.port `9091`
+ system.api.employee.nets.basePath `/api1`
+ system.api.employee.nets.protocol `HTTPS`

+ system.api.employee.wday.domain `your-destination-wday-system-api.cloudhub.io`
+ system.api.employee.wday.http.port `9092`
+ system.api.employee.wday.basePath `/api2`
+ system.api.employee.wday.protocol `HTTPS`

+ system.api.user.sfdc.domain `your-destination-sfdc-system-api.cloudhub.io`
+ system.api.user.sfdc.http.port `9093`
+ system.api.user.sfdc.basePath `/api3`
+ system.api.user.sfdc.protocol `HTTPS`
+ system.api.user.sfdc.profileId `1abda9823bbaaaaaa`

+ process.api.employee.lookup.domain `your-lookup-process-api.cloudhub.io`
+ process.api.employee.lookup.http.port `9094`
+ process.api.employee.lookup.basePath `/api4`
+ process.api.employee.lookup.protocol `HTTP`


# Customize It!<a name="customizeit"/>
This brief guide intends to give a high level idea of how this Anypoint Template is built and how you can change it according to your needs.
As mule applications are based on XML files, this page will be organized by describing all the XML that conform the Anypoint Template.
Of course more files will be found such as Test Classes and [Mule Application Files](http://www.mulesoft.org/documentation/display/current/Application+Format), but to keep it simple we will focus on the XMLs.

Here is a list of the main XML files you'll find in this application:

* [global.xml](#global)

## global.xml<a name="global"/>

Configuration for Connectors and [Properties Place Holders](http://www.mulesoft.org/documentation/display/current/Configuring+Properties) are also set in this file. **Even though you can change the configuration here, all parameters that can be modified here are in properties file, and this is the recommended place to do it so.** Of course if you want to do core changes to the logic you will need to modify this file.

In the visual editor they can be found on the *Global Element*.

* [process-api.xml](#processapi)

## process-api.xml<a name="processapi"/>

This file contains the routing logic of the API and the global exception strategies


* [process-implementation.xml](#processimplementation)

## implementation.xml<a name="processimplementation"/>

A functional aspect of this Anypoint Template implemented in this XML is to create Employees in parallel invoking multiple CRUD system APIs. You can customize and extend the logic of this Anypoint Template in this XML to more specifically meet your needs.


