using {configService} from './ConfigService';

/**
 * Annotations for Layers Entity
 */
annotate configService.Layers with @(
    Common : {Label : '{i18n>Layer}'},
    UI     : {
        SelectionFields                 : [
        Name,
        LayerType_Code,
        ServiceType_Code
        ],
        HeaderInfo                      : {
            TypeName       : '{i18n>Layer}',
            TypeNamePlural : '{i18n>Layers}',
            Title          : {Value : Name},
            Description    : {Value : Description},

        },
        HeaderFacets                    : [],
        LineItem                        : {$value : [
        {Value : Name},
        {Value : LayerType_Code},
        {Value : ServiceType_Code},
        {Value : MinZoom}
        ]},
        FieldGroup #GeneralInformation  : {Data : [

        {Value : ServiceType_Code},
        {
            $Type : 'UI.DataFieldWithUrl',
            Value : ServiceUrl,
            Url   : ServiceUrl
        },
        {Value : LayerType_Code},
        {Value : MinZoom},
        {Value : OdataFieldNameGeometry},
        {Value : OdataFieldNameProperties},
        ]},
        FieldGroup #ConfigurationDetail : {Data : [

        {Value : LayoutJson},
        {Value : PaintJson},
        {Value : MarkerUrl},
        {Value : MarkerFallback},
        {Value : JsonConfig},

        ]},
        Facets                          : [{
            $Type  : 'UI.CollectionFacet',
            Label  : '{i18n>LayerOverview}',
            ID     : 'LayerOverviewFacet',
            Facets : [
                {
                    $Type  : 'UI.ReferenceFacet',
                    Label  : '{i18n>GeneralInformation}',
                    ID     : 'GeneralInformationFacet',
                    Target : '@UI.FieldGroup#GeneralInformation'
                },
                {
                    $Type  : 'UI.ReferenceFacet',
                    Label  : '{i18n>ConfigurationDetail}',
                    ID     : 'ConfigurationDetailFacet',
                    Target : '@UI.FieldGroup#ConfigurationDetail'
                },

            //begin of reference facet enhancement

            //end of reference facet enhancement
            ]
        }

        ]
    }
) {
    ID                       @Core  : {Computed : true};
    Name                     @(
        title    : '{i18n>Name}',
        required : 'true'
    );
    Description              @(
        title : '{i18n>Description}',
        UI    : {MultiLineText : true}
    );
    LayerType                @(
        title  : '{i18n>LayerType}',
        Common : {
            Text            : LayerType.name,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues,

        }
    );
    ServiceType              @(
        title  : '{i18n>ServiceType}',
        Common : {
            Text            : ServiceType.name,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues
        }
    );
    ServiceUrl               @title : '{i18n>ServiceUrl}';
    MinZoom                  @title : '{i18n>MinZoom}';
    LayoutJson               @(
        title : '{i18n>LayoutJson}',
        UI    : {MultiLineText : true}
    );
    PaintJson                @(
        title : '{i18n>PaintJson}',
        UI    : {MultiLineText : true}
    );
    MarkerUrl                @title : '{i18n>MarkerUrl}';
    MarkerFallback           @title : '{i18n>MarkerFallback}';
    JsonConfig               @(
        title : '{i18n>JsonConfig}',
        UI    : {MultiLineText : true}
    );
    OdataFieldNameGeometry   @title : '{i18n>OdataFieldNameGeometry}';
    OdataFieldNameProperties @title : '{i18n>OdataFieldNameProperties}';
}

/**
 * Annotations for LayerTypes Entity
 */
annotate configService.LayerTypes with {
    Code @(
        title  : '{i18n>Id}',
        UI     : {Hidden : true},
        Common : {Text : {
            $value                 : name,
            ![@UI.TextArrangement] : #TextOnly
        }}
    );
    Name @(
        title : '{i18n>Name}',
        UI    : {HiddenFilter : true}
    );
};

/**
 * Annotations for ServiceTypes Entity
 */
annotate configService.ServiceTypes with {
    Code @(
        title  : '{i18n>Code}',
        UI     : {Hidden : true},
        Common : {Text : {
            $value                 : name,
            ![@UI.TextArrangement] : #TextOnly
        }}
    );
    Name @(
        title : '{i18n>Name}',
        UI    : {HiddenFilter : true}
    );
};

/**
 * Annotations for Renderers Entity
 */
