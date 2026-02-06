/**
 * Exception handling for SAP Cloud Identity Services
 * 
 * Copyright: Copyright © 2018-2026, Ozan Nurettin Süel
 * License: Apache-2.0
 * Authors: Ozan Nurettin Süel
 */
module uim.sap.identity.exceptions;

import std.exception : Exception;

/**
 * Base exception for all SAP Identity Services errors
 */
class IdentityException : Exception {
    this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @nogc @safe {
        super(msg, file, line, nextInChain);
    }
}

/**
 * Exception thrown when authentication fails
 */
class IdentityAuthenticationException : IdentityException {
    this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @nogc @safe {
        super(msg, file, line, nextInChain);
    }
}

/**
 * Exception thrown when authorization fails
 */
class IdentityAuthorizationException : IdentityException {
    this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @nogc @safe {
        super(msg, file, line, nextInChain);
    }
}

/**
 * Exception thrown when a connection error occurs
 */
class IdentityConnectionException : IdentityException {
    this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @nogc @safe {
        super(msg, file, line, nextInChain);
    }
}

/**
 * Exception thrown when a user operation fails
 */
class IdentityUserException : IdentityException {
    int statusCode;
    
    this(string msg, int code = 0, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @safe {
        super(msg, file, line, nextInChain);
        this.statusCode = code;
    }
}

/**
 * Exception thrown when a group operation fails
 */
class IdentityGroupException : IdentityException {
    int statusCode;
    
    this(string msg, int code = 0, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @safe {
        super(msg, file, line, nextInChain);
        this.statusCode = code;
    }
}

/**
 * Exception thrown when validation fails
 */
class IdentityValidationException : IdentityException {
    string[] validationErrors;
    
    this(string msg, string[] errors = [], string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @safe {
        super(msg, file, line, nextInChain);
        this.validationErrors = errors;
    }
}

/**
 * Exception thrown when configuration is invalid
 */
class IdentityConfigurationException : IdentityException {
    this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @nogc @safe {
        super(msg, file, line, nextInChain);
    }
}

/**
 * Exception thrown when a resource is not found
 */
class IdentityNotFoundException : IdentityException {
    string resourceType;
    string resourceId;
    
    this(string msg, string resType = "", string resId = "", string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @safe {
        super(msg, file, line, nextInChain);
        this.resourceType = resType;
        this.resourceId = resId;
    }
}

/**
 * Exception thrown when rate limit is exceeded
 */
class IdentityRateLimitException : IdentityException {
    long retryAfter; // seconds
    
    this(string msg, long retry = 0, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @safe {
        super(msg, file, line, nextInChain);
        this.retryAfter = retry;
    }
}
