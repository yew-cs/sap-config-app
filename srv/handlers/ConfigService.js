"use strict";

const cds = require('@sap/cds')

//todo-a temporary service handler example passing the data for nss using node.js
//might implement using java instead of node js
let myConfigTemplate = {
    "_version": "1.0.0",
    "ClientId": "abcdefg",
    "renderers": [{
            "ID": "dsakdsads",
            "name": "VisualBusiness",
            "description": "",
            "config": {
                "destination": "",
                "license-key": ""
            },
            "config-ext": {

            }
        },
        {
            "name": "Mapbox",
            "config": {
                "destination": "", // alternatively provide the URL and Authorization? 
                //"url":"",
                "license-key": ""
            },
            "config-ext": {}
        },
        {
            "name": "Rizing",
            "config": {
                "destination": "",
                "license-key": ""
            },
            "config-ext": {}
        }
    ],
    "layers": [

    ],

    "actions": [{
            "name": "Test1",
            "config": {
                "fiori-app-url": "",
                "parameter-mapping": [{
                    "source": "",
                    "target": ""
                }]
            }
        },
        {
            "name": "TestJS1",
            "config": {
                "JS-Method": "com.rizing.test.PushMe()",
                "parameter-mapping": [{
                    "source": "",
                    "target": ""
                }]
            }
        }

    ],
    "scenarios": [{
        "name": "Work Orders (Default)",
        "layers": [{
            "odata-service": "/nscprovider",
            "authentication": {

            },
            "availableActions": [
                "Test1",
                "TestJS1"
            ]
        }]
    }]


};


module.exports = function() {

    const DB_KIND_SQL_LITE = 'sqlite';
    const DB_KIND_HANA = 'hana';


    const HANA_COLLECTION_NAME = 'SAP_NET_GEO_METADATA'



    this.on('get', async(req, next) => {
        const db = await cds.connect.to('db')
        const { Actions, Layers, BusinessObjectTypes, Renderers } = db.entities('md')

        // Initialize return value with template
        let myReturnConfig = myConfigTemplate;

        console.log('Reached with Client Id: ', req.data.clientId);

        let filterClientId = req.data.clientId;

        let myActions = await db.read(Actions); //.where([{ ref: ["clientId"] }, "=", { val: filterClientId }]);
        let myLayers = await db.read(Layers); //.where([{ ref: ["clientId"] }, "=", { val: filterClientId }]);
        let myRenderers = await db.read(Renderers); //.where([{ ref: ["clientId"] }, "=", { val: filterClientId }]);
        let myBusinessObjectTypes = await db.read(BusinessObjectTypes); //.where([{ ref: ["clientId"] }, "=", { val: filterClientId }]);

        myReturnConfig['ClientId'] = filterClientId;
        myReturnConfig['actions'] = formatContent(myActions, Actions);
        myReturnConfig['layers'] = formatContent(myLayers, Layers);
        myReturnConfig['renderers'] = formatContent(myRenderers, Renderers);
        myReturnConfig['boTypes'] = formatContent(myBusinessObjectTypes, BusinessObjectTypes);


        console.log('Return Config:', myReturnConfig);

        return JSON.stringify(myReturnConfig)
    })
}


function formatContent(aDataArray, aMetadataInfo) {
    //console.log('Meta Data:', aMetadataInfo);

    let elementKeys = Object.keys(aMetadataInfo.elements)
        //console.log("Meta Data Keys:", Object.keys(aMetadataInfo.elements));

    const CONFIG_KEY = 'config';
    const CONFIG_CUSTOM_KEY = 'config_ext';

    let resultArray = [];

    //let list_keyField = ['ID'];
    let list_Ident = ['ID', 'name', 'description'];
    let list_IgnoreField = ['createdAt', 'createdBy', 'modifiedAt', 'modifiedBy', 'texts', 'localized', 'appliesToBusinessObjectType_ID'];
    let list_JsonConfig = ['jsonConfig'];
    let list_JsonParam = ['parameters'];



    // Loop through entities in the list
    for (let z = 0; z < aDataArray.length; z++) {

        // Get reference to current object
        let currentObject = aDataArray[z];

        // determine current object keys
        let currentObjectKeys = Object.keys(currentObject);

        // Key field
        let keyField = 'zzz';
        let customConfig = {};
        let config = {};
        let identFields = {};


        // Loop throuh all keys
        for (let y = 0; y < currentObjectKeys.length; y++) {

            /*            if (list_keyField.includes(currentObjectKeys[y])) {
                            // Key field
                            keyField = currentObject[currentObjectKeys[y]];
                            //console.log('Key Field: ', currentObjectKeys[y] );
                        }
                        else */
            if (list_Ident.includes(currentObjectKeys[y])) {
                identFields[currentObjectKeys[y]] = currentObject[currentObjectKeys[y]];
            } else if (list_IgnoreField.includes(currentObjectKeys[y])) {
                //console.log('In ignore list: ', currentObjectKeys[y] );
            } else if (list_JsonParam.includes(currentObjectKeys[y])) {
                config[currentObjectKeys[y]] = JSON.parse(currentObject[currentObjectKeys[y]]);

            } else if (list_JsonConfig.includes(currentObjectKeys[y])) {
                //console.log('In jsonConfig list: ', currentObjectKeys[y] );
                if (currentObject[currentObjectKeys[y]] != null && currentObject[currentObjectKeys[y]].length > 2) {
                    customConfig = JSON.parse(currentObject[currentObjectKeys[y]]);
                }
            } else {
                //console.log('Other: ', currentObjectKeys[y]);
                config[currentObjectKeys[y]] = currentObject[currentObjectKeys[y]];
            }

        }

        // assemble result object
        let resultObj = identFields
        identFields[CONFIG_KEY] = config;
        identFields[CONFIG_CUSTOM_KEY] = customConfig;
        //console.log('Result stage 1: ', resultObj)

        resultArray.push(resultObj);
        //resultObj[keyField].[CONFIG_KEY] = config;

    }

    return resultArray;

}

function formatLayers(aLayerArray) {
    console.log('Layer array:', aLayerArray);

    let resultActionArray = [];




    for (let i = 0; i < aLayerArray.length; i++) {

        let actionRecord = {
            "ID": aLayerArray[i].ID,
            "name": aLayerArray[i].name,
            "businessObjectID": aLayerArray[i].appliesToBusinessObjectType_ID,
            "config": {
                "linkToApi": aLayerArray[i].linkToApi,
                "interactionType": aLayerArray[i].interactionType,
                "parameter-mapping": [{
                    "source": "",
                    "target": ""
                }]
            }
        };

        resultActionArray.push(actionRecord);
    }

    return resultActionArray;
}