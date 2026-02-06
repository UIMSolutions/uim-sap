/**
 * OData models and structures
 * 
 * Copyright: Copyright © 2018-2026, Ozan Nurettin Süel
 * License: Apache-2.0
 * Authors: Ozan Nurettin Süel
 */
module uim.sap.fiori.models.odata;

import vibe.data.json;
import std.datetime : SysTime;

/**
 * OData query options
 */
struct ODataQueryOptions {
    /// $select - select specific properties
    string[] select;
    
    /// $expand - expand navigation properties
    string[] expand;
    
    /// $filter - filter results
    string filter;
    
    /// $orderby - sort results
    string orderBy;
    
    /// $top - limit number of results
    int top = -1;
    
    /// $skip - skip number of results
    int skip = -1;
    
    /// $count - include count
    bool includeCount;
    
    /// $search - full-text search
    string search;
    
    /// $format - response format (json, xml)
    string format = "json";
    
    /**
     * Convert to URL query string
     */
    string toQueryString() const pure @safe {
        import std.array : join, array;
        import std.algorithm : map, filter;
        import std.conv : to;
        
        string[] params;
        
        if (select.length > 0) {
            params ~= "$select=" ~ select.join(",");
        }
        
        if (expand.length > 0) {
            params ~= "$expand=" ~ expand.join(",");
        }
        
        if (filter.length > 0) {
            params ~= "$filter=" ~ filter;
        }
        
        if (orderBy.length > 0) {
            params ~= "$orderby=" ~ orderBy;
        }
        
        if (top > 0) {
            params ~= "$top=" ~ top.to!string;
        }
        
        if (skip > 0) {
            params ~= "$skip=" ~ skip.to!string;
        }
        
        if (includeCount) {
            params ~= "$count=true";
        }
        
        if (search.length > 0) {
            params ~= "$search=" ~ search;
        }
        
        if (format.length > 0) {
            params ~= "$format=" ~ format;
        }
        
        return params.join("&");
    }
}

/**
 * OData entity metadata
 */
struct ODataEntityMeta {
    string id;
    string uri;
    string type;
    string etag;
}

/**
 * OData collection response
 */
struct ODataCollection(T) {
    T[] results;
    long count;
    string nextLink;
    ODataEntityMeta[] metadata;
    
    /**
     * Check if there are more results
     */
    @property bool hasMore() const pure nothrow @safe @nogc {
        return nextLink.length > 0;
    }
}

/**
 * OData error detail
 */
struct ODataErrorDetail {
    string code;
    string message;
    string target;
    string severity;
}

/**
 * OData error response
 */
struct ODataError {
    string code;
    string message;
    string target;
    ODataErrorDetail[] details;
    Json innerError;
    
    /**
     * Parse from JSON response
     */
    static ODataError fromJson(Json json) {
        ODataError error;
        
        // OData v2 format: { "error": { "code": ..., "message": { "value": ... } } }
        // OData v4 format: { "error": { "code": ..., "message": ... } }
        
        if ("error" in json) {
            auto errorObj = json["error"];
            
            if ("code" in errorObj) {
                error.code = errorObj["code"].get!string;
            }
            
            if ("message" in errorObj) {
                if (errorObj["message"].type == Json.Type.object && "value" in errorObj["message"]) {
                    // OData v2
                    error.message = errorObj["message"]["value"].get!string;
                } else if (errorObj["message"].type == Json.Type.string) {
                    // OData v4
                    error.message = errorObj["message"].get!string;
                }
            }
            
            if ("target" in errorObj) {
                error.target = errorObj["target"].get!string;
            }
            
            if ("innererror" in errorObj || "innerError" in errorObj) {
                error.innerError = "innererror" in errorObj ? errorObj["innererror"] : errorObj["innerError"];
            }
        }
        
        return error;
    }
}

/**
 * OData batch request
 */
struct ODataBatchRequest {
    string method;     // GET, POST, PUT, PATCH, DELETE
    string url;
    string[string] headers;
    Json body;
    string contentId;  // For referencing in batch
}

/**
 * OData batch response
 */
struct ODataBatchResponse {
    int statusCode;
    string[string] headers;
    Json body;
    string contentId;
}

/**
 * OData metadata document
 */
struct ODataMetadata {
    string version_;
    string dataServiceVersion;
    ODataEntitySet[] entitySets;
    ODataEntityType[] entityTypes;
    ODataFunctionImport[] functionImports;
}

/**
 * OData entity set
 */
struct ODataEntitySet {
    string name;
    string entityType;
}

/**
 * OData entity type
 */
struct ODataEntityType {
    string name;
    string namespace;
    ODataProperty[] properties;
    ODataNavigationProperty[] navigationProperties;
    string[] keys;
}

/**
 * OData property
 */
struct ODataProperty {
    string name;
    string type;
    bool nullable = true;
    int maxLength;
    int precision;
    int scale;
}

/**
 * OData navigation property
 */
struct ODataNavigationProperty {
    string name;
    string relationship;
    string fromRole;
    string toRole;
}

/**
 * OData function import
 */
struct ODataFunctionImport {
    string name;
    string returnType;
    string httpMethod;
    ODataParameter[] parameters;
}

/**
 * OData function parameter
 */
struct ODataParameter {
    string name;
    string type;
    string mode;  // In, Out, InOut
}