annotate configService.Renderers with @(
    Common : {Label : '{i18n>Renderer}'},
    UI     : {
        SelectionFields                : [
        Name,
        CloudFoundryDestination
        ],
        HeaderInfo                     : {
            TypeName       : '{i18n>Renderer}',
            TypeNamePlural : '{i18n>Renderers}',
            Title          : {Value : Name},
            Description    : {Value : Description},

        },
        LineItem                       : {$value : [
        {Value : Name},
        {Value : Description},
        {Value : License},
        {Value : LicenseToken},
        {Value : CloudFoundryDestination}
        ]},
        Facets                         : [{
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#GeneralInformation',
        }],
        FieldGroup #GeneralInformation : {Data : [

        {Value : License},
        {Value : LicenseToken},
        {Value : CloudFoundryDestination},
        {
            $Type : 'UI.DataFieldWithUrl',
            Value : Url,
            Url   : Url
        },
        {Value : DefaultCenterLatitude},
        {Value : DefaultCenterLongitude},
        {Value : DefaultZoomLevel},
        {Value : JsonString},
        {Value : JsonConfig}
        ]}
    }
) {
    Name                    @title : '{i18n>Name}';
    Description             @title : '{i18n>Description}';
    License                 @title : '{i18n>License}';
    LicenseToken            @title : '{i18n>LicenseToken}';
    Url                     @(
        title : '{i18n>ServiceUrl}',
        UI    : {MultiLineText : true}
    );
    CloudFoundryDestination @title : '{i18n>CloudFoundryDestination}';
    DefaultCenterLatitude   @title : '{i18n>DefaultCenterLatitude}';
    DefaultCenterLongitude  @title : '{i18n>DefaultCenterLongitude}';
    DefaultZoomLevel        @title : '{i18n>DefaultZoomLevel}';
    JsonString              @title : '{i18n>JsonString}';
    JsonConfig              @(
        title : '{i18n>JsonConfig}',
        UI    : {MultiLineText : true}
    );
}

// /**
//  * Annotations for Business Object Types Entity
//  */
// annotate configService.BusinessObjectTypes with @(
//     Common : {Label : '{i18n>BusinessObjectType}'},
//     UI     : {
//         SelectionFields                : [Name],
//         HeaderInfo                     : {
//             TypeName       : '{i18n>businessObjectType}',
//             TypeNamePlural : '{i18n>businessObjectTypes}',
//             Title          : {Value : Name},
//             Description    : {Value : Description},

//         },
//         LineItem                       : {$value : [
//         {Value : Name},
//         {Value : Description}
//         ]},
//         HeaderFacets                   : [],
//         Facets                         : [{
//             $Type  : 'UI.ReferenceFacet',
//             Target : '@UI.FieldGroup#GeneralInformation',
//         }],
//         FieldGroup #GeneralInformation : {Data : []}
//     }
// ) {
//     ID          @(
//         title  : '{i18n>Id}',
//         UI     : {Hidden : true},
//         Common : {Text : {
//             $value                 : Name,
//             ![@UI.TextArrangement] : #TextOnly
//         }}
//     );
//     Name        @(
//         title : '{i18n>BusinessObjectType}',
//         UI    : {HiddenFilter : true}
//     );
//     Description @title : '{i18n>Description}';
//     JsonConfig  @(
//         title : '{i18n>jsonConfig}',
//         UI    : {MultiLineText : true}
//     );
// }

/**
 * Annotations for Actions Entity
 */
annotate configService.Actions with @(
    Common : {Label : '{i18n>Action}'},
    UI     : {
        SelectionFields                : [
        Name,
        ActionType_Id,
        BusinessObjectType_Id
        ],
        HeaderInfo                     : {
            TypeName       : '{i18n>Action}',
            TypeNamePlural : '{i18n>Actions}',
            Title          : {Value : Name},
            Description    : {Value : Description},

        },
        HeaderFacets                   : [],
        LineItem                       : {$value : [
        {Value : Name},
        {Value : Description},
        {Value : ActionType.name},
        {Value : BusinessObjectType.name},
        {Value : SemanticObject}

        ]},
        Facets                         : [{
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#GeneralInformation',
            Label  : '{i18n>GeneralInformation}'
        }],
        FieldGroup #GeneralInformation : {Data : [
        {Value : ActionType_Id},
        {Value : BusinessObjectType_Id},
        {Value : SemanticObject},
        {Value : Action},
        {
            $Type : 'UI.DataFieldWithUrl',
            Value : Url,
            Url   : Url
        },
        {Value : Parameters},

        ]}
    }
) {
    ID                 @Core  : {Computed : true};
    Name               @title : '{i18n>Name}';
    Description        @title : '{i18n>Description}';
    ActionType         @(
        title  : '{i18n>ActionType}',
        Common : {
            Text            : ActionType.name,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues
        }
    );
    BusinessObjectType  @(
        title  : '{i18n>BusinessObjectType}',
        Common : {
            Text            : BusinessObjectType.name,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues
        }
    );
    Parameters         @(
        title : '{i18n>Parameters}',
        UI    : {MultiLineText : true}
    );
    Url                @title : '{i18n>Url}';
    Action             @title : '{i18n>Action}';
    SemanticObject     @title : '{i18n>SemanticObject}';
}

/**
 * Annotations for ActionType Entity
 */
annotate configService.ActionTypes with {
    Id @(
        title  : '{i18n>Id}',
        UI     : {Hidden : true},
        Common : {Text : {
            $value                 : name,
            ![@UI.TextArrangement] : #TextOnly
        }}
    );
    Name @(
        title : '{i18n>ActionType}',
        UI    : {HiddenFilter : true}
    );
};

/**
 * Annotations for ActionType Entity
 */
annotate configService.BusinessObjectTypes with {
    Id @(
        title  : '{i18n>Id}',
        UI     : {Hidden : true},
        Common : {Text : {
            $value                 : name,
            ![@UI.TextArrangement] : #TextOnly
        }}
    );
    Name @(
        title : '{i18n>BusinessObjectType}',
        UI    : {HiddenFilter : true}
    );
};
