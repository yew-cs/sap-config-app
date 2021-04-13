using {md as my} from '../db/schema';

service configService @(path : '/netgeoconfig') {
    @odata.draft.enabled
    entity Actions                    as projection on my.Actions excluding {
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy
    };

    entity BusinessObjectTypes        as projection on my.BusinessObjectTypes excluding {
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy
    };

    @odata.draft.enabled
    entity Layers                     as projection on my.Layers excluding {
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy
    };

    @odata.draft.enabled
    entity Renderers                  as projection on my.Renderers excluding {
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy
    };

    entity Scenarios                  as projection on my.Scenarios excluding {
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy
    };

    entity ActionsInScenarios         as projection on my.ActionsInScenarios excluding {
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy
    };

    entity BusinessObjectsInScenarios as projection on my.BusinessObjectsInScenarios excluding {
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy
    };

    entity LayersInScenarios          as projection on my.LayersInScenarios excluding {
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy
    };

    entity LayerTypes                 as projection on my.LayerTypes;
    entity ServiceTypes               as projection on my.ServiceTypes;
    entity ActionTypes                as projection on my.ActionTypes;
    function get(clientId : String) returns String;


}
